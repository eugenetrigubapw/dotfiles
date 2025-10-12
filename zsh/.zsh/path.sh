#!/usr/bin/env zsh

export PATH="$BIN_DIR:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

export PATH="/opt/homebrew/opt/openjdk@24/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@24/include"
