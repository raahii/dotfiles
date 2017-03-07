function peco_kill() {
  for pid in `\ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
  done
}
zle -N peco_kill
