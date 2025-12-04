# shellcheck shell=sh
[ -n "${DOTFILES_LOG_LOADED:-}" ] && return
readonly DOTFILES_LOG_LOADED=1

log_info() {
  echo "[INFO] $*" >&2
}

log_error() {
  echo "[ERROR] $*" >&2
}

log_warn() {
  echo "[WARN] $*" >&2
}

log_success() {
  echo "[SUCCESS] $*" >&2
}

log_debug() {
  [ "${DEBUG:-}" = "true" ] && echo "[DEBUG] $*" >&2
}

log_newline() {
  echo "" >&2
}

log_header() {
  echo "=== $* ===" >&2
}

log_step() {
  echo "→ $*" >&2
}

log_substep() {
  echo "  • $*" >&2
}

log_progress() {
  printf "." >&2
}

log_progress_end() {
  echo "" >&2
}
