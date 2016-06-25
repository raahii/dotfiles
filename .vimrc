""""""""""""""""""""""""""""""
"基本設定
" ref: http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
"""""""""""""""""""""""""""
" シンタックスハイライト
"set t_ut= "http://goo.gl/4DErGe
syntax on
"undoファイルの作成
set undofile
set undodir=~/.vim/undofiles
" エンコード関係
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fenc=utf-8
"タブ幅の設定
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
"swpファイルを作らない
set noswapfile
" スクロールする時に下が見えるようにする
set scrolloff=5
" バックアップファイルを作らない
set nowritebackup
" バックアップをしない
set nobackup
" バックスペースで各種消せるようにする
set backspace=indent,eol,start
" ビープ音を消す
set vb t_vb=
set novisualbell
" 行番号を表示
set number
" 小文字の検索でも大文字も見つかるようにする
set ignorecase
" ただし大文字も含めた検索の場合はその通りに検索する
set smartcase
" インクリメンタルサーチを行う
set incsearch
" 検索結果をハイライト表示
set hlsearch
" マウスモード有効
set mouse=a 
" コマンド、検索パターンを1000個まで履歴に残す
set history=1000
"タブ、空白、改行の可視化
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
"bufferで複数ファイルをswitchするときに未保存のものがあっても警告を出さない
set hidden
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
""クリップボード設定
set clipboard=unnamed
"set clipboard=unnamedplus
"画面分割の際に新しいウィンドウを右側に開く
set splitright

""""""""""""""""""""""""""""""
" コンパイル関係
""""""""""""""""""""""""""""""
"command! PYTHON call s:PYTHON()
command! JAVA call s:JAVAC()

"nmap <F12> :PYTHON<CR>
nmap <C-j> :JAVA<CR>

"function! s:PYTHON()
"		:w
"		!python %
"endfunction
function! s:JAVAC()
	:w
	!javac % 
	!java %:r
endfunction

"command! CLANG call s:CLANG()
"command! GRAPHVIZ call s:GRAPHVIZ()
"command! TEX call s:TEX()
"command! SUBTEX call s:TEX_WITH_RES()
"nmap <F10> :JAVA<CR>
"nmap <C-F10> :GRAPHVIZ<CR>
"nmap <C-F11> :TEX<CR>
"nmap <A-F11> :SUBTEX<CR>
"nmap <C-F12> :CLANG<CR>

"function! s:GRAPHVIZ()
"	:w
"	!dot -T svg % -o %:r.svg
"endfunction
"
"function! s:TEX()
"	:w
"	"!$HOME/sh/pdfplatex %
"	call system('$HOME/sh/pdfplatex '.bufname("%").' > error.log')
"endfunction

"function! s:EXP()
"	:w
"	:QuickRun c/gcc
"endfunction

"function! s:CLANG()
"	:w
"	:!clang % -o %:r.out -lm
"	:!./%:r.out
"endfunction
""""""""""
" dein.vim
""""""""""
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('plasticboy/vim-markdown')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
call dein#add('tpope/vim-surround')
call dein#add('thinca/vim-quickrun')
call dein#add('Shougo/vimproc')
call dein#add('othree/html5.vim')
call dein#add('hail2u/vim-css3-syntax')
call dein#add('jelera/vim-javascript-syntax')
call dein#end()
filetype plugin indent on     " required!
filetype indent on
syntax on

"QuickRun.vimの設定
"千葉大学三年情報画像実験画像処理用に-ljpegオプションを付ける
"cmdopt" : \"-framework GLUT -framework OpenGL"
let g:quickrun_config = {
\   "c/gcc" : {
    \   "cmdopt" : "-Wall -lm -ljpeg"
\   },
\   "cpp/g++" : {
\       "cmdopt" : "-std=c++11"
\   },
\   "_" : {
\       "runner"    : 'vimproc',
\       "runner/vimproc/updatetime" : 60,
\       "outputter" : 'error',
\       "outputter/error/success" : "buffer",
\       "outputter/error/error"   : "quickfix",
\       "outputter/buffer/split"  : "vertical",
\       "outputter/buffer/close_on_empty" : 1
\   }
\ }
"q でquickfixを閉じれるようにする。
au FileType qf nnoremap <silent><buffer>q :quit<CR>
"<C-c> でquickrunを停止
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
"
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>

" Required:
filetype plugin indent on
