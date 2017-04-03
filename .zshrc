# OSごとの設定を反映
if [ "$(uname)" == 'Darwin']; then
    OS='Mac'
    setup_mac()
elif [ "$(uname)" == 'Linux' ]; then
    OS='Liunx'
    setup_linux()
fi

aliases()

# Mac 独自の設定変更
function setup_mac() {
    # display settings
    export CLICOLOR=1
    export LSCOLORS=GxFxcxdxCxegedabagacad

    # git の補完を有効化する( Mac のみ必要)
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
}

# Linux 独自の設定
function setup_linux() {
    alias ls='ls --color=auto'
}



# 短縮エイリアス集
function aliases() {
    alias e='emacs &'
    alias sag='ssh-agent & sysh-add ~/.ssh/github.com/id_rsa'
    alias tf='terraform'
}

# language settings
export LANG=ja_JP.UTF-8

# for Ruby Environment
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# for Go lang
[[ -s "/Users/ryo/.gvm/scripts/gvm" ]] && source "/Users/ryo/.gvm/scripts/gvm"

# PATH settings for MacTex
PATH=/usr/texbin/:$PATH

# GOPATH
export GOPATH=~/.go
export PATH=/usr/local/bin:$PATH:$GOPATH/bin


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

autoload -U compinit
compinit -u

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
