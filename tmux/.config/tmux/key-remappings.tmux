# Remap prefix from 'C-b' to 'C-a'
#
# This works well if you remap the regular Caps Lock key to Ctrl.
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Remap pane splits to something more sane than the default.
# 
# Split panes using | for horizontal splits and - for vertical splits
bind-key | split-window -h -c "#{pane_current_path}"
bind-key - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %
bind-key c new-window -c "#{pane_current_path}"

# Easier configuration reloading and pane killing
bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
bind-key x kill-pane
