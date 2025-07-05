# Remap prefix from 'C-b' to 'C-a'
#
# This works well if you remap the regular Caps Lock key to Ctrl.
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Remap pane splits.
# 
# Split panes using | for horizontal splits and - for vertical splits
bind-key | split-window -h
bind-key - split-window -v
unbind '"'
unbind %

bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
bind-key x kill-pane

bind-key -n 'C-t' run-shell -b "${HOME}/bin/tmux-toggle-term"
bind-key -n 'C-f' run-shell -b "${HOME}/bin/tmux-toggle-term float"

