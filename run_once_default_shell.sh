#!/bin/bash
if ! [[ -x "$(command -v zsh)" ]]; then
  echo "zsh not found. Please install and then re-run installation scripts"
  exit 1
fi

read -rn 1 -p "Set zsh to default shell? [y/n] " ans
if [[ $ans =~ ^([Yy])$ ]]; then
  command -v zsh | sudo tee -a /etc/shells
  chsh -s $(which zsh)
fi
