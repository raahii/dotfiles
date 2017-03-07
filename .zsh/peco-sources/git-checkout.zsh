function peco_git_recent_branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
        perl -pne 's{^refs/heads/}{}' | \
        peco --query "$LBUFFER")
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco_git_recent_branches

function peco_git_recent_all_branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes | \
        perl -pne 's{^refs/(heads|remotes)/}{}' | \
        peco --query "$LBUFFER")
    if [ -n "$selected_branch" ]; then
        branch_name_array=("${(s,/,)selected_branch}")
        branch_name=$branch_name_array[-1]
        BUFFER="git checkout ${branch_name}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco_git_recent_all_branches

function peco_git_tags () {
    local selected_tag="$(git tag -l | peco)"
    if [ -n "$selected_tag" ]; then
        BUFFER="git checkout refs/tags/${selected_tag}"
        zle accept-line
    fi
}
zle -N peco_git_tags
