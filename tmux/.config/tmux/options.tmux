# Don't rename windows automatically.
#
# I often will use the `,` key to rename windows.
# However, by default, tmux will update the window
# title to the last executed command.
set-option -g allow-rename off

# Enable mouse support (clickable windows, panes, resizable panes)
set-option -g mouse on

# Enable system clipboard integration (macOS)
set-option -g set-clipboard on

# Allow focus events (for editors like Neovim)
set -g focus-events on

# Start windows and panes at 1, not 0
set-option -g base-index 1
set-option -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# Don't do anything when a 'bell' rings
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

# Enable hyperlinks
set-option -as terminal-features ",*:hyperlinks"

# Enable true color support
set -ga terminal-overrides ",*256col*:Tc"
set -ga terminal-overrides ",tmux-256color:Tc"

set -g default-terminal "tmux-256color"
set -g default-shell /bin/zsh
