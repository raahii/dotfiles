#!/bin/bash

function init() {
  # install brew
  if type brew >/dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # install packages
  brew install git curl peco wget go jq tree rmtrash stow ripgrep

  # install vim
  brew install neovim python@2 python@3
  pip install neovim
  pip3 install neovim

  # install tmux
  brew install tmux reattach-to-user-namespace
  
  # install fish
  brew install fish
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

  # make git repos dir
  mkdir -p ~/repos/{bin,pkg,src}
}

function deploy() {
  [ -f ~/.config/functions/fish_prompt.fish ] && \
    mv ~/.config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish.old
  
  # deploy .files with stow
  stow --ignore ".DS_Store" -v fish -t ~/.config/fish # fish
  stow --ignore ".DS_Store" -v neovim -t ~/.config/nvim # neovim
  stow --ignore ".DS_Store" -v git -t ~/ # git
  stow --ignore ".DS_Store" -v others -t ~/ # others

  # brew bundle --global
}

function clean() {
  # deploy .files with stow
  stow --ignore ".DS_Store" -vD fish -t ~/.config/fish # fish
  stow --ignore ".DS_Store" -vD neovim -t ~/.config/nvim # neovim
  stow --ignore ".DS_Store" -vD git -t ~/ # git
  stow --ignore ".DS_Store" -vD others -t ~/ # others
}

if [ "$1" = "init" ]; then
  init
elif [ "$1" = "deploy" ]; then
  deploy $2
elif [ "$1" = "clean" ]; then
  clean
fi
