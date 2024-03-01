#!/bin/bash
read -rn 1 -p "Install packages with brew? [y/n] " ans
if [[ $ans =~ ^([Yy])$ ]]; then
	brew bundle --no-lock --file "~/.local/share/chezmoi/Brewfile"
fi
