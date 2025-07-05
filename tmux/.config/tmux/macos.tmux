# Related: [issue #67](https://github.com/tmux-plugins/tpm/issues/67)
set-environment -g PATH "/opt/homebrew/bin:/bin:/usr/bin"

# Setting the namespace
set -g default-command "reattach-to-user-namespace -l /bin/zsh"

# Prefix C-c copy buffer to system clipboard
bind C-c run "tmux save-buffer - | reattach-to-user-namespace pbcopy"

# Prefix C-v paste system clipboard into tmux
bind C-v run "tmux set-buffer \"$(reattach-to-user-namespace pbpaste)\"; tmux paste-buffer"

bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
