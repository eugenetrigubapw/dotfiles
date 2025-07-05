#!/usr/bin/env zsh

source ~/.zsh/prompt.sh
source ~/.zsh/tmux.sh

autoload -Uz compinit
compinit

export HISTFILE=~/.zhistory
export HISTSIZE=100000
export SAVEHIST=100000

export EDITOR="nvim"
export BROWSER="vivaldi"
export BAT_THEME="tokyonight_night"
export MANPAGER="less"
export PAGER="less"
export TERM="xterm-256color"

export GPG_TTY=$(tty)

export SRC_DIR="$HOME/src"
export BIN_DIR="$HOME/bin"

export PATH="$BIN_DIR:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export GOPATH="$SRC_DIR/go"
export GOBIN="$SRC_DIR/go/bin"
export PATH="$GOBIN:$PATH"

source "$HOME/.cargo/env"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PNPM_HOME="/Users/eugene/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

eval "$(brew shellenv)"
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

alias gs="git status"
alias gc="git commit"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias gp="git push"
alias gpo='git push origin'
alias gplrb='git pull --rebase'
alias gpl="git pull"
alias gl='git log'
alias gch="git checkout"
alias gcb='git checkout -b'
alias gv='git log --graph --decorate --oneline'

alias h="history 25"
alias j="jobs -l"
alias l="ls -alG"

alias vi="nvim"
alias vim="nvim"
