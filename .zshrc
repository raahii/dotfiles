# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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

# peco
source ~/.zsh/peco.zsh
# source .zsh/peco-sources
# bindkey '^jr' peco_select_rake_task
# bindkey '^jb' peco_git_recent_branches
# bindkey '^jB' peco_git_recent_all_branches
bindkey '^jz' peco_cd_history
bindkey '^R'  peco_select_history

# git
# autoload -Uz vcs_info # VCSの情報を取得するzshの便利関数 vcs_infoを使う
#
# zstyle ':vcs_info:*' formats '[%b]'
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () {
#     psvar=()
#     LANG=en_US.UTF-8 vcs_info
#     [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
# }

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
# RPROMPT="%1(v|%F{green}%1v%f|)"

# 各OS毎の設定を読み込む
[ -f $HOME/.zshrc_`uname` ] && . $HOME/.zshrc_`uname`
[ -f $HOME/.zshrc_local ] && . $HOME/.zshrc_local
