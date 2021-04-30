filetype plugin indent on
syntax enable

" python paths
if has('nvim')
  let g:python_host_skip_check=1
  let g:python3_host_skip_check=1
endif

source ~/.config/nvim/basics.vim
source ~/.config/nvim/keymaps.vim
source ~/.config/nvim/plugins.vim
