#!/bin/bash
cd $TMPDIR
curl -L -O https://github.com/raahii/dotfiles/archive/main.zip
unzip main.zip -d ~/dotfiles
cd ~/dotfiles
make init && make deploy
