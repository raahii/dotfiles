#!/bin/bash
#まだ機能しない
#require:
#   - wget or git

# OS判定してOSごとに別の処理を行う（予定）
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

#install vim 7.3 to enable clipboard :)
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
