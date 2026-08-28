# VPN control via scutil (macOS network services)
# Usage: vpn [on|off|status]

_vpn_services() {
  echo "az-vwan-bkx-pltfm-hub-np_az-hub-bkx-pltfm-hub-np"
  echo "SCBX-Prod-AzureVPN"
  echo "dev-vwan_dev-we-secured-hub"
}

_vpn_status() {
  scutil --nc status "$1" 2>/dev/null | head -1
}

_vpn_disconnect_others() {
  local target=$1
  _vpn_services | while read -r svc; do
    [[ "$svc" == "$target" ]] && continue
    if [[ "$(_vpn_status "$svc")" == "Connected" ]]; then
      scutil --nc stop "$svc"
      echo "Disconnected: $svc"
    fi
  done
  return 0
}

vpn() {
  local action=${1:-}

  case "$action" in
    on|connect)
      local svc=${2:-$(_vpn_services | fzf --prompt="Connect> ")}
      [[ -z "$svc" ]] && return 1
      _vpn_disconnect_others "$svc"
      echo "Connecting: $svc"
      scutil --nc start "$svc"
      ;;
    off|disconnect)
      local svc=${2:-$(_vpn_services | fzf --prompt="Disconnect> ")}
      [[ -z "$svc" ]] && return 1
      echo "Disconnecting: $svc"
      scutil --nc stop "$svc"
      ;;
    status)
      _vpn_services | while read -r svc; do
        printf "%-40s %s\n" "$svc" "$(_vpn_status "$svc")"
      done
      ;;
    *)
      local svc
      svc=$(_vpn_services | fzf --prompt="VPN> " --preview='scutil --nc status {} 2>/dev/null | head -1')
      [[ -z "$svc" ]] && return 0
      local vpn_status=$(_vpn_status "$svc")
      if [[ "$vpn_status" == "Connected" ]]; then
        echo "Disconnecting: $svc"
        scutil --nc stop "$svc"
      else
        _vpn_disconnect_others "$svc"
        echo "Connecting: $svc"
        scutil --nc start "$svc"
      fi
      ;;
  esac
}
