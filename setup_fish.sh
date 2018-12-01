#!/bin/bash

# know os
if [ "$(uname)" == 'Darwin' ]; then
  OS='osx'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  declare -a info=($(./sh/get_linux_dist.sh))
  OS=${info[0]}
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

# update
echo -e ">>> installing vim, git etc"

if [ "$OS" == 'ubuntu' ]; then
  sudo apt-get -y update
  sudo apt-get -y upgrade
  if ! type "sudo" > /dev/null 2>&1
  then
    apt-get install -y sudo
  fi
  env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

  gsettings set org.gnome.gedit.preferences.encodings auto-detected "['UTF-8','CURRENT','SHIFT_JIS','EUC-JP','ISO-2022-JP','UTF-16']"
  gsettings set org.gnome.gedit.preferences.encodings shown-in-menu "['UTF-8','SHIFT_JIS','EUC-JP','ISO-2022-JP','UTF-16']"

  # 基本ツール
  sudo apt-get -y install tree curl
  sudo apt-get -y install git
  sudo apt-get -y install vim vim-gnome
  sudo apt-get -y install tmux
  sudo apt-get -y install wget
  sudo apt-get -y install software-properties-common
elif [ "$OS" == 'redhat' ]; then
  sudo yum -y update
  sudo yum -y upgrade

  if [ ! "$(which vim)" ]; then
    # clipboard有効に必要(多分)
    sudo yum install -y mercurial ncurses-devel make gcc
    sudo yum install -y gtk2-devel atk-devel libX11-devel libXt-devel

    # ダウンロードしてくるのに数分かかる
    cd /usr/local/src
    sudo hg clone https://bitbucket.org/vim-mirror/vim vim
    cd vim

    # コンパイル＆インストール
    sudo ./configure --with-features=huge --enable-multibyte --disable-selinux
    sudo make
    sudo make install
  fi
fi

# install fish
echo -e "\n>>> installing fish\n"
if [ "$OS" == 'ubuntu' ]; then
  # fish
  sudo apt-add-repository ppa:fish-shell/release-2
  sudo apt-get update
  sudo apt-get install -y fish

  # fisher
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

  # peco
  cd $HOME
  wget https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_amd64.tar.gz
  tar xvzf $HOME/peco_linux_amd64.tar.gz
  sudo mv $HOME/peco_linux_amd64/peco /usr/local/bin
  rm -rf peco_linux_amd64 peco_linux_amd64.tar.gz
elif [ "$OS" == 'redhat' ]; then
  echo 'not available'
fi

echo -e ">>> deploying dotfiles"
# clone
git clone https://github.com/piyo56/dotfiles $HOME/dotfiles
cd $HOME/dotfiles

# install dein
mkdir -p $HOME/.vim/dein
wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
sh ./installer.sh $HOME/.vim/dein && rm ./installer.sh

# vim colorthemes
ln -s $HOME/dotfiles/.vim/colors/ $HOME/.vim/colors

# symlink dotfiles
dotfiles=(.vimrc .gitconfig .gitignore_global .tmux.conf)

for dotfile in "${dotfiles[@]}"
do
  if [ -e ~/.config/fish/$dotfile ]; then
      rm -rf ~/.config/fish/$dotfile
  fi
  ln -s $HOME/dotfiles/fish/$dotfile ~/.config/fish/
done

.fishrc .fishrc_$(uname) 

touch ~/.config/fish/config_local.fish
chsh -s /usr/bin/fish
