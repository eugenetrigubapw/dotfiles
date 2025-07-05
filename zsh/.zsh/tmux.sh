#!/usr/bin/env zsh
#
if [[ -z "$TMUX" ]]; then
  tmux attach-session -t "$USER" || tmux new-session -s "$USER"
fi
