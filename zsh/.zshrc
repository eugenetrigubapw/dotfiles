#!/usr/bin/env zsh

#
# Setup Shell Prompt
#
# This enables a simple prompt with git info
# and the current working directory.
#
autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f '
precmd() {
  vcs_info
}
setopt prompt_subst
NEWLINE=$'\n'
PROMPT=' %2~ ${vcs_info_msg_0_}%# '

#
# Setup the zsh shell completion system
#
# See `man zshcompsys`.
#
autoload -Uz compinit
compinit

#
# Setup shell history
#
export HISTFILE=~/.zhistory
export HISTSIZE=100000
export SAVEHIST=100000

#
# Setup default env variables
#
export EDITOR="nvim"
export BROWSER="firefox"
export GPG_TTY=$(tty)
export PAGER="less"
export MANPAGER="less"
export BAT_THEME="tokyonight_night"
export SRC_DIR="$HOME/src"
export BIN_DIR="$HOME/bin"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

#
# Append additional directories onto PATH
#
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$HOME/bin:$HOME/.local/bin;
export PATH

#
# Aliases
#
alias gs="git status"
alias gc="git commit"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias gp="git push"
alias gpo="git push origin"
alias gpl="git pull"
alias gplrb="git pull --rebase"
alias gl="git log"
alias gv="git log --graph --decorate --oneline"
alias gch="git checkout"
alias gcb="git checkout -b"

alias h="history 25"
alias j="jobs -l"
alias l="ls -alG"

alias vi="nvim"
alias vim="nvim"

#
# Language setup
#
export GOPATH="$SRC_DIR/go"
export GOBIN="$SRC_DIR/go/bin"
export PATH="$GOPATH/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOBIN:$PATH"
export GOPROXY="direct"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

. "$HOME/.cargo/env"

