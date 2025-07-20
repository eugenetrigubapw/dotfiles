#!/usr/bin/env bash
#
# Install the Homebrew Brewfile and setup symbolic links to the
# dotfiles.
set -eou pipefail

main() {
  if ! command -v brew >/dev/null 2>&1; then
    if prompt_for_confirmation "Homebrew not found. Would you like to install Homebrew?"; then
      install_homebrew
    else
      echo "Exiting, can't continue without Homebrew installed."
      exit 0
    fi
  fi

  echo "Found homebrew installation. Installing Brewfile.."
  (cd homebrew && brew bundle)
  echo "Brewfile successfully installed. Moving to linking dotfiles.."

  stow executables
  stow nvim
  stow zsh
  stow git
  stow gpg
  stow tmux
  stow ghostty
  stow aerc
  echo "Successfully linked all dotfiles."

  echo "Initializing TPM (Tmux Plugin Manager)..."
  setup_tpm

  echo "Setup complete!"
}

# Prompt the user for confirmation on an action.
#
# Args:
#   $1: The question to prompt for. Answer choices
#      will be added onto the end.
#
# Returns:
#   0 on yes. 1 on no.
prompt_for_confirmation() {
  printf "%s [y/n]: " "$1"
  read -r answer
  if [[ "$answer" != "${answer#[Yy]}" ]]; then
    return 0
  else
    return 1
  fi
}

# Installs homebrew and verifies the installation.
#
# If the install was not successful, exits with a
# 1 status code.
install_homebrew() {
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # shellcheck disable=SC2016
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  if ! command -v brew >/dev/null 2>&1; then
    echo "Failed to install homebrew"
    exit 1
  fi
}

setup_tpm() {
  local tpm_dir="$HOME/.config/tpm/plugins/tpm"
  if [[ ! -d "$tpm_dir" ]]; then
    echo "Cloning TPM..."
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
  else
    echo "TPM already exists, updating..."
    (cd "$tpm_dir" && git pull)
  fi

  if command -v tmux >/dev/null 2>&1; then
    echo "Installing tmux plugins..."
    # Start a tmux server in the background and install plugins
    tmux start-server
    tmux new-session -d -s tpm_install
    tmux send-keys -t tpm_install "$tpm_dir/scripts/install_plugins.sh" Enter

    # Wait a moment for plugins to install
    sleep 3

    # Kill the temporary session
    tmux kill-session -t tpm_install 2>/dev/null || true

    echo "TPM plugins installed successfully."
  else
    echo "Warning: tmux not found. TPM cloned but plugins not installed."
    echo "Run 'tmux' and then press 'prefix + I' to install plugins manually."
  fi
}

main
