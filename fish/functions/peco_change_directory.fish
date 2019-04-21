function peco_change_directory
  begin
    echo $HOME/Documents
    echo $HOME/Desktop
    echo $HOME/.config
    sort -r -t '|' -k 3 $Z_DATA | sed -e 's/|.*//'
    ghq list -p
  end | awk '!a[$0]++' | _peco_change_directory $argv
end

function _peco_change_directory
  if [ (count $argv) ]
    peco --layout=top-down --query "$argv "|perl -pe 's/([ ()])/\\\\$1/g'|read foo
  else
    peco --layout=top-down |perl -pe 's/([ ()])/\\\\$1/g'|read foo
  end
  if [ $foo ]
    builtin cd $foo
  end
end
