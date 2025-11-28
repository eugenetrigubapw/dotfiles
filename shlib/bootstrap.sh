# shellcheck shell=sh
[ -n "${DOTFILES_BOOTSTRAP_LOADED}" ] && return
readonly DOTFILES_BOOTSTRAP_LOADED=1

. "$(dirname "$0")/shlib/homebrew.sh"
. "$(dirname "$0")/shlib/log.sh"
. "$(dirname "$0")/shlib/prompt.sh"

bootstrap_macos() {
  if ! homebrew_is_installed; then
    if prompt_for_confirmation "Homebrew not found. Would you like to install Homebrew?"; then
      homebrew_install
    else
      log_error "Cannot continue without homebrew installed."
      return 1
    fi
  fi

  log_info "Found homebrew installation. Installing Brewfile.."
  (cd macos/homebrew && brew bundle)
  log_info "Brewfile successfully installed. Moving to linking dotfiles.."

  sudo ln -sf "$HOME/bin/get-password" /usr/local/bin/get-password
  sudo ln -sf "$(which op)" /usr/local/bin/op
}

bootstrap_openbsd() {
  log_info "Installing OpenBSD packages..."
  _openbsd_packages="$(cat "$(dirname "$0")/openbsd/packages.txt" | tr '\n' ' ')"
  doas pkg_add $_openbsd_packages
  chsh -s /usr/local/bin/zsh "$USER"
}
