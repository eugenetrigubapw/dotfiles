#!/bin/sh
set -e

. "$(dirname "$0")/shlib/bootstrap.sh"
. "$(dirname "$0")/shlib/log.sh"
. "$(dirname "$0")/shlib/os.sh"
. "$(dirname "$0")/shlib/tmux.sh"

main() {
  if os_is_macos; then
    if ! bootstrap_macos; then
      log_error "Failed to bootstrap install script"
      exit 1
    fi
  elif os_is_linux; then
    if ! bootstrap_linux; then
      log_error "Failed to bootstrap install script"
      exit 1
    fi
  else
    log_error "Unexpected OS: $(os_print)"
    exit 1
  fi

  stow executables
  stow nvim
  stow zsh
  stow git
  stow gpg
  stow tmux
  stow ghostty
  stow aerc
  stow isync
  stow msmtp
  stow atuin
  stow lazygit
  log_success "Successfully linked all dotfiles."

  mkdir -p ~/Mail/Gmail/INBOX ~/Mail/iCloud/INBOX ~/bin/ ~/src/

  log_info "Initializing TPM (Tmux Plugin Manager)..."
  if ! tmux_setup_tpm; then
    log_error "Failed to setup tpm"
    exit 1
  fi
  log_success "Setup complete!"
}

main "$@"
