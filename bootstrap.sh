#!/bin/sh

function install_homebrew() {
    /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

    homebrew_exists=$(command -v brew)
    if test -z "$homebrew_exists"; then
        echo "Failed to install homebrew"
        exit 1
    fi
}

has_homebrew=$(command -v brew)
if test -z "$has_homebrew"; then
    printf "I couldn't find a homebrew installation. Would you like to install homebrew? [y/n]: "
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        install_homebrew
    else
        echo "Exiting, can't continue without homebrew installed."
        exit 0
    fi
fi

echo "Found homebrew installation. Installing Brewfile.."
brew bundle
