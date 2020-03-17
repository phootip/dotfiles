#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

# source install/backup.sh
source install/link.sh

# only perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    read -rn 1 -p "Setup brew and other Mac configurations? [y/N] " ans
    if [[ $ans =~ ^([Yy])$ ]]; then
        source install/macos.sh
    fi
    # source install/macos.sh
fi

# only perform Linux-specific install
if [ "$(uname)" == "Linux" ]; then
    read -rn 1 -p "Setup apt-get and other Linux configurations? [y/N] " ans
    if [[ $ans =~ ^([Yy])$ ]]; then
        source install/linux.sh
    fi
    # source install/macos.sh
fi

echo -e "\\nGeneral Install"
echo "=============================="

# echo "creating vim directories"
# mkdir -p ~/.vim-tmp

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s "$(command -v zsh)"
fi

# Change the default shell to zsh
zsh_path="$( command -v zsh )"
if ! grep "$zsh_path" /etc/shells; then
    echo "adding $zsh_path to /etc/shells"
    echo "$zsh_path" | sudo tee -a /etc/shells
fi
if [[ "$SHELL" != "$zsh_path" ]]; then
    chsh -s "$zsh_path"
    echo "default shell changed to $zsh_path"
fi

# install with Vundle
if ! [[ -d $HOME/.vim/bundle/Vundle.vim ]]; then
    echo "No Vundle, installing..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

echo "Sadly you have to setup your termianl and fonts (for now)"
echo "for Windows https://medium.com/@jrcharney/bash-on-ubuntu-on-windows-the-almost-complete-set-up-1dd3cb89b794"
echo "Done. Reload your terminal."
