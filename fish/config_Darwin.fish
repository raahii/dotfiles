## Aliases
alias update 'brew update;and brew upgrade'
alias rm 'rmtrash'
alias pwdc 'pwd | pbcopy'
alias tree 'tree -NC'
alias im 'vim'
alias bim 'vim'
alias vis "vim -S $HOME/.session.vim"
alias ls "ls -FG"
alias pkill "ps aux | peco | awk '{print $2}' | xargs kill"

## Environment Variables
set -x PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin $HOME/sh
set -x SHELL /usr/local/bin/zsh
set -x XDG_CONFIG_HOME $HOME/.config
set -x JAVA_HOME `/usr/libexec/java_home -v 1.8`
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_CASK_OPTS "--appdir /Applications"
set -x EDITOR vim
set -x VISUAL vim
set -x PGDATA /usr/local/var/postgres
set -x HOMEBREW_BREWFILE $HOME/dotfiles/Brewfile

# golang
if test -x "(which go)"
  set -x GOPATH $HOME/.go
  set -x PATH $PATH $GOPATH/bin
end

# pyenv
if test -d $HOME/.pyenv
  set -x PYENV_ROOT $HOME/.pyenv
  set -x PATH $PATH $PYENV_ROOT/versions/anaconda3-2.5.0/bin
  . (pyenv init - | psub)
  # eval "pyenv virtualenv-init -"
end

# rbenv
if test -d $HOME/.rbenv
  rbenv init - | source
end

## nodebrew
if test -d $HOME/.nodebrew
  set -x PATH $HOME/.nodebrew/current/bin $PATH
end

# yarn
set -x PATH $PATH (yarn global bin)

# bookmark
# hash -d School $HOME/Desktop/School
# hash -d develop $HOME/Desktop/develop

## Functions
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

# call history
function peco_select_history
  if test (count $argv) = 0
    set peco_flags
  else
    set peco_flags --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

#cdしたらlsする
function cd
  builtin cd $argv
  ls -aFG
end
