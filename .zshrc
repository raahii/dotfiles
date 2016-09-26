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

        # 2016 atWare internship
        export CATALINA_HOME="${HOME}/tomcat"
        # export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_77.jdk/Contents/Home"
        export M3_HOME=/usr/local/maven
        M3=$M3_HOME/bin
        export PATH=$M3:$PATH

        # sudo の後のコマンドでエイリアスを有効にする
        alias sudo='sudo -E '
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

        #cdしたらlsする
        cd()
        {
          builtin cd "$@" && ls -FG
        }

        #git commitしたら自分を鼓舞する
        mycommit()
        {
          git commit "$@" 1>&2 && python /Users/naka/Desktop/github/small-codes/play-with-imgcat/fetch_image.py Cartman | imgcat
        }

        #MacVim
        #alias mvim='env_LANG=ja_JP.UTF-8 /Application/MacVim.app/Contents/MacOS/MacVim "$@"'

        # bookmark
        hash -d School=$HOME/Desktop/School
        hash -d github=$HOME/Desktop/github

        ;;
    #----------------------
    # other machine
    #----------------------
    linux*)
        #for linux
        alias update='sudo apt-get update && sudo apt-get upgrade'
        ;;
esac

# global alias
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

#shellを再起動
alias relogin='exec $SHELL -l'
alias r='relogin'

#補完リストが多いときに尋ねない
LISTMAX=1000

# plugin setting
plugins=(git)

#---------------------------------------------------------
# 「少し凝ったzshrc」 
#  License : MIT (http://mollifier.mit-license.org/)
#--------------------------------------------------------- 
. $HOME/.useful_zshrc

#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
