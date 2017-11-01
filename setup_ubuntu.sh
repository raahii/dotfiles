#!/bin/bash

#====================================================================
# aptのアップデート
#====================================================================
sudo apt-get -y update
sudo apt-get -y upgrade

#====================================================================
# 『デスクトップ』『音楽』などの日本語フォルダー名を英語表記にする
#====================================================================
env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

#====================================================================
# デスクトップがフリーズした場合に備えて「Ctrl+Alt+Backspace」で強制終了を有効化
#====================================================================
#sudo dpkg-reconfigure keyboard-configuration

#====================================================================
# 文字化け対策
#====================================================================
gsettings set org.gnome.gedit.preferences.encodings auto-detected "['UTF-8','CURRENT','SHIFT_JIS','EUC-JP','ISO-2022-JP','UTF-16']"
gsettings set org.gnome.gedit.preferences.encodings shown-in-menu "['UTF-8','SHIFT_JIS','EUC-JP','ISO-2022-JP','UTF-16']"

#====================================================================
# プラグインの追加
#====================================================================
sudo apt-get install gedit-plugins

#====================================================================
# Ubuntu Web Apps(Gmail/Amazon/Twitter/Facebook)削除
#====================================================================
yes | sudo apt-get remove unity-webapps-common xul-ext-unity xul-ext-websites-integration

#====================================================================
# ソフトウェアインストール
#====================================================================

# 便利ツール
sudo apt-get -y install tree curl
sudo apt-get -y install git
sudo apt-get -y install vim vim-gnome
sudo apt-get -y install tmux

# zsh
sudo apt-get -y install zsh
chsh -s /usr/bin/zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# peco
cd $HOME
wget https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz
tar xvzf $HOME/peco_linux_amd64.tar.gz
sudo mv $HOME/peco_linux_amd64/peco /usr/local/bin
rm -rf peco_linux_amd64 peco_linux_amd64.tar.gz

#====================================================================
# dotfilesのデプロイ
#====================================================================

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
dotfiles=(.vimrc .zshrc .zshrc_$(uname) .useful_zshrc .gitconfig .gitignore_global .tmux.conf .zsh)
for dotfile in "${dotfiles[@]}"
do
  if [ -e $HOME/$dotfile ]; then
      rm -rf $HOME/$dotfile
  fi
  ln -s $HOME/dotfiles/$dotfile $HOME
done

touch $HOME/.zshrc_local

# delete rows for mac
sed -i '/reattach/d' $HOME/.tmux.conf
sed -i '/powerline/d' $HOME/.tmux.conf

# when you are using ubuntu with virtualbox on mac, refer:
# http://blog.akagi.jp/archives/3599.html
