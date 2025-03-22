# ssh-agent が起動していなければ起動するスクリプト
isSshAgent=`ps -ef | grep ssh-agent | grep -v grep | wc -l`
if [ $isSshAgent = 1 ]; then
    echo "ssh-agent is running."
else
    eval `ssh-agent`
fi


# Mac 独自の設定変更
function setup_mac() {
    # display settings
    export CLICOLOR=1
    export LSCOLORS=GxFxcxdxCxegedabagacad

    # git の補完を有効化する( Mac のみ必要)
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

    # Mac Tex へのパス通し（使ってない）
    # PATH=/usr/texbin/:$PATH

    # shell integration 
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
}

# Ubuntu (WSL2) 独自の設定
function setup_ubuntu() {
    #display settings
    alias ls='ls --color=auto'
    alias pbcopy='xclip -selection c'
    alias pbpaste='xclip -selection c -o'
}


# import .ssh/config
function _ssh {
  compadd `fgrep 'Host ' ~/.ssh/config | awk '{print $2}' | sort`;
}

# Commans Aliases
alias e='emacs -nw'
alias ll='ls -la'
alias sl='ls' # typo supports
alias tf='terraform'
alias dc='docker compose'
alias g='git'
alias gg='git grep'
alias sad='ssh-add ~/.ssh/github.com/id_rsa'
alias wip='git add . && git commit -m "wip"'
alias p3='python3'

# language settings
export LANG=ja_JP.UTF-8

# for Ruby Environment
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# for Go lang
function setup_go() {
    [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
    
    # Go PATH
    unset GOROOT
    export GOROOT=`go env GOROOT`
    export GOPATH=~/.go
    export PATH=/usr/local/bin:$PATH:$GOPATH/bin
}

if which go > /dev/null; then setup_go; fi

# オレオレコマンドへのパス通し
export PATH="$HOME/dotfiles/bin:$PATH"

# pyenv 用のパス通し
export PATH="$HOME/.pyenv/shims:$PATH"

# JAVA_HOME へのパス通し
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# pnpm へのパス通し
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# OSごとの設定を反映
case $OSTYPE in
    darwin*)
        setup_mac
        ;;
    linux*)
        setup_ubuntu
        ;;
esac

# gnu global
funcs()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=(`global -c $cur`)
}

# tmux セッションを自動的に立ち上げる。
function tmux() {
    if [[ ! -n $TMUX ]]; then
        # get the IDs
        ID="`tmux list-sessions`"
        if [[ -z "$ID" ]]; then
            tmux new-session
        fi
        ID="`echo $ID | cut -d: -f1`"
        tmux attach-session -t "$ID"
    fi
}

autoload -U compinit
compinit -u

# git 情報を読み取るようにする
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "*" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f" #通常

precmd () { vcs_info }

# プロンプトの編集
#PROMPT='%F{magenta}[%~]%f %# '
PROMPT='%F{magenta}[%~]%f${vcs_info_msg_0_} %# '
#RPROMPT='%(?.%F{green}[OK]%f.%F{red}[NG]%f)'

export PATH="$HOME/.fastlane/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
