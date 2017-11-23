source ~/.zsh/shrink-path.plugin.zsh

autoload -Uz colors
colors

zstyle :prompt:shrink_path fish yes
# PROMPT='%n@%d
# $fg[green]%n%{${reset_color}%}:$(shrink_path -f)
PROMPT="
$fg[green]%n%{${reset_color}%}:%d
$ "

zstyle ':completion:*' list-colors "${LS_COLORS}"

## 履歴の保存先
HISTFILE=$HOME/.zsh-history
## メモリに展開する履歴の数
HISTSIZE=100000
## 保存する履歴の数
SAVEHIST=100000

## 色を使う
setopt prompt_subst
## ビープを鳴らさない
setopt nobeep
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## Emacsライクキーバインド設定
bindkey -e
## ヒストリを共有
setopt share_history
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## ディレクトリ名だけで cd
setopt auto_cd
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## 補完候補を詰めて表示
setopt list_packed
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

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
bindkey '^jz' peco_cd_history
bindkey '^R'  peco_select_history

# 各OS毎の設定を読み込む
[ -f $HOME/.zshrc_`uname` ] && . $HOME/.zshrc_`uname`
[ -f $HOME/.zshrc_local ] && . $HOME/.zshrc_local
