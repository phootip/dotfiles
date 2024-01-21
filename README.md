# Dotfiles with [chezmoi](https://www.chezmoi.io/)

```bash
export GITHUB_USERNAME=phootip
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi # mac + linux

choco install chezmoi # windows
# or 
sh -c "$(curl -fsLS get.chezmoi.io)"
# then, add chezmoi to PATH

chezmoi init --apply $GITHUB_USERNAME

# set git global email
git config --global user.email "{email}"
```
