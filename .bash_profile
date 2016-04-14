# display settings
export CLICOLOR=1
export LSCOLORS=GxFxcxdxCxegedabagacad

# for Ruby Environment
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# for Go lang
[[ -s "/Users/ryo/.gvm/scripts/gvm" ]] && source "/Users/ryo/.gvm/scripts/gvm"

# PATH settings for MacTex
PATH=/usr/texbin/:$PATH

# GOPATH
export GOPATH=~/.go
export PATH=/usr/local/bin:$PATH:$GOPATH/bin

# emacs 短縮エイリアス
alias e='emacs'

# pyenv 用のパス通し
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# gnu global
funcs()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=(`global -c $cur`)
}
