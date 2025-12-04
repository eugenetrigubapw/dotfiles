# shellcheck shell=sh
[ -n "${DOTFILES_PROMPT_LOADED}" ] && return
readonly DOTFILES_PROMPT_LOADED=1

# Prompt the user for confirmation on an action.
#
# Args:
#   $1: The question to prompt for. Answer choices
#      will be added onto the end.
#
# Returns:
#   0 on yes. 1 on no.
prompt_for_confirmation() {
  (
    printf "%s [y/n]: " "$1"
    read -r answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
      return 0
    else
      return 1
    fi
  )
}
