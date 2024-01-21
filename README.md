# Dotfiles with [chezmoi](https://www.chezmoi.io/)

## Prerequisite

- curl
- brew

## Installation

```bash
export GITHUB_USERNAME=phootip
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi # mac + linux
choco install chezmoi # windows
sh -c "$(curl -fsLS get.chezmoi.io)" # curl

chezmoi init --apply $GITHUB_USERNAME
```
