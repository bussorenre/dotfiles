# マシン固有の事情で必要な設定を ~/.zshrc.local に書いておく。存在する場合は読み込む。
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# ssh-agent が起動していなければ起動するスクリプト
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
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

    # iTerm2 integration
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

    # JAVA_HOME
    if [ -x /usr/libexec/java_home ]; then
        export JAVA_HOME=$(/usr/libexec/java_home)
    fi
}

# Ubuntu (WSL2) 独自の設定
function setup_ubuntu() {
    # display settings
    alias ls='ls --color=auto'
    alias pbcopy='xclip -selection c'
    alias pbpaste='xclip -selection c -o'

    # JAVA_HOME
    if [ -d "/usr/lib/jvm/default-java" ]; then
        export JAVA_HOME=/usr/lib/jvm/default-java
    elif [ -d "/usr/lib/jvm/java-11-openjdk-amd64" ]; then
        export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    fi
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
alias be='bundle exec'
alias sonnet='claude --model sonnet'
alias fable='claude --model fable'

# language settings
export LANG=ja_JP.UTF-8

# for Ruby Environment
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# for Go lang
if which go > /dev/null; then
    export GOPATH=~/.go
    export PATH=$PATH:$GOPATH/bin
fi

# オレオレコマンドへのパス通し
export PATH="$HOME/dotfiles/bin:$PATH"

# pyenv 用のパス通し
export PATH="$HOME/.pyenv/shims:$PATH"

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

# zsh options
setopt AUTO_CD      # Type directory name to cd
setopt CORRECT      # Command correction

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

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r "${HOME}/.opam/opam-init/init.zsh" ]] || source "${HOME}/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
# END opam configuration
