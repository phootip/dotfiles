alias reload_shell='source ~/.zshrc'
alias watch='watch '
alias ll='ls -lh'
alias la='ls -lAh'
alias f='cd $(find -maxdepth 4 -type d | fzf)'
alias cd='z'

# nvim
export EDITOR="nvim"
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
alias tfi='terraform init -backend-config=./backend.tfvars'
alias tfp='terraform plan -lock=false -out=changes.plan'
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
alias forget=' my_remove_last_history_entry'
my_remove_last_history_entry() {
  is_int() (return $(test "$@" -eq "$@" >/dev/null 2>&1))
  history_file="${HOME}/.zsh_history"
  history_temp_file="${history_file}.tmp"
  line_cout=$(wc -l $history_file | awk '{print $1;}')
  lines_to_remove=1
  if [ $# -eq 0 ]; then
    lines_to_remove=1
  else
    if $(is_int "${1}"); then
      lines_to_remove="$1"
    else
      echo "Unknown argument passed. Exiting..."
      return
    fi
  fi
  lines_to_remove=$(($line_cout - $lines_to_remove))
  echo $lines_to_remove
  fc -W
  cat $history_file | head -n "${lines_to_remove}" &>$history_temp_file
  mv "$history_temp_file" "$history_file"
  fc -R
}
