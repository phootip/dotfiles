# helm version2
export PATH="/usr/local/opt/helm@2/bin:$PATH"
# K8S aliases
source $HOME/.dotfiles/k8s/kubectl_aliases.sh
source /usr/local/opt/kube-ps1/share/kube-ps1.sh
RPROMPT=$RPROMPT'$(kube_ps1)'
alias kc='kubectx '
alias kn='kubens '

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/phootip/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/phootip/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/phootip/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/phootip/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
