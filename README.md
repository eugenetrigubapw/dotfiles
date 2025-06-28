# Dotfiles

These are my personal dotfiles that I use on all my macOS systems.

They're managed by [GNU Stow](https://www.gnu.org/software/stow/). That is the tool that sets up the symlinks from the files in this repo here to where they belong in `$HOME`. Furthermore, included are scripts to syncing and install a Brewfile.

## Installation

Clone the repository (recommended: `~/.dotfiles`) and run the installation script:

```sh
git clone git@github.com:eugenetriguba/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod u+x install.sh
./install.sh
```

## Homebrew Packages

To sync your manually installed Homebrew formulae and casks, use:

```sh
chmod u+x homebrew/sync-brewfile.sh
./homebrew/sync-brewfile.sh
```

This will update `homebrew/Brewfile` with your current manually installed Homebrew packages (it does not install or remove any packages). You can then run `git diff` to review the changes.

