function peco_vagrant() {
  vagrant_host=$(vagrant-global-status | \
                    peco | \
                    awk '{print $2}')

  if [ -n "$vagrant_host" ]; then
    vagrant_command=$(vagrant list-commands | \
      awk 'NR >= 4' | \
      peco | \
      awk '{print $1}')
    BUFFER="vagrant ${vagrant_command} ${vagrant_host}"
    CURSOR=$#BUFFER
    zle -R -c
  fi
}
zle -N peco_vagrant
