#!/usr/bin/env bash

# DOTFILES=$HOME/.dotfiles
DOTFILES=../.

echo -e "\\nRemoving symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
  target="$HOME/.$( basename "$file" '.symlink' )"
  if [ -L "$target" ]; then
    echo "~${target#$HOME} already exists... Skipping."
    unlink "$target"
  fi
done

#TODO: implement unlink
