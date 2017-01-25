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

# git 情報を読み取るようにする
autoload -Uz vcs_info
setopt prompt_subst

# ここは http://www.sirochro.com/note/terminal-zsh-prompt-customize/ からコピー
zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "*" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f" #通常

precmd () { vcs_info }

# プロンプトの編集
PROMPT='%F{magenta}[%d]%f${vcs_info_msg_0_} %# '
RPROMPT='%(?.%F{green}[OK]%f.%F{red}[NG]%f)'
