#!/bin/bash

# OS判定
if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
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
if [ "$OS" == 'redhat' ]; then
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
elif [ "$OS" == 'ubuntu' ]; then
  sudo apt-get -y update
  sudo apt-get -y upgrade
  # 『デスクトップ』『音楽』などの日本語フォルダー名を英語表記にする
  env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

  # デスクトップがフリーズした場合に備えて「Ctrl+Alt+Backspace」で強制終了を有効化
  #sudo dpkg-reconfigure keyboard-configuration

  # 文字化け対策
  gsettings set org.gnome.gedit.preferences.encodings auto-detected "['UTF-8','CURRENT','SHIFT_JIS','EUC-JP','ISO-2022-JP','UTF-16']"
  gsettings set org.gnome.gedit.preferences.encodings shown-in-menu "['UTF-8','SHIFT_JIS','EUC-JP','ISO-2022-JP','UTF-16']"

  # プラグインの追加
  # sudo apt-get install gedit-plugins

  # Ubuntu Web Apps(Gmail/Amazon/Twitter/Facebook)削除
  yes | sudo apt-get remove unity-webapps-common xul-ext-unity xul-ext-websites-integration

  # 基本ツール
  sudo apt-get -y install tree curl
  sudo apt-get -y install git
  sudo apt-get -y install vim vim-gnome
  sudo apt-get -y install tmux
  sudo apt-get -y install wget
fi

# zshをインストール
echo -e "\n>>> installing zsh\n"
if [ "$OS" == 'redhat' ]; then
  sudo yum install -y zsh #本体インストール
  echo -e "\nchsh needs your system password-"
  chsh -s /bin/zsh
elif [ "$OS" == 'ubuntu' ]; then
  # zsh
  sudo apt-get -y install zsh
  chsh -s /usr/bin/zsh

  # peco
  cd $HOME
  wget https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz
  tar xvzf $HOME/peco_linux_amd64.tar.gz
  sudo mv $HOME/peco_linux_amd64/peco /usr/local/bin
  rm -rf peco_linux_amd64 peco_linux_amd64.tar.gz

  # zprezto
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
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
dotfiles=(.vimrc .zshrc .zshrc_$(uname) .gitconfig .gitignore_global .tmux.conf .zsh .zpreztorc)
for dotfile in "${dotfiles[@]}"
do
  if [ -e $HOME/$dotfile ]; then
      rm -rf $HOME/$dotfile
  fi
  ln -s $HOME/dotfiles/$dotfile $HOME
done

touch $HOME/.zshrc_local

# zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# delete rows for mac
sed -i '/reattach/d' $HOME/.tmux.conf
sed -i '/powerline/d' $HOME/.tmux.conf

# # install dein.vim
# mkdir -p $HOME/.vim/dein
# wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
# sh ./installer.sh $HOME/.vim/dein/
#
# echo -e "\n-----------------[ deploying ]-----------------\n"
# # deploy
# if [ -e $HOME/.zshrc ]; then
#     rm $HOME/.zshrc 
# fi
# if [ -e $HOME/.vimrc ]; then
#     rm $HOME/.vimrc 
# fi
# if [ -e $HOME/.useful_zshrc ]; then
#     rm $HOME/.useful_zshrc 
# fi
# if [ -e $HOME/.vim ]; then
#     rm -r $HOME/.vim
# fi
#
# ln -s $HOME/dotfiles/.vimrc $HOME
# ln -s $HOME/dotfiles/.zshrc $HOME
# ln -s $HOME/dotfiles/.useful_zshrc $HOME
# ln -s $HOME/dotfiles/.vim $HOME
# ln -s $HOME/dotfiles/.gitignore_global $HOME
# ln -s $HOME/dotfiles/.gitconfig $HOME
#
# echo -e "\n-----[ Finished! Please reload your machine :) ]--------\n"
