# shellcheck shell=sh
[ -n "${DOTFILES_OS_LOADED}" ] && return
readonly DOTFILES_OS_LOADED=1

os_print() {
  uname
}

os_is_macos() {
  [ "$(os_print)" = "Darwin" ]
}

os_is_openbsd() {
  [ "$(os_print)" = "OpenBSD" ]
}
