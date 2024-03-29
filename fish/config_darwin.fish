set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"

set -x PATH /opt/homebrew/bin /Library/Developer/CommandLineTools $PATH
set -x PATH /usr/local/share/git-core/contrib/diff-highlight $PATH

# aliases
alias rm 'trash'          # trash
alias pwdc 'pwd | pbcopy' # pwd copy
alias ls "ls -FG"

# set fzf search command
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
