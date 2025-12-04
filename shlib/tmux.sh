# shellcheck shell=sh
[ -n "${DOTFILES_TMUX_LOADED}" ] && return
readonly DOTFILES_TMUX_LOADED=1

. "$(dirname "$0")/shlib/log.sh"

tmux_setup_tpm() {
  (
    tpm_dir="$HOME/.config/tpm/plugins/tpm"
    if [ ! -d "$tpm_dir" ]; then
      log_info "Cloning TPM..."
      if ! git clone https://github.com/tmux-plugins/tpm "$tpm_dir"; then
        log_error "Failed to clone tpm to $tpm_dir"
        return 1
      fi
    else
      log_info "TPM already exists, updating..."
      (cd "$tpm_dir" && git pull)
    fi

    if command -v tmux >/dev/null 2>&1; then
      log_info "Installing tmux plugins..."
      "$tpm_dir/scripts/install_plugins.sh"
      log_info "TPM plugins installed successfully."
    else
      log_warn "tmux not found. TPM cloned but plugins not installed."
      log_warn "Run 'tmux' and then press 'prefix + I' to install plugins manually."
    fi
  )
}
