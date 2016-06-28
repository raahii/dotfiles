# basic zsh setting
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#---------------------------------------
# path setting and my alias for each OS
# --------------------------------------
case ${OSTYPE} in
    #----------------------
    # for my laptop(macOS)
    #----------------------
    darwin*)
        export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/bin:$HOME/.nodebrew/current/bin"
        export PYTHONPATH="/Library/Python/2.7/site-packages"
        export SHELL=/usr/local/bin/zsh
        export XDG_CONFIG_HOME=$HOME/.config
        export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
        export HOMEBREW_NO_ANALYTICS=1

        export PATH="$HOME/.pyenv/bin:$PATH"# pyenv for Mac OS X
        eval "$(pyenv init -)"

        #zshを再起動
        alias relogin='exec $SHELL -l'
        #update
        alias update='brew update && brew upgrade'
        #yomiage
        alias yomiage="pbpaste | say"
        # sudo の後のコマンドでエイリアスを有効にする
        alias sudo='sudo '
        alias pwdc='pwd | pbcopy'
        #rmtrash
        alias rm='rmtrash'
        #MacVim
        alias mvim='env_LANG=ja_JP.UTF-8 /Application/MacVim.app/Contents/MacOS/MacVim "$@"'

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

# plugin setting
plugins=(git)

#----------------------------------------------------------
# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/
#--------------------------------------------------------- 
. $HOME/.useful_zshrc
