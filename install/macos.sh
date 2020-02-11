#!/usr/bin/env bash

echo -e "\\n\\nRunning on macOS"

if test ! "$( command -v brew )"; then
    echo "Installing homebrew"
    ruby -e "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install )"
fi

# install brew dependencies from Brewfile
brew bundle

source install/subinstall/mac_config.sh
