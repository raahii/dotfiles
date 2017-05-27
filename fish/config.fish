###   global alias
# basic
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo -E '
alias r='eval $SHELL -l'

# 各OS毎の設定を読み込む
if test -e $HOME/.config/fish/config_(uname).fish
  . $HOME/.config/fish/config_(uname).fish
end
# [ -f $HOME/.bashrc_local ] && . $HOME/.bashrc_local

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish
