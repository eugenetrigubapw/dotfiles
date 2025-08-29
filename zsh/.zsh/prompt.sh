#!/usr/bin/env zsh

autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f '
precmd() {
  vcs_info
}
setopt prompt_subst
NEWLINE=$'\n'
PROMPT=' %2~ ${vcs_info_msg_0_}%# '
