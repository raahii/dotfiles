#!/bin/bash

# vim
FROM=(vimrc vim/colors vim/dein/plugins.toml)
TO=(~/.vimrc ~/.vim/colors ~/.vim/dein/plugins.toml)

# fish
FROM+=(fish/config.fish fish/config_darwin.fish)
TO+=(~/.config/fish/config.fish ~/.config/fish/config_darwin.fish)
FROM+=(fish/fishfile fish/peco.fish)
TO+=(~/.config/fish/fishfile ~/.config/fish/peco.fish)

# others
FROM+=(gitconfig gitignore_global tmux.conf Brewfile)
TO+=(~/.gitconfig ~/.gitignore_global ~/.tmux.conf ~/.Brewfile)

function init() {
  # install brew
  if type brew >/dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # install packages
  brew install git curl peco wget go jq tree rmtrash

  # install vim
  brew install vim

  # install tmux
  brew install tmux reattach-to-user-namespace
  
  # install fish
  brew install fish
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

  # make git repos dir
  mkdir -p ~/repos
  echo "Done!"
}

function deploy() {
  mkdir -p ~/.vim
  for((i=0; i<${#FROM[@]}; i++))
  do
    ln -s $1/${FROM[i]} ${TO[i]}
  done
  brew bunlde --global
  echo "Done!"
}

function clean() {
  for((i=0; i<${#TO[@]}; i++))
  do
    unlink ${TO[i]}
  done
  echo "Done!"
}

if [ "$1" = "init" ]; then
  init
elif [ "$1" = "deploy" ]; then
  deploy $2
elif [ "$1" = "clean" ]; then
  clean
fi
