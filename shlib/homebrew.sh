# shellcheck shell=sh
[ -n "${DOTFILES_HOMEBREW_LOADED}" ] && return
readonly DOTFILES_HOMEBREW_LOADED=1

homebrew_is_installed() {
  command -v brew >/dev/null 2>&1
}

# Installs homebrew and verifies the installation.
#
# If the install was not successful, exits with a
# 1 status code.
homebrew_install() {
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  if ! command -v brew >/dev/null 2>&1; then
    echo "Failed to install homebrew"
    return 1
  fi
}
