#!/bin/bash
#まだ機能しない
#require:
#   - wget or git

DOT_DIRECTORY="${HOME}/dotfiles"
#DOT_TARBALL="https://github.com/piyo56/dotfiles/tarball/master"
#REMOTE_URL="git@github.com:piyo56/dotfiles.git"
#
## ディレクトリがなければダウンロード（と解凍）する
#if [ ! -d ${DOT_DIRECTORY} ]; then
#  echo "Downloading dotfiles..."
#  mkdir ${DOT_DIRECTORY}
#
#  if type "git" > /dev/null 2>&1; then
#    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
#  else
#    wget -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
#    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
#    rm -f ${HOME}/dotfiles.tar.gz
#  fi
#
#  echo $(tput setaf 2)Download dotfiles complete!. ✔︎ $(tput sgr0)
#fi

# deploy
# ln -s .vimrc $HOME/.vimrc
# ln -s .zshrc $HOME/.zshrc

# dein.vim install
mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh $HOME/.vim/dein/repos/github.com/Shougo/dein.vim

# zsh install
ZSH_REMOTE_URL="https://github.com/zsh-users/zsh.git"
ZSH_TARBALL="https://github.com/zsh-users/zsh/tarball/master"
if type "git" > /dev/null 2>&1; then
    git clone --recursive "${ZSH_REMOTE_URL}" "${DOT_DIRECTORY}"
else
    wget -fsSLo ${HOME}/zsh.tar.gz ${ZSH_TARBALL}
    tar -zxf ${HOME}/zsh.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
    rm -f ${HOME}/zsh.tar.gz
fi
