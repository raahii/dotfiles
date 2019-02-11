#  PATH
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x EDITOR vim
set -x VISUAL vim
set -x HOMEBREW_BREWFILE $HOME/dotfiles/Brewfile

# alias
alias update 'brew update;and brew upgrade' # update
alias rm 'rmtrash'                          # rmtrash
alias pwdc 'pwd | pbcopy'                   # pwd copy
alias tree 'tree -NC'                       # tree with color
alias vi 'vim'                              # vim
alias im 'vim'
alias bim 'vim'
alias ls "ls -FG"
alias lsblk "diskutil list"
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
