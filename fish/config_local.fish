# path
set -x PATH /usr/local/bin \
            /usr/bin \
            /bin \
            /usr/sbin \
            /sbin \
            /usr/local/texlive/2016/bin/x86_64-darwin \
            ~/sh \
            $PATH

# golang
set -x GOPATH ~/go
set -x PATH $PATH $GOPATH/bin

# nodebrew
set -x PATH ~/.nodebrew/current/bin $PATH

# pyenv
set -x PATH $HOME/.pyenv/shims $PATH
eval (pyenv init - | source)

# # direnv
# . (direnv hook fish)
