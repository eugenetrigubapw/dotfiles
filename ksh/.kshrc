#!/bin/ksh

if [ "$(uname)" = "OpenBSD" ]; then
  . ~/.profile
fi

#
# Setup Shell Prompt
#
git_branch() {
  git branch 2>/dev/null | grep '^\*' | cut -d' ' -f2-
}

# PS1 with git branch support
PS1='$(
  printf " %s " "${PWD#$HOME/}"
  branch=$(git_branch)
  if [ -n "$branch" ]; then
    printf "\033[32m(%s)\033[0m " "$branch"
  fi
  if [ "$(id -u)" -eq 0 ]; then
    printf "# "
  else
    printf "$ "
  fi
)'

#
# Setup shell history
#
export HISTFILE=~/.ksh_history
export HISTSIZE=1000000

#
# Setup default env variables
#
export EDITOR="nvim"
export BROWSER="firefox"
export GPG_TTY=$(tty)
export PAGER="less"
export MANPAGER="less"
export BAT_THEME="tokyonight_night"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export TERM="xterm-256color"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

#
# Language setup
#
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin"
export GOPROXY="direct"

if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

#
# Append additional directories onto PATH
#
export PATH="$HOME/.local/bin:$PATH"

#
# macOS
#
if [ $(uname) = "Darwin" ]; then
  # Homebrew
  eval "$(brew shellenv)"
  export LDFLAGS="-L/opt/homebrew/lib"
  export CPPFLAGS="-I/opt/homebrew/include"
  export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"

  export JAVA_HOME=$(/usr/libexec/java_home -v 24)
  export PATH="/opt/homebrew/opt/openjdk@24/bin:$PATH"
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk@24/include"

  export PNPM_HOME="/Users/eugene/Library/pnpm"
  case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
  esac

  export PATH="$HOME/.poetry/bin:$PATH"
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
fi

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
alias l="ls -al"

set -o emacs
