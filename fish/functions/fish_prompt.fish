set fish_prompt_pwd_dir_length 0

# Git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch 242
set __fish_git_prompt_color_dirtystate FCBC47
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_upstream cyan

# Git Characters
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '⇢'
set __fish_git_prompt_char_upstream_prefix ' '
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_ahead '⇡'
set __fish_git_prompt_char_upstream_behind '⇣'
set __fish_git_prompt_char_upstream_diverged '⇡⇣'

function _print_in_color
  set -l string $argv[1]
  set -l color  $argv[2]

  set_color $color
  printf $string
  set_color normal
end

function _prompt_color_for_status
  if test $argv[1] -eq 0
    echo magenta
  else
    echo red
  end
end

function fish_prompt
  set -l last_status $status
  set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
  set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/")
  set -l host (hostname|cut -d . -f 1)
  
  _print_in_color "\n"$pwd green
  _print_in_color " on " white
  _print_in_color $host blue
  __fish_git_prompt " %s"

  _print_in_color "\n❯ " (_prompt_color_for_status $last_status)
end

function fish_right_prompt 
    date +"%H:%M"
end
