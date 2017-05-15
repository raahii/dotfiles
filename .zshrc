# zmodload zsh/zprof && zprof # zsh起動時間計測
# oh-my-zsh setting
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

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

# 各OS毎の設定を読み込む
[ -f $HOME/.zshrc_`uname` ] && . $HOME/.zshrc_`uname`
[ -f $HOME/.zshrc_local ] && . $HOME/.zshrc_local

# password etc
if [ -e $HOME/.secret_zshrc ]; then
  . $HOME/.secret_zshrc
fi
