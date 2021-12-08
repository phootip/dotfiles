# zmodload zsh/zprof
# WSL permission sucks
umask 022
HISTSIZE=SAVEHIST=50000
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
# load antigen
source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh
antigen theme denysdovhan/spaceship-prompt
antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure
antigen bundle git
antigen bundle colored-man-pages
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle skywind3000/z.lua
antigen apply

export LANG=en_US.UTF-8

# source configuration
source "$HOME/.dotfiles/zsh/bindkey.zsh"
source "$HOME/.dotfiles/zsh/alias.zsh"
source "$HOME/.dotfiles/zsh/prompt.zsh"
source "$HOME/.dotfiles/zsh/local.zsh"
# PM (project manager) functions
source "$HOME/.dotfiles/pm/pmzsh.sh"
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye

[[ -s "/Users/phootip/.gvm/scripts/gvm" ]] && source "/Users/phootip/.gvm/scripts/gvm"
