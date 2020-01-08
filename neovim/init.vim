filetype plugin indent on
syntax enable

" python paths
if has('nvim')
  let g:python_host_skip_check=1
  let g:python3_host_skip_check=1
  if has('macunix')
    let g:python_host_prog  = '/usr/local/bin/python2'
    let g:python3_host_prog = '/usr/local/bin/python3'
  elseif has('unix')
    let g:python_host_prog  = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'
  endif
endif

source ~/.config/nvim/basics.vim
source ~/.config/nvim/keymaps.vim
source ~/.config/nvim/plugins.vim
