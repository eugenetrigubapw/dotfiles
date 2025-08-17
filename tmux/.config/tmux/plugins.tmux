# Plugin manager
set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.config/tmux/plugins/"
set-option -g @plugin 'tmux-plugins/tpm'

# 'Sensible' set of defaults
set-option -g @plugin 'tmux-plugins/tmux-sensible'

# Tmux FZF is a plugin that integrates FZF with tmux
TMUX_FZF_ORDER="session|window|pane|command|keybinding"
TMUX_FZF_OPTIONS="-p -w 90% -h 70% -m"
set-option -g @plugin 'sainnhe/tmux-fzf'

# Resurrect is a plugin that saves and restores tmux sessions
set-option -g @plugin 'tmux-plugins/tmux-resurrect'
set-option -g @resurrect-save 'S'
set-option -g @resurrect-restore 'R'

# Continuum is a plugin that automatically saves tmux sessions
# at regular intervals
set-option -g @plugin 'tmux-plugins/tmux-continuum'
set-option -g @continuum-restore 'on'
set-option -g @continuum-save-interval '15'
set-option -g @resurrect-strategy-nvim 'session'

# Vim Tmux Navigator allows you to navigate between Vim and tmux panes
set-option -g @plugin 'christoomey/vim-tmux-navigator'

set-option -g @plugin 'tmux-plugins/tmux-yank'
set-option -g @plugin 'tmux-plugins/tmux-open'

set-option -g @plugin "janoamaral/tokyo-night-tmux"
set -g @tokyo-night-tmux_theme night
set -g @tokyo-night-tmux_transparent 1
set -g @tokyo-night-tmux_window_id_style digital
set -g @tokyo-night-tmux_pane_id_style hsquare
set -g @tokyo-night-tmux_zoom_id_style dsquare
set -g @tokyo-night-tmux_terminal_icon 
set -g @tokyo-night-tmux_active_terminal_icon 
set -g @tokyo-night-tmux_window_tidy_icons 1
set -g @tokyo-night-tmux_show_datetime 1
set -g @tokyo-night-tmux_date_format YMD
set -g @tokyo-night-tmux_time_format 24H
set -g @tokyo-night-tmux_show_git 0

set -g @plugin 'git.sr.ht/~eugenetriguba/tmux-toggle-term'

run '$HOME/.config/tmux/plugins/tpm/tpm'
