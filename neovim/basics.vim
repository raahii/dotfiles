" appearance
syntax on
set background=dark
color gruvbox
highlight Folded ctermbg=Green ctermfg=Black

" basics
set number
set ignorecase
set smartcase
set ttyfast
set lazyredraw
set encoding=utf-8
set modifiable
set write
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fenc=utf-8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set undofile
set undodir=~/.config/nvim/undofiles
set noswapfile
set scrolloff=5
set nowritebackup
set nobackup
set backspace=indent,eol,start
set vb t_vb=
set novisualbell
set incsearch
set hlsearch
set mouse=a
set history=1000
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
set hidden
set ambiwidth=double
set splitright
set foldmethod=marker
set showmatch
set wildmenu
set tags=.tags

" clipboard
if has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif
