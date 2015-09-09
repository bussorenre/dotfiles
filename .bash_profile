# display settings
export CLICOLOR=1
export LSCOLORS=GxFxcxdxCxegedabagacad

# for Ruby Environment
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# for Go lang
[[ -s "/Users/ryo/.gvm/scripts/gvm" ]] && source "/Users/ryo/.gvm/scripts/gvm"

# GOPATH
GOPATH=~/bussorenre/golang

# PATh settings for homebrew and GOPATH
PATH=/usr/local/bin:$PATH:$GOPATH/bin

# PATH settings for MacTex
PATH=/usr/texbin/:$PATH

# emacs 短縮エイリアス
alias e='emacs'
