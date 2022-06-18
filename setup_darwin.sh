#!/bin/bash

function init() {
  # install basic packages
  brew install \
    curl wget jq tree \
    fish peco ghq stow ripgrep mas \   # fish
    neovim anyenv go node node-build \ # neovim
    tmux reattach-to-user-namespace    # tmux

  # install fish plugins with fisher
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
    source && fisher install jorgebucaran/fisher

  # set defualt shell to fish
  echo $(which fish) | sudo tee -a /etc/shell
  chsh -s $(which fish)

  # anyenv
  anyenv install --force-init

  # python
  anyenv install pyenv
  PYTHON_LATEST=$(pyenv install -l | grep -E '^\s*\d+\.\d+\.\d+$' | tail -n 1 | xargs echo)
  pyenv install $PYTHON_LATEST
  pyenv global $PYTHON_LATEST

  # node
  anyenv install nodenv
  NODE_LATEST=$(nodenv install -l | grep -E '^\s*\d+\.\d+\.\d+$' | tail -n 1 | xargs echo)
  nodenv install $NODE_LATEST
  nodenv global $NODE_LATEST

  # create directories
  mkdir -p ~/repos/{bin,pkg,src} # go path
  mkdir -p ~/.local/bin          # binary path
}

function deploy() {
  [ -f ~/.config/functions/fish_prompt.fish ] &&
    mv ~/.config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish.bak

  [ -f ~/.config/karabiner/karabiner.json ] &&
    mv -f ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json.bak

  # deploy .files with stow
  _stow -t ~/.config/fish -S fish
  _stow -t ~/.config/nvim -S neovim
  _stow -t ~/.config/karabiner -S karabiner
  _stow -t ~/.config/iterm2 -S iterm
  _stow -t ~/ -S git
  _stow -t ~/ -S others
}

function clean() {
  # clean .files with stow
  _stow -t ~/.config/fish -D fish
  _stow -t ~/.config/nvim -D neovim
  _stow -t ~/.config/karabiner -D karabiner
  _stow -t ~/.config/iterm2 -D iterm
  _stow -t ~/ -D git
  _stow -t ~/ -D others
}

function _stow() {
  stow --ignore ".DS_Store" -v $@
}

if [ "$1" = "init" ]; then
  init
elif [ "$1" = "deploy" ]; then
  deploy "$2"
elif [ "$1" = "clean" ]; then
  clean
fi
