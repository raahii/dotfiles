# config
set fish_greeting ''
set HISTSIZE 100000
set -x GREP_OPTIONS '--color=always'
set -x GREP_COLOR '1;35;40'

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

# make development directory
set -x DEV ~/repos/src/github.com/raahii
[ -d $DEV ] && mkdir $DEV

# path
set -x PATH ~/bin $PATH

# go
set -x GOPATH ~/repos
set -x PATH $PATH $GOPATH/bin
[ -d $GOPATH ] && mkdir $GOPATH

# aliases
alias vim 'nvim'
alias  vi 'nvim'
alias  im 'nvim'
alias bim 'nvim'

alias fv 'find . | grep -v "/\." | peco | xargs -o nvim'

# config for each operating system
set -x OS (uname | tr '[A-Z]' '[a-z]')
[ -f $HOME/.config/fish/config_$OS.fish ] && . ~/.config/fish/config_$OS.fish
[ -f $HOME/.config/fish/config_local.fish ] && . ~/.config/fish/config_local.fish

