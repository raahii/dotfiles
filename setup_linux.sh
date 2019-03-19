#!/bin/bash

function install_ripgrep() {
  REPO="https://github.com/BurntSushi/ripgrep/releases/download/"
  RG_LATEST=$(curl -sSL "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | jq --raw-output .tag_name)
  RELEASE="${RG_LATEST}/ripgrep-${RG_LATEST}-x86_64-unknown-linux-musl.tar.gz"

  TMPDIR=$(mktemp -d)
  pushd $TMPDIR
  wget -O - ${REPO}${RELEASE} | tar zxf - --strip-component=1
  mkdir -p ~/bin
  mv rg ~/bin/
  popd
}

function init() {
  sudo apt-get -y update
  
  # # Change directory names to English
  # env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

  # # Prevent text garbling
  # gsettings set org.gnome.gedit.preferences.encodings auto-detected "['UTF-8','CURRENT','SHIFT_JIS','EUC-JP','ISO-2022-JP','UTF-16']"
  # gsettings set org.gnome.gedit.preferences.encodings shown-in-menu "['UTF-8','SHIFT_JIS','EUC-JP','ISO-2022-JP','UTF-16']"
  
  # # Remove Ubuntu Web Apps
  # yes | sudo apt-get remove unity-webapps-common xul-ext-unity xul-ext-websites-integration
  
  # basic packages
  sudo apt-get -y install wget curl golang jq tree stow git tmux
  
  # neovim
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y python-dev python-pip python3-dev python3-pip
  sudo add-apt-repository ppa:neovim-ppa/stable -y
  sudo apt-get update
  sudo apt-get install -y neovim

  # ripgrep
  install_ripgrep

  # fish
  sudo apt-add-repository ppa:fish-shell/release-2 -y
  sudo apt-get update
  sudo apt-get install -y fish

  # make git repos dir
  mkdir -p ~/repos
}

function deploy() {
  [ -f ~/.config/functions/fish_prompt.fish ] && \
    mv ~/.config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish.old
  
  # deploy .files with stow
  stow -v fish -t ~/.config/fish # fish
  stow -v neovim -t ~/.config/nvim # neovim
  stow -v git -t ~/ # git
  stow -v others -t ~/ # others
}

function clean() {
  # deploy .files with stow
  stow -vD fish -t ~/.config/fish
  stow -vD neovim -t ~/.config/nvim
  stow -vD git -t ~/
  stow -vD others -t ~/
}

# # delete rows for mac
# sed -i '/reattach/d' $HOME/.tmux.conf
# sed -i '/powerline/d' $HOME/.tmux.conf

if [ "$1" = "init" ]; then
  init
elif [ "$1" = "deploy" ]; then
  deploy $2
elif [ "$1" = "clean" ]; then
  clean
fi
