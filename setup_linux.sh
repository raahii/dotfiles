#!/bin/bash
function install_go() {
  TMPDIR=$(mktemp -d)
  wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz --directory-prefix "$TMPDIR"
  sudo tar -xvf "$TMPDIR/go1.13.3.linux-amd64.tar.gz" -C /usr/local

  export GOROOT=/usr/local/go
  export GOPATH=~/repos
  export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
}

function init() {
  # basic packages
  sudo apt-get -y update
  sudo apt-get -y install wget curl jq tree stow git tmux locales

  # update locales
  locale-gen en_US.UTF-8
  export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

  # install python2 python3
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y python-dev python-pip python3-dev python3-pip
  pip install -U pip
  pip install neovim
  python3 -m pip3 install -U pip
  python3 -m pip3 install neovim

  # install node
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get install -y nodejs
  npm update -g npm
  npm install -g neovim

  # install neovim
  sudo add-apt-repository ppa:neovim-ppa/stable -y
  sudo apt-get update
  sudo apt-get install -y neovim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # install fish
  sudo apt-add-repository ppa:fish-shell/release-2 -y
  sudo apt-get update
  sudo apt-get install -y fish

  # make ghq (git repos) dir
  mkdir -p ~/repos/{bin,pkg,src}

  # install peco, ghq
  install_go
  GOPATH=~/repos go get -u -v github.com/peco/peco
  GOPATH=~/repos go get -u -v github.com/motemen/ghq
}

function deploy() {
  [ -f ~/.config/functions/fish_prompt.fish ] &&
    mv ~/.config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish.old

  # deploy .files with stow
  stow -v -t ~/.config/fish -S fish
  stow -v -t ~/.config/nvim -S neovim
  stow -v -t ~/ -S git -S others

  # # delete rows for mac
  # if grep -q "reattach" "others/.tmux.conf"; then
  #   sed -i '/reattach/d' others/.tmux.conf
  # fi
}

function clean() {
  # clean .files with stow
  stow -v -t ~/.config/fish -D fish
  stow -v -t ~/.config/nvim -D neovim
  stow -v -t ~/ -D git -D others
}

if [ "$1" = "init" ]; then
  init
elif [ "$1" = "deploy" ]; then
  deploy "$2"
elif [ "$1" = "clean" ]; then
  clean
fi
