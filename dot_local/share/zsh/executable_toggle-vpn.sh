#!/bin/bash
# Switch to a selected Azure VPN Client connection using macOS Network Extension
# control (scutil --nc). Pass a VPN name/unique substring as argv, or pick with fzf.
set -uo pipefail

VPN_CONNECTIONS=(
  "az-vwan-bkx-pltfm-hub-np_az-hub-bkx-pltfm-hub-np"
  "az-vwan-bkx-pltfm-hub-np_az-vhub-bkx-connectivity-"
  "az-vwan-bkx-pltfm-hub-pre_az-hub-bkx-pltfm-hub-pre"
  "SCBX-Prod-AzureVPN"
  "dev-old"
)
VPN_ALIASES=(
  "dc-np"
  "dr-np"
  "dc-pre"
  "cmp"
  "dev-old"
)

LOG_FILE="${LOG_FILE:-$HOME/toggle-vpn.log}"
WAIT_TIMEOUT="${WAIT_TIMEOUT:-30}" # seconds to wait for a state change to take effect
VERBOSE=0

debug() {
  ((VERBOSE)) && printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_FILE"
  return 0
}

info() {
  printf '%s\n' "$*"
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  debug "ERROR: $*"
  debug "===== toggle-vpn.sh end (exit 1) ====="
  exit 1
}

run() {
  debug "+ $*"
  local out rc
  out="$("$@" 2>&1)"
  rc=$?
  if ((VERBOSE)) && [[ -n "$out" ]]; then
    debug "$out"
  elif ((rc != 0)) && [[ -n "$out" ]]; then
    printf '%s\n' "$out" >&2
  fi
  debug "  (exit $rc)"
  return $rc
}

usage() {
  cat <<EOF
Usage:
  $(basename "$0") [-v]                 # choose with fzf
  $(basename "$0") [-v] <vpn-choice>    # alias, exact name, or unique substring

Configured VPNs:
$(vpn_choices)
EOF
}

vpn_choices() {
  local i alias
  for i in "${!VPN_CONNECTIONS[@]}"; do
    alias="${VPN_ALIASES[$i]}"
    printf '  %-28s %s\n' "$alias" "${VPN_CONNECTIONS[$i]}"
  done
}

alias_for() {
  local name="$1" i
  for i in "${!VPN_CONNECTIONS[@]}"; do
    [[ "${VPN_CONNECTIONS[$i]}" == "$name" ]] && {
      printf '%s' "${VPN_ALIASES[$i]}"
      return 0
    }
  done
  printf '%s' "$name"
}

status_of() {
  local name="$1" out rc first_line
  out="$(scutil --nc status "$name" 2>&1)"
  rc=$?
  if ((rc != 0)); then
    printf 'ERROR'
    return 0
  fi
  IFS=$'\n' read -r first_line <<<"$out"
  printf '%s' "$first_line"
}

# Poll status_of() until it matches $2 (e.g. "Connected"/"Disconnected") or timeout.
wait_for_state() {
  local name="$1" want="$2" elapsed=0 cur
  while ((elapsed < WAIT_TIMEOUT)); do
    cur="$(status_of "$name")"
    debug "  waiting for [$name] to reach '$want' -> currently [$cur] (${elapsed}s)"
    [[ "$cur" == "$want" ]] && return 0
    sleep 2
    elapsed=$((elapsed + 2))
  done
  return 1
}

lower() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}

resolve_arg_choice() {
  local input="$1" input_lc i name name_lc alias alias_lc matches=()
  input_lc="$(lower "$input")"

  for i in "${!VPN_CONNECTIONS[@]}"; do
    name="${VPN_CONNECTIONS[$i]}"
    alias="${VPN_ALIASES[$i]}"
    if [[ "$alias" == "$input" || "$name" == "$input" ]]; then
      printf '%s' "$name"
      return 0
    fi
  done

  for i in "${!VPN_CONNECTIONS[@]}"; do
    name="${VPN_CONNECTIONS[$i]}"
    alias="${VPN_ALIASES[$i]}"
    name_lc="$(lower "$name")"
    alias_lc="$(lower "$alias")"
    if [[ "$alias_lc" == *"$input_lc"* || "$name_lc" == *"$input_lc"* ]]; then
      matches+=("$name")
    fi
  done

  case "${#matches[@]}" in
  0)
    debug "No configured VPN matches [$input]."
    usage
    return 1
    ;;
  1)
    printf '%s' "${matches[0]}"
    return 0
    ;;
  *)
    debug "Ambiguous VPN choice [$input]; matches:"
    printf '  %s\n' "${matches[@]}" >&2
    return 1
    ;;
  esac
}

choose_with_fzf() {
  command -v fzf >/dev/null 2>&1 || {
    debug "fzf is required when no VPN argument is provided."
    usage
    return 1
  }

  local selected
  selected="$(
    for i in "${!VPN_CONNECTIONS[@]}"; do
      name="${VPN_CONNECTIONS[$i]}"
      alias="${VPN_ALIASES[$i]}"
      printf '%s\t%s\t%s\n' "$(status_of "$name")" "$alias" "$name"
    done | fzf --delimiter=$'\t' --with-nth=2,3 --prompt='VPN> '
  )"

  [[ -n "$selected" ]] || return 1
  printf '%s' "${selected##*$'\t'}"
}

while (($# > 0)); do
  case "$1" in
  -v | --verbose)
    VERBOSE=1
    shift
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  --)
    shift
    break
    ;;
  -*)
    die "Unknown option [$1]."
    ;;
  *)
    break
    ;;
  esac
done

debug "===== toggle-vpn.sh start (pid $$) ====="
debug "configured VPNs:"
((VERBOSE)) && vpn_choices | tee -a "$LOG_FILE"

if (($# > 1)); then
  die "Expected zero args or one VPN choice; got $# args."
fi

if (($# == 1)); then
  target="$(resolve_arg_choice "$1")" || die "Could not resolve VPN choice [$1]."
else
  target="$(choose_with_fzf)" || die "No VPN selected."
fi

target_status="$(status_of "$target")"
[[ "$target_status" != "ERROR" ]] || die "Selected VPN [$target] did not resolve via scutil --nc status."

target_alias="$(alias_for "$target")"
debug "target=[$target] alias=[$target_alias] status=[$target_status]"

for conn in "${VPN_CONNECTIONS[@]}"; do
  [[ "$conn" == "$target" ]] && continue

  conn_status="$(status_of "$conn")"
  debug "other=[$conn] status=[$conn_status]"
  [[ "$conn_status" == "ERROR" ]] && continue

  run scutil --nc stop "$conn"
  if ! wait_for_state "$conn" "Disconnected"; then
    die "[$conn] did not reach Disconnected within ${WAIT_TIMEOUT}s"
  fi
done

if [[ "$target_status" == "Connected" ]]; then
  info "Already connected: $target_alias ($target)"
  debug "===== toggle-vpn.sh end (exit 0) ====="
  exit 0
fi

run scutil --nc start "$target"
if ! wait_for_state "$target" "Connected"; then
  info "Entra ID auth may be waiting in Azure VPN Client."
  die "[$target] did not reach Connected within ${WAIT_TIMEOUT}s"
fi

info "Connected: $target_alias ($target)"
debug "===== toggle-vpn.sh end (exit 0) ====="
