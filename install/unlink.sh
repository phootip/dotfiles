#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles

echo -e "\\nRemoving symlinks"
echo "=============================="
# linkables=$( cat $DOTFILES/install/link.txt )
linkables=$( cat install/link.txt )
for file in $linkables ; do
  target="$HOME/$( basename "$file" )"
  if [ -L "$target" ]; then
    echo "~${target#$HOME} Unlinking..."
    unlink "$target"
  fi
done
unlink ~/.dotfiles
#TODO: implement unlink
