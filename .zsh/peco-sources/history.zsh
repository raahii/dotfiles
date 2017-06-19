setopt hist_ignore_all_dups

function peco_select_history() {
  if type tac 2>/dev/null 1>/dev/null 
  then
    BUFFER=$(fc -l -n 1 | tac | uniq | peco --query "$LBUFFER")
  else
    BUFFER=$(fc -l -n 1 | tail -r | uniq | peco --query "$LBUFFER")
  fi

  CURSOR=$#BUFFER         # move cursor
  zle -R -c               # refresh
}
zle -N peco_select_history
