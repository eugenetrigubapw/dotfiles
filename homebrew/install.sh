#!/usr/bin/env bash
set -euo pipefail

echo "Installing Brewfile.."
brew bundle install --file=./Brewfile
echo "Brewfile successfully installed."
