# install fisher
if not functions -q fisher
  echo "installing fisher..."
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  fish -c fisher
  fish_update_completions
end

# config
set fish_greeting ''
set HISTSIZE 10000
set -x GREP_COLOR '1;35;40'
set -x LESS '-i -M -R -S -W -z-4 -x4'

# global aliases
alias cp 'cp -i'
alias mv 'mv -i'
alias ll 'ls -al'
alias mkdir 'mkdir -p'
alias r 'eval $SHELL -l'
alias sudo 'sudo -E '
alias dc 'docker-compose'
alias vim 'nvim'
alias  vi 'nvim'
alias  im 'nvim'
alias bim 'nvim'

# languages, pyenv, rbenv...
. ~/.config/fish/config_langs.fish

# config for each operating system
set -x OS (uname | tr '[A-Z]' '[a-z]')
[ -f $HOME/.config/fish/config_$OS.fish ]; and . ~/.config/fish/config_$OS.fish
[ -f $HOME/.config/fish/config_local.fish ]; and . ~/.config/fish/config_local.fish
