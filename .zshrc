# zmodload zsh/zprof && zprof # zsh起動時間計測
# oh-my-zsh setting
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#----------------------------------------------
# set environment vars and aliases for each OS
#----------------------------------------------
case ${OSTYPE} in
    #----------------------
    # for my laptop(macOS)
    #----------------------
    darwin*)
    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/.nodebrew/current/bin:/usr/local/texlive/2016/bin/x86_64-darwin:/usr/texbin:$HOME/sh"
    #export PYTHONPATH="/Library/Python/2.7/site-packages:/usr/local/lib/python2.7/site-packages"
    export SHELL=/usr/local/bin/zsh
    export XDG_CONFIG_HOME=$HOME/.config
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export PYENV_ROOT=/usr/local/var/pyenv
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PATH="$PATH:$PYENV_ROOT/versions/anaconda3-2.5.0/bin"
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    export EDITOR=vim
    export VISUAL=vim
    export PGDATA=/usr/local/var/postgres
    # export PKG_CONFIG_PATH=/usr/local/Cellar/imagemagick/6.9.7-/include/ImageMagick-7/MagickWand

    # update
    alias update='brew update && brew upgrade'
    # rmtrash
    alias rm='rmtrash'
    # seal vi
    alias vi='nvim'
    # pwd copy
    alias pwdc='pwd | pbcopy'
    # yomiage
    alias yomiage="pbpaste | say"
    # igcc
    alias igcc='/usr/local/lib/c-REPL/igcc'
    # tree with color and not encode misconversion
    alias tree='tree -NC'
    # vim typo
    alias im='vim'
    alias bim='vim'
    # ウィンドウ情報を回復してvimを開始
    alias vis="vim -S $HOME/.session.vim"
    alias ls="ls -FG"

    # find word
    alias findword='find . -type f -print0 | xargs -0 grep -ni --color=auto $1'

    #cdしたらlsする
    cd() { builtin cd "$@" && ls -FG }

    #git commitしたら自分を鼓舞する
    mycommit()
    {
      git commit "$@" 1>&2 && python /Users/naka/Desktop/github/small-codes/play-with-imgcat/fetch_image.py Cartman cute\ cat pikachu LGTM | imgcat
    }

    #MacVim
    #alias mvim='env_LANG=ja_JP.UTF-8 /Application/MacVim.app/Contents/MacOS/MacVim "$@"'

    # bookmark
    hash -d School=$HOME/Desktop/School
    hash -d github=$HOME/Desktop/github

    #DELIM=$'🍺 '
    DELIM=$'🍣 '
    #DELIM=$'⚽ '
    PROMPT="%{$fg[255]%}%~ %{$reset_color%}%(!.#.${DELIM}) "
    PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
    SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
    RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"

    export PATH="$PATH:`yarn global bin`"

    ;;
    #----------------------
    # other machine
    #----------------------
    linux*)
    #for linux
    alias update='sudo apt-get update && sudo apt-get upgrade'

    # find word
    alias findword='find . -type f -print0 | xargs -0 grep -ni --color $1'


    DELIM=$'🌍 '
    PROMPT="%{$fg[255]%}%~ %{$reset_color%}%(!.#.${DELIM}) "
    PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
    SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
    RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"
    ;;
esac

# global alias
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# shellを再起動
alias relogin='exec $SHELL -l'
alias r='relogin'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo -E '

# lessのオプション設定
export LESS='-i -M -R -S -W -z-4 -x4'
if which lesspipe.sh > /dev/null; then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

#補完リストが多いときに尋ねない
LISTMAX=1000

# plugin setting
plugins=(git)

#「少し凝ったzshrc」 
. $HOME/.useful_zshrc

# peco
source ~/.zsh/peco.zsh
#source .zsh/peco-sources
bindkey '^jr' peco_select_rake_task
bindkey '^jb' peco_git_recent_branches
bindkey '^jB' peco_git_recent_all_branches
bindkey '^jz' peco_cd_history
bindkey '^R'  peco_select_history

# password etc
if [ -e $HOME/.secret_zshrc ]; then
  . $HOME/.secret_zshrc
fi
