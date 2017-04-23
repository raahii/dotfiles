#!/bin/bash

#--------------------------------------------------
# TODO: 
# - ダウンロードした不要なファイルの削除
# - 今何をやっているかわかるような出力
# - その他のOS用の実装
#   (CentOSは仕方なくソースコードからvimをインスト
#   ールしたが、各OSのパッケージ管理システムを使え
#   ばもう少しましになるはず )
#--------------------------------------------------

# OS判定
# この後OSごとに別の処理を行う（予定）
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

# vim7.3を+clipboardで使えるようにインストール
if [ ! "$(which vim)" ]; then
    echo -e "\n-----------------[ installing vim ]-----------------\n"
    if [ "$OS" == 'redhat' ]; then
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

# zshをインストール
echo -e "\n-----------------[ installing zsh ]-----------------\n"
if [ "$OS" == 'redhat' ]; then
    sudo yum install -y zsh #本体インストール
    echo -e "\nchsh needs your system password-"
    chsh -s /bin/zsh
fi

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

echo -e "\n-----------------[ deploying ]-----------------\n"
# deploy
if [ -e $HOME/.zshrc ]; then
    rm $HOME/.zshrc 
fi
if [ -e $HOME/.vimrc ]; then
    rm $HOME/.vimrc 
fi
if [ -e $HOME/.useful_zshrc ]; then
    rm $HOME/.useful_zshrc 
fi
if [ -e $HOME/.vim ]; then
    rm -r $HOME/.vim
fi

ln -s $HOME/dotfiles/.vimrc $HOME
ln -s $HOME/dotfiles/.zshrc $HOME
ln -s $HOME/dotfiles/.useful_zshrc $HOME
ln -s $HOME/dotfiles/.vim $HOME
ln -s $HOME/dotfiles/.gitignore_global $HOME
ln -s $HOME/dotfiles/.gitconfig $HOME

echo -e "\n-----------------[ install dein.vim ]-----------------\n"
# install dein.vim
mkdir -p $HOME/.vim/dein
cd $HOME/.vim/dein/
wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
sh ./installer.sh $HOME/.vim/dein/
cd $HOME

echo -e "\n-----[ Finished! Please reload your machine :) ]--------\n"
