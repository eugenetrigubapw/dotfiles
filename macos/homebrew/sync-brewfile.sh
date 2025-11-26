#!/bin/bash
set -eou pipefail

# Create a new Brewfile with only manually installed formulae and casks
(
  echo 'tap "neovim/neovim"'
  echo 'tap "eugenetriguba/bolt", "https://git.sr.ht/~eugenetriguba/homebrew-bolt"'
  echo 'tap "eugenetriguba/justify", "https://git.sr.ht/~eugenetriguba/homebrew-justify"'
  brew bundle dump --file=- --force |
    (
      grep -E "^brew" | grep -f <(brew leaves)
      brew list --cask | sed 's/^/cask "/;s/$/"/'
    ) |
    sort
) >Brewfile

echo "Brewfile has been updated with only manually installed packages."
