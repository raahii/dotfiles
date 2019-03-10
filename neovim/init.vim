"""""""""""""""""""""""""""""
" basic setting
""""""""""""""""""""""""""""""
set ttyfast
set lazyredraw
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fenc=utf-8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab

" color scheme
syntax on
color gruvbox

" enable undo
set undofile
set undodir=~/.config/nvim/undofiles

set noswapfile "swpファイルを作らない
set scrolloff=5 " スクロールする時に下が見えるようにする
set nowritebackup
set nobackup " バックアップファイルを作らない
set backspace=indent,eol,start " バックスペースで各種消せるようにする
set vb t_vb=
set novisualbell " ビープ音を消す
set number " 行番号を表示
set ignorecase " 小文字の検索でも大文字も見つかるようにする
set smartcase " ただし大文字も含めた検索の場合はその通りに検索する
set incsearch " インクリメンタルサーチを行う
set hlsearch " 検索結果をハイライト表示
set mouse=a " マウスモード有効
set history=1000 " コマンド、検索パターンを1000個まで履歴に残す
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:% "タブ、空白、改行の可視化
set hidden "bufferで複数ファイルをswitchするときに未保存のものがあっても警告を出さない
set ambiwidth=double

" ESCを二回押すことでハイライトを消す
nnoremap <Esc><Esc> :noh<CR>
nnoremap <C-j><C-j> :noh<CR>

" クリップボード設定
if has('mac')
  " nvimでclipboard.vimのloadが遅い問題(+250ms)
  " https://goo.gl/we3szX
  let g:clipboard = {'copy': {'+': 'pbcopy', '*': 'pbcopy'}, 'paste': {'+': 'pbpaste', '*': 'pbpaste'}, 'name': 'pbcopy', 'cache_enabled': 0}
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

set splitright " 画面分割の際に新しいウィンドウを右側に開く
set foldmethod=marker "fold

" タブ機能
nnoremap <C-n> gt
nnoremap <C-p> gT

let g:vim_markdown_folding_disabled=1 " markdownの折りたたみなし
set showmatch "閉括弧が入力された時、対応する括弧を強調する
set wildmenu
set tags=.tags

" ctrl+jをescキーにする
inoremap <C-j> <esc>
vnoremap <C-j> <esc>
cnoremap <C-j> <esc>
nnoremap <C-j> <esc>

" usキーボードの場合は入れ替える
noremap ; :
noremap : ;

" python paths
let g:python_host_skip_check=1
let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_skip_check=1
let g:python3_host_prog = '/usr/local/bin/python3'

""""""""""
" dein.vim
""""""""""
if &compatible
  set nocompatible
endif

" if dein.vim is not available, install it
let s:dein_dir = expand('~/.config/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" configuration
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let s:toml = s:dein_dir . '/plugins.toml'
  call dein#load_toml(s:toml, {'lazy': 0}) 
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
