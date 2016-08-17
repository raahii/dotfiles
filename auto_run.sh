#!/bin/bash
set -e

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

# dein.vim install
mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh $HOME/.vim/dein/

# zshをインストール
echo -e "\n-----------------[ installing zsh ]-----------------\n"
if [ "$OS" == 'redhat' ]; then
    sudo yum install -y zsh #本体インストール
    echo -e "\nchsh needs your system password-"
    chsh -s /bin/zsh
fi

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# deploy
rm $HOME/.zshrc $HOME/.vimrc
ln -s "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"
ln -s "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/dotfiles/.useful_zshrc" "$HOME/.useful_zshrc"
exec $SHELL -l

echo "-------- Please reload your machine :) ----------"
