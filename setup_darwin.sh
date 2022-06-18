#!/bin/bash

function init() {
  # install brew
  if type brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # install basic packages
  brew install \
    git curl wget jq tree \
    fish peco ghq stow ripgrep mas \
    neovim pyenv nodenv go node node-build \
    tmux reattach-to-user-namespace

  # install fish plugins with fisher
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish |
    source && fisher install jorgebucaran/fisher

  # set defualt shell to fish
  echo $(which fish) | sudo tee -a /etc/shell
  chsh -s $(which fish)

  # python for vim
  PYTHON_LATEST=$(pyenv install -l | grep -E '^\s*\d+\.\d+\.\d+$' | tail -n 1 | xargs echo)
  pyenv install $PYTHON_LATEST
  pyenv global $PYTHON_LATEST
  python -m pip install -U pip pynim neovim

  # node for vim
  NODE_LATEST=$(nodenv install -l | grep -E '^\s*\d+\.\d+\.\d+$' | tail -n 1 | xargs echo)
  nodenv install $NODE_LATEST
  nodenv global $NODE_LATEST
  npm install -g neovim

  # create directories
  mkdir -p ~/repos/{bin,pkg,src} # golang / ghq
  mkdir -p ~/.config/karabiner   # karabiner
  mkdir -p ~/.local/bin          # binaries
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
