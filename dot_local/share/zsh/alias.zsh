alias reload_shell='source ~/.zshrc'
alias watch='watch '
alias ll='ls -lh'
alias la='ls -lAh'
alias f='cd $(find -maxdepth 4 -type d | fzf)'
alias cd='z'
alias pwr='echo "${PWD/#$HOME/~}"'
lsr() { for f in "${1:-.}"/*(N); do echo "${${f:A}/#$HOME/~}"; done }

# nvim
export EDITOR="nvim"
export NVIM_APPNAME="lazyvim"
alias loadnvm="source $NVM_DIR/nvm.sh"
# alias nvim="NVIM_APPNAME=lazyvim nvim"
alias v="NVIM_APPNAME=lazyvim nvim -c 'lua require(\"persistence\").load()'"
alias vr="NVIM_APPNAME=lazyvim nvim"
alias vt="NVIM_APPNAME=lazyvim nvim -c 'hi Normal guifg=#dcd7ba guibg=#00001a | terminal'"
alias tv="NVIM_APPNAME=testnvim nvim"
export PATH=~/.local/bin:$PATH

# lazygit
export XDG_CONFIG_HOME="$HOME/.config"
alias g="lazygit"
alias d="lazydocker"

# tmux
# export LC_ALL="en_US.UTF-8"
# alias tmux="tmux -u"
alias t="tmux"
ta() {
    if [ -n "$TMUX" ]; then
        echo "already in tmux"
    else
        # cd ~/phootip  && tmux new -As phootip
        cd ~/.local/share/chezmoi  && tmux new -As chezmoi
    fi
}
alias tk="tmux kill-server"
alias mux="tmuxinator"

# ranger
# export LC_ALL=C
# https://github.com/microsoft/WSL/issues/1620
function ranger () { command ranger "$@"; echo -e "\e[?25h"; }
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

## Works
# terraform
alias tf='terraform'
# alias tf='tofu'
alias tfi='tf init'
alias tfib='tf init -backend-config'
alias tfp='tf plan -lock=false -out=changes.tfplan'
tfpe() {
  local env=$1
  shift
  tf plan -lock=false -out=changes.tfplan -var-file terraform.$env.tfvars "$@"
}
# tfie() {
#   tf init -backend-config=azure.$1.tfbackend
# } 
tfie() {
  local env=$1
  shift
  tf init -backend-config=backend.$env.config "$@"
} 

tfire() {
  local env=$1
  shift
  tf init -reconfigure -backend-config=backend.$env.config "$@"
} 

tfime() {
  local env=$1
  shift
  tf import -var-file terraform.$env.tfvars "$@"
} 



yf() {
  local result=$(eval "$@" | fzf | awk '{print $1}' | tr -d '\n')
  echo -n "$result" | if [[ "$OSTYPE" == "darwin"* ]]; then pbcopy; else xclip -selection clipboard; fi
}

alias tfa='tf apply changes.tfplan'
alias tfs='tf state'
alias tfsl='tf state list'
alias tfss='tf state show'
# terragrunt
alias tg='terragrunt'
alias tgi='terragrunt init'
alias tgp='terragrunt plan -lock=false -out=changes.tfplan'
alias tgs='terragrunt state'
alias tgss='terragrunt state show'
alias tgsl='terragrunt state list'
alias tga='terragrunt apply changes.tfplan'
alias tgpa='terragrunt run-all plan -lock=false -out=changes.tfplan'
alias tgap='terragrunt run-all plan -lock=false -out=changes.tfplan'
alias tgaa='terragrunt run-all apply changes.tfplan'
# azure
alias azl='az account show -o table'
alias azl='az account list --query "[?isDefault==\`true\`]" -o table'
alias azs='az account set --subscription'
# kube
alias first_pod="kgpo | head -2 | tail -1 | cut -d ' ' -f1"
alias kn="kubens"
alias kc="kubectx"
kgpof() {
  kgpol app=$1 | head -2 | tail -1 | cut -d ' ' -f1
}
kexf() {
  POD=$(kgpof $1)
  kex $POD -- sh
}
klof() {
  POD=$(kgpof $1)
  klo $POD
}
unalias kd 2>/dev/null
kd() {
  # Pass-through: if second arg looks like a resource name (not a flag), describe directly
  if [[ $# -ge 2 && "$2" != -* ]]; then
    kubectl describe "$@"
    return
  fi

  local resource_type="${1:-pod}"

  local selection
  selection=$(kubectl get "$resource_type" --no-headers 2>/dev/null | fzf --header="Select $resource_type") || return

  local name=$(awk '{print $1}' <<< "$selection")
  kubectl describe "$resource_type" "$name"
}
unalias klo 2>/dev/null
klo() {
  if [[ $# -gt 0 && "$1" != -* ]]; then
    kubectl logs -f "$@"
    return
  fi

  local selection
  selection=$(kubectl get pods --no-headers \
    -o custom-columns="NAME:.metadata.name,READY:.status.containerStatuses[*].ready,STATUS:.status.phase" \
    2>/dev/null | fzf --header="Select pod") || return

  local pod=$(awk '{print $1}' <<< "$selection")
  local containers=($(kubectl get pod "$pod" \
    -o jsonpath='{.spec.containers[*].name}' 2>/dev/null))

  if [[ ${#containers[@]} -gt 1 ]]; then
    local container
    container=$(printf '%s\n' "${containers[@]}" | fzf --header="Select container") || return
    kubectl logs -f "$pod" -c "$container" "$@"
  else
    kubectl logs -f "$pod" "$@"
  fi
}
kloall() {
  local selection
  selection=$(kubectl get pods --all-namespaces --no-headers \
    -o custom-columns="NS:.metadata.namespace,NAME:.metadata.name,READY:.status.containerStatuses[*].ready,STATUS:.status.phase" \
    2>/dev/null | fzf --header="Select pod (all namespaces)") || return

  local ns=$(awk '{print $1}' <<< "$selection")
  local pod=$(awk '{print $2}' <<< "$selection")
  local containers=($(kubectl get pod "$pod" -n "$ns" \
    -o jsonpath='{.spec.containers[*].name}' 2>/dev/null))

  if [[ ${#containers[@]} -gt 1 ]]; then
    local container
    container=$(printf '%s\n' "${containers[@]}" | fzf --header="Select container") || return
    kubectl logs -f -n "$ns" "$pod" -c "$container"
  else
    kubectl logs -f -n "$ns" "$pod"
  fi
}
tmux_color() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
  done
}
# https://unix.stackexchange.com/questions/236094/how-to-remove-the-last-command-or-current-command-for-bonus-from-zsh-history
#

alias bwa='rbw add --folder 7peaks'
alias bwl=$'rbw list --raw | jq \'.[] | select(.folder == "7peaks") | {folder,name,user}\' | mlr --j2p --barred cat'
