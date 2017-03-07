function peco_select_spec_file() {
    local list_spec_files="ag -g .rb spec/*/"
    spec_files=$(eval $list_spec_files | peco --query "$LBUFFER" )
    BUFFER=$spec_files
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N peco_select_spec_file
