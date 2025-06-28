#!/bin/bash

# Create a new Brewfile with only manually installed formulae and casks
(
  echo 'tap "neovim/neovim"'
  echo 'tap "eugenetriguba/bolt"'
  brew bundle dump --file=- --force |
    (
      grep -E "^brew" | grep -f <(brew leaves)
      brew list --cask | sed 's/^/cask "/;s/$/"/'
    ) |
    sort
) >Brewfile

echo "Brewfile has been updated with only manually installed packages."
