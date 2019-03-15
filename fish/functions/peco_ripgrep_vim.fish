function peco_ripgrep_vim
  vared __query
  rg -n $__query | peco | awk -F : '{print "-c" " " $2 " " $1}' | xargs vim
  set __query ""
end
