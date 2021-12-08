#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles

echo -e "\\nCreating symlinks"
echo "=============================="

if ! [[ -d $HOME/.dotfiles ]]; then
    echo "Linking .dotfiles"
    ln -s `(pwd)` ~/.dotfiles
fi

linkables=$( cat $DOTFILES/install/link.txt )
for file in $linkables ; do
    target="$HOME/$( basename "$file" )"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s "$DOTFILES/$file" "$target"
    fi
done

echo -e "\\n\\ninstalling to ~/.config"
echo "=============================="
if [ ! -d "$HOME/.config" ]; then
    echo "Creating ~/.config"
    mkdir -p "$HOME/.config"
    ln -s "$DOTFILE/config" "$HOME/.config/config"
fi

touch $HOME/.dotfiles/zsh/local.zsh
