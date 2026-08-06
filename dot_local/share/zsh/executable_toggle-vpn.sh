#!/bin/bash
# Toggle between two Azure VPN Client connections using macOS's built-in
# Network Extension control (scutil --nc). No GUI automation needed.
set -uo pipefail

CONN_A="az-vwan-bkx-pltfm-hub-np_az-hub-bkx-pltfm-hub-np"
CONN_B="az-vwan-bkx-pltfm-hub-np_az-vhub-bkx-connectivity-"

LOG_FILE="${LOG_FILE:-$HOME/toggle-vpn.log}"
WAIT_TIMEOUT="${WAIT_TIMEOUT:-30}" # seconds to wait for a state change to take effect

log() {
  printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_FILE"
}

run() {
  log "+ $*"
  local out rc
  out="$("$@" 2>&1)"
  rc=$?
  if [[ -n "$out" ]]; then
    log "$out"
  fi
  log "  (exit $rc)"
  return $rc
}

status_of() {
  local name="$1" out rc
  out="$(scutil --nc status "$name" 2>&1)"
  rc=$?
  if ((rc != 0)); then
    printf 'ERROR'
    return 0
  fi
  printf '%s' "$(head -n1 <<<"$out")"
}

# Poll status_of() until it matches $2 (e.g. "Connected"/"Disconnected") or timeout.
wait_for_state() {
  local name="$1" want="$2" elapsed=0 cur
  while ((elapsed < WAIT_TIMEOUT)); do
    cur="$(status_of "$name")"
    log "  waiting for [$name] to reach '$want' -> currently [$cur] (${elapsed}s)"
    [[ "$cur" == "$want" ]] && return 0
    sleep 2
    elapsed=$((elapsed + 2))
  done
  return 1
}

log "===== toggle-vpn.sh start (pid $$) ====="
log "CONN_A=$CONN_A"
log "CONN_B=$CONN_B"

a_status="$(status_of "$CONN_A")"
b_status="$(status_of "$CONN_B")"
log "a_status=[$a_status] b_status=[$b_status]"

if [[ "$a_status" == "ERROR" || "$b_status" == "ERROR" ]]; then
  log "One of the connection names did not resolve via scutil --nc status."
  log "Run 'scutil --nc list' and compare exact names against CONN_A/CONN_B above."
  log "===== toggle-vpn.sh end (exit 2) ====="
  exit 2
fi

# Pick target = the one NOT connected. If A is connected (regardless of B's
# state), target B. Otherwise target A. This also self-heals the "both
# connected" state left over from earlier failed toggles.
if [[ "$a_status" == "Connected" ]]; then
  target="$CONN_B"
  other="$CONN_A"
else
  target="$CONN_A"
  other="$CONN_B"
fi
log "target=[$target] other=[$other]"

# Always stop the "other" one unconditionally (idempotent if already down) —
# this is what actually cleans up the both-connected case.
run scutil --nc stop "$other"
if ! wait_for_state "$other" "Disconnected"; then
  log "ERROR: [$other] did not reach Disconnected within ${WAIT_TIMEOUT}s"
  log "===== toggle-vpn.sh end (exit 1) ====="
  exit 1
fi

run scutil --nc start "$target"
if ! wait_for_state "$target" "Connected"; then
  log "ERROR: [$target] did not reach Connected within ${WAIT_TIMEOUT}s"
  log "This is often an Entra ID auth prompt waiting in the Azure VPN Client app — check it."
  log "===== toggle-vpn.sh end (exit 1) ====="
  exit 1
fi

log "Toggle successful: now connected to [$target]"
run scutil --nc list
log "===== toggle-vpn.sh end (exit 0) ====="
