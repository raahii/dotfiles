#!/bin/bash

function init() {
  # install brew
  if type brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # install basic packages
  brew install \
    git curl peco wget go jq tree stow ripgrep \
    neovim tmux fish reattach-to-user-namespace

  # make git repos dir
  mkdir -p ~/repos/{bin,pkg,src}
}

function deploy() {
  [ -f ~/.config/functions/fish_prompt.fish ] &&
    mv ~/.config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish.old

  # deploy .files with stow
  stow --ignore ".DS_Store" -v -t ~/.config/fish -S fish
  stow --ignore ".DS_Store" -v -t ~/.config/nvim -S neovim
  [ -f ~/.config/karabiner/karabiner.json ] &&
    mv -f ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json.bak
  stow --ignore ".DS_Store" -v -t ~/.config/karabiner -S karabiner
  stow --ignore ".DS_Store" -v -t ~/.config/iterm2 -S iterm
  stow --ignore ".DS_Store" -v -t ~/ -S git
  stow --ignore ".DS_Store" -v -t ~/ -S others
}

function clean() {
  # clean .files with stow
  stow --ignore ".DS_Store" -v -t ~/.config/fish -D fish
  stow --ignore ".DS_Store" -v -t ~/.config/nvim -D neovim
  stow --ignore ".DS_Store" -v -t ~/.config/karabiner -D karabiner
  stow --ignore ".DS_Store" -v -t ~/.config/iterm2 -D iterm
  stow --ignore ".DS_Store" -v -t ~/ -D git
  stow --ignore ".DS_Store" -v -t ~/ -D others
}

if [ "$1" = "init" ]; then
  init
elif [ "$1" = "deploy" ]; then
  deploy "$2"
elif [ "$1" = "clean" ]; then
  clean
fi
