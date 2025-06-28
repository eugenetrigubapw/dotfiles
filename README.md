# Dotfiles

These are my personal dotfiles for macOS systems.

All configuration files are managed using [GNU Stow](https://www.gnu.org/software/stow/), which automatically creates symlinks from this repository to the appropriate locations in your `$HOME` directory. The repository also includes scripts for managing and syncing your Homebrew packages via a Brewfile.

## Installation

Clone the repository (recommended: `~/.dotfiles`) and run the installation script:

```sh
git clone git@github.com:eugenetriguba/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod u+x install.sh
./install.sh
```

## Homebrew Packages

To update your `homebrew/Brewfile` with your currently installed Homebrew formulae and casks, run:

```sh
chmod u+x homebrew/sync-brewfile.sh
./homebrew/sync-brewfile.sh
```

This script only updates the `homebrew/Brewfile` with your current manually installed Homebrew packages; it does not install or remove any packages. You can then use `git diff` to review the changes.

