###   global alias
# basic
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo -E '
alias r='exec $SHELL -l'

# 各OS毎の設定を読み込む
[ -f $HOME/.bashrc_`uname` ] && . $HOME/.bashrc_`uname`
[ -f $HOME/.bashrc_local ] && . $HOME/.bashrc_local
