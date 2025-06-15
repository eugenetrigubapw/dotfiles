#!/bin/sh
#
# Install the Homebrew Brewfile and setup symbolic links to the
# dotfiles.
#

# Installs homebrew and verifies the installation.
# If the install was not successful, exits with a
# 1 status code.
install_homebrew() {
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  homebrew_exists=$(command -v brew)
  if test -z "$homebrew_exists"; then
    echo "Failed to install homebrew"
    exit 1
  fi
}

# Prompt the user for confirmation on an action.
#
# Args:
#   $1: The question to prompt for. Answer choices
#      will be added onto the end.
#
# Returns:
#   0 on yes. 1 on no.
prompt_for_confirmation() {
  printf "%s [y/n]: " "$1"
  read -r answer
  if [ "$answer" != "${answer#[Yy]}" ]; then
    return 0
  else
    return 1
  fi
}

ensure_symlink_exists() {
  source_path="$1"
  link_path="$2"

  echo "Checking link to '$link_path'.."
  if [ -L "$link_path" ]; then
    if [ -e "$link_path" ]; then
      echo "Valid '$link_path' link exists."
    else
      echo "'$link_path' link exists, but it is a broken link."
      prompt_for_confirmation "Delete and relink?"
      answer=$?
      if [ $answer -eq 0 ]; then
        rm -r "$link_path" || exit 1
        ln -s "$source_path" "$link_path" || exit 1
        echo "Successfully created link to '$link_path'"
      else
        echo "Leaving file alone, moving on.."
      fi
    fi
  elif [ -e "$link_path" ]; then
    echo "'$link_path' exists, but it isn't a symbolic link file."
    prompt_for_confirmation "Delete and relink?"
    answer=$?
    if [ $answer -eq 0 ]; then
      rm -r "$link_path" || exit 1
      ln -s "$source_path" "$link_path" || exit 1
      echo "Successfully created link to '$link_path'"
    else
      echo "Leaving file alone, moving on.."
    fi
  else
    echo "Link to '$link_path' does not exist. Creating.."
    ln -s "$source_path" "$link_path" || exit 1
  fi
}

main() {
  has_homebrew=$(command -v brew)
  if test -z "$has_homebrew"; then
    prompt_for_confirmation "I couldn't find a homebrew installation. Would you like to install homebrew?"
    answer=$?
    if [ $answer -eq 0 ]; then
      install_homebrew
    else
      echo "Exiting, can't continue without homebrew installed."
      exit 0
    fi
  fi

  echo "Found homebrew installation. Installing Brewfile.."
  (cd homebrew && brew bundle || exit 1)
  echo "Brewfile successfully installed. Moving to linking dotfiles.."

  stow executables
  stow nvim
  stow zsh
  stow git
  stow gpg
  stow tmux
  stow ghostty
  echo "Successfully linked all dotfiles."
}

main
