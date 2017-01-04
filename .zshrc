# language settings
export LANG=ja_JP.UTF-8

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
alias e='emacs -nw'

# github 用 ssh-agent を短縮
alias sag='ssh-agent & ssh-add ~/.ssh/github.com/id_rsa'

# terraform 短縮エイリアス
alias tf='terraform'

# オレオレコマンドへのパス通し
export PATH="$HOME/dotfiles/bin:$PATH"

# pyenv 用のパス通し
export PATH="$HOME/.pyenv/shims:$PATH"

# anaconda 用のエイリアス
#alias pip='~/.pyenv/versions/anaconda3-4.1.0/bin/pip'
#alias anaconda='open ~/.pyenv/versions/anaconda3-4.1.0/Navigator.app'

# gnu global
funcs()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=(`global -c $cur`)
}

# tmux セッションを自動的に立ち上げる。
if [[ ! -n $TMUX ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi
    ID="`echo $ID | cut -d: -f1`"
    tmux attach-session -t "$ID"
fi

