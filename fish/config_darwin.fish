#  PATH
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x EDITOR nvim
set -x VISUAL nvim
set -x HOMEBREW_BREWFILE $HOME/dotfiles/Brewfile

# alias
alias update 'brew update;and brew upgrade' # update
alias rmt 'rmtrash'                          # rmtrash
alias pwdc 'pwd | pbcopy'                   # pwd copy
alias tree 'tree -NC'                       # tree with color
alias ls "ls -FG"
alias lsblk "diskutil list"
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
