#!/bin/bash
cd $TMPDIR
curl -L -O https://github.com/raahii/dotfiles/archive/main.zip
unzip main.zip
rm main.zip
mv dotfiles-main ~/dotfiles
cd ~/dotfiles
make init && make deploy
