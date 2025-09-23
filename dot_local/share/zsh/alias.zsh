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
alias vim="nvim"
# alias nvim="NVIM_APPNAME=lazyvim nvim"
alias v="NVIM_APPNAME=lazyvim nvim -c 'SessionRestore'"
alias vt="NVIM_APPNAME=lazyvim nvim -c 'hi Normal guifg=#dcd7ba guibg=#293036 | terminal'"
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
        cd ~/phootip  && tmux new -As phootip
    fi
}
alias tk="tmux kill-server"
alias mux="tmuxinator"

# ranger
# export LC_ALL=C
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias r='ranger'

## Works
# terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfib='terraform init -backend-config'
alias tfp='terraform plan -lock=false -out=changes.plan'
tfpe() {
  terraform plan -lock=false -out=changes.plan -var-file variables.$1.tfvars
}
tfie() {
  terraform init -backend-config=azure.$1.tfbackend
} 
alias tfa='terraform apply changes.plan'
alias tfsl='terraform state list'
alias tfss='terraform state show'
# terragrunt
alias tg='terragrunt'
alias tgi='terragrunt init'
alias tgp='terragrunt plan -lock=false -out=changes.plan'
alias tgs='terragrunt state'
alias tgss='terragrunt state show'
alias tgsl='terragrunt state list'
alias tga='terragrunt apply changes.plan'
alias tgpa='terragrunt run-all plan -lock=false -out=changes.plan'
alias tgap='terragrunt run-all plan -lock=false -out=changes.plan'
alias tgaa='terragrunt run-all apply changes.plan'
# azure
alias azl='az account show -o table'
alias azl='az account list --query "[?isDefault==\`true\`]" -o table'
alias azs='az account set --subscription'
# kube
alias first_pod="kgpo | head -2 | tail -1 | cut -d ' ' -f1"
tmux_color() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
  done
}
# https://unix.stackexchange.com/questions/236094/how-to-remove-the-last-command-or-current-command-for-bonus-from-zsh-history
#

alias bwa='rbw add --folder 7peaks'
alias bwl=$'rbw list --raw | jq \'.[] | select(.folder == "7peaks") | {folder,name,user}\' | mlr --j2p --barred cat'
