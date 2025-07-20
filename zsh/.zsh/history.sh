#!/usr/bin/env zsh

eval "$(atuin init zsh)"

# Disable zsh default history
unset HISTFILE
HISTSIZE=0
SAVEHIST=0
