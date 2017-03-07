# {{{
# cd 履歴を記録
setopt hist_ignore_all_dups
typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd # cd 履歴の記録先ファイル

function chpwd_record_history() {
  echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd_record_history)

# peco を使って cd 履歴の中からディレクトリを選択
# 過去の訪問回数が多いほど選択候補の上に来る
function peco_get_destination_from_history() {
  sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
    sed -e 's/^[ ]*[0-9]*[ ]*//' | \
    sed -e s"/^${HOME//\//\\/}/~/" | \
    peco | xargs echo
}

# peco を使って cd 履歴の中からディレクトリを選択し cd するウィジェット
function peco_cd_history() {
  local destination=$(peco_get_destination_from_history)
  if [ -n "$destination" ]; then
    BUFFER="cd ${destination}"
    zle accept-line
  fi
}
zle -N peco_cd_history

# peco を使って cd 履歴の中からディレクトリを選択し，現在のカーソル位置に挿入するウィジェット
function peco_insert_history() {
  local destination=$(peco_get_destination_from_history)
  if [ $? -eq 0 ]; then
    local new_left="${LBUFFER} ${destination} "
    BUFFER=${new_left}${RBUFFER}
    CURSOR=${#new_left}
  fi
  zle reset-prompt
}
zle -N peco_insert_history
# }}}
