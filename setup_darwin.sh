# install brew
if type brew >/dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install packages
brew install git curl wget peco jq tree rmtrash

# install vim

## 1. enable clipboard in vim
brew install vim
mkdir -p ~/.vim/undofiles

## 2. install dein
mkdir -p ~/.vim/dein
wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
sh ./installer.sh ~/.vim/dein
rm ./installer.sh

## 3. make symlinks for dotfiles
dotfiles=(.vimrc .vim/colors .vim/dein/plugins.toml)
for d in "${dotfiles[@]}" do
  ln -s $HOME/dotfiles/$d ~/
done

# install fish
dotfiles=(fishfile config.fish config_darwin.fish peco.fish)
for d in "${dotfiles[@]}" do
  ln -s $HOME/dotfiles/fish/$d ~/.config/fish/
done
brew install fish
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
# fisher

# install other dotfiles
dotfiles=(.gitconfig .gitignore_global .tmux.conf)
for d in "${dotfiles[@]}" do
  ln -s $HOME/dotfiles/$d ~/
done

echo "All done!"
exec "$(which $SHELL)" -l
