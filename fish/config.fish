# install fisher
if not functions -q fisher
  echo "installing fisher..."
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  fish -c fisher
  fish_update_completions
end

# config
set fish_greeting ''
set HISTSIZE 1000
set -x GREP_COLOR '1;35;40'

# global aliases
alias cp 'cp -i'
alias mv 'mv -i'
alias ll 'ls -al'
alias mkdir 'mkdir -p'
alias r 'eval $SHELL -l'
alias sudo 'sudo -E '
alias dc 'docker-compose'
alias vim 'nvim'
alias  vi 'nvim'
alias  im 'nvim'
alias bim 'nvim'

# less option
set -x LESS '-i -M -R -S -W -z-4 -x4'

# direnv
if type direnv > /dev/null 2>&1
  eval (direnv hook fish)
end

# golang
if type go > /dev/null 2>&1
  set -x GO111MODULE on
  set -x GOPATH "$HOME/repos"
  set -x PATH $PATH "$GOPATH/bin"
  if [ -e "$GOPATH" ]
    mkdir "$GOPATH"
  end
end

if [ -e "$HOME/.goenv" ]
  set -x GOENV_ROOT $HOME/.goenv
  set -x PATH $GOENV_ROOT/bin $PATH
  eval (goenv init - --no-rehash | source)
end

# python
if [ -e "$HOME/.pyenv" ]
  set -x PYENV_ROOT "$HOME/.pyenv"
  set -x PATH $HOME/.pyenv/shims $PATH
  eval (pyenv init - --no-rehash | source)
end

# ruby
if [ -e "$HOME/.rbenv" ]
  set -x RBENV_ROOT $HOME/.rbenv
  set -x PATH $RBENV_ROOT/bin $PATH
  source (rbenv init - --no-rehash| psub)
end

# node
if [ -e "$HOME/.nodebrew" ]
  set -x PATH "~/.nodebrew/current/bin" $PATH
end

# rust
if [ -e "$HOME/.cargo" ]
  set -x PATH "$HOME/.cargo/bin" $PATH
end

# config for each operating system
set -x OS (uname | tr '[A-Z]' '[a-z]')
[ -f $HOME/.config/fish/config_$OS.fish ]; and . ~/.config/fish/config_$OS.fish
[ -f $HOME/.config/fish/config_local.fish ]; and . ~/.config/fish/config_local.fish
