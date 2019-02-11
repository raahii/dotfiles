# config
set fish_greeting ''
set HISTSIZE 100000
set -x GREP_OPTIONS '--color=always'
set -x GREP_COLOR '1;35;40'
set fish_theme pure

# global alias
alias cp 'cp -i'
alias mv 'mv -i'
alias ll 'ls -al'
alias mkdir 'mkdir -p'
alias r 'eval $SHELL -l'
alias sudo 'sudo -E '

# docker alias
alias dps 'docker ps'
alias dim 'docker images'
alias drmi 'docker rmi (docker images -aqf "dangling=true") 2> /dev/null'
alias dc 'docker-compose'

# less option
set -x LESS '-i -M -R -S -W -z-4 -x4'

# peco
. ~/.config/fish/peco.fish
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cg peco_change_directory
end

# make development directory
set -x DEV ~/repos/src/github.com/raahii
mkdir -p $DEV

# go
set -x GOPATH ~/repos
set -x PATH $PATH $GOPATH/bin
if not test -d $GOPATH
  mkdir -p $GOPATH
end

# config for each operating system
[ -f $HOME/.config/fish/config_(uname).fish ]; and . ~/.config/fish/config_(uname).fish
[ -f $HOME/.config/fish/config_local.fish ]; and . ~/.config/fish/config_local.fish

