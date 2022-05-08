autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git svn
zstyle ":vcs_info:git*" formats "- (%b) "
precmd() {
    vcs_info
}
setopt prompt_subst
prompt="%2/ ${vcs_info_msg_0_}> "

export EDITOR="nvim"
export BROWSER="firefox"
export PAGER="less"

export SRC_DIR="$HOME/src"
export BIN_DIR="$HOME/bin"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH="$PATH:$HOME/.local/bin"
export PATH="$BIN_DIR:$PATH"

export GOPATH=$SRC_DIR/go
export GOBIN=$SRC_DIR/go/bin

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
alias o="xdg-open ."
alias open="xdg-open"

alias vi="nvim"
alias vim="nvim"

# "Compile C Program"
#
# $1: Program Name
# $2: Output File (default: a.out)
# $3: C Standard (default: c11)
#
# Example: ccp main.c main c99
ccp() {
    local prog_name=$1
    local output_file=${2:a.out}
    local std=${3:c11}

    cc -Wall -W -pedantic -ansi -std=$std -o $output_file $prog_name
}

memcheck() {
    G_DEBUG=always-malloc valgrind --tool=memcheck --leak-check=full --show-reachable=yes -s $1
}

gocover() {
    t="/tmp/go-cover.$$.tmp"
    go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}

