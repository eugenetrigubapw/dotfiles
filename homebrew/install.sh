#!/bin/sh
set -e

echo "Installing Brewfile.."
brew bundle install --file=./Brewfile
echo "Brewfile successfully installed."
