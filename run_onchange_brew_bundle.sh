#!/bin/bash
read -rn 1 -p "Install packages with brew? [y/n] " ans
if [[ $ans =~ ^([Yy])$ ]]; then
	brew bundle --no-lock --file "~/.local/share/chezmoi/Brewfile"
fi

read -rn 1 -p "Enable syncthing service? [y/n] " ans
if [[ $ans =~ ^([Yy])$ ]]; then
	systemctl --user enable syncthing.service
	systemctl --user start syncthing.service
	# for dubugging: https://docs.syncthing.net/users/autostart.html#using-the-journal
	# journalctl -e --user-unit=syncthing.service
fi
