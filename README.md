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
# for short live session
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot $GITHUB_USERNAME
```

## To update email

```bash
chezmoi init --prompt
```

## Remote Atuin

```bash
# install
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
atuin login
```
