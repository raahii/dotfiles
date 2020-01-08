" appearance
syntax on
set background=dark
color gruvbox
highlight Folded ctermbg=Green ctermfg=Black

" basics
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
set splitright " 画面分割の際に新しいウィンドウを右側に開く
set foldmethod=marker "fold
let g:vim_markdown_folding_disabled=1 " markdownの折りたたみなし
set showmatch "閉括弧が入力された時、対応する括弧を強調する
set wildmenu
set tags=.tags

" clipboard
if has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif
