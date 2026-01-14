alias reload_shell='source ~/.zshrc'
alias watch='watch '
alias ll='ls -lh'
alias la='ls -lAh'
alias f='cd $(find -maxdepth 4 -type d | fzf)'
alias cd='z'

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
tmux_color() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
  done
}
# https://unix.stackexchange.com/questions/236094/how-to-remove-the-last-command-or-current-command-for-bonus-from-zsh-history
#

alias bwa='rbw add --folder 7peaks'
alias bwl=$'rbw list --raw | jq \'.[] | select(.folder == "7peaks") | {folder,name,user}\' | mlr --j2p --barred cat'
