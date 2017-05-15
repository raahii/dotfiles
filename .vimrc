"""""""""""""""""""""""""""""
"基本設定
""""""""""""""""""""""""""""""
"{{{
" シンタックスハイライト
syntax on
"カラーテーマ
set background=dark
colorscheme gruvbox
"undoファイルの作成
set undofile
set undodir=~/.vim/undofiles
" エンコード関係
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fenc=utf-8
"タブ幅の設定
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
"set autoindent
"swpファイルを作らない
set noswapfile
" スクロールする時に下が見えるようにする
set scrolloff=5
" バックアップファイルを作らない
set nowritebackup
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
set ambiwidth=double
" 対応括弧に'<'と'>'のペアを追加
"set matchpairs& matchpairs+=<:>
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
""クリップボード設定
if has('mac')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

"画面分割の際に新しいウィンドウを右側に開く
set splitright
"fold
set foldmethod=marker
"インデントのある長い行の折り返しの見た目が美しくなる
"set breakindent
" タブ機能を使おう！
nnoremap <C-n> gt
nnoremap <C-p> gT
" 自動的に閉じ括弧を入力
imap { {}<LEFT>
" imap [ []<LEFT>
" imap ( ()<LEFT>

" markdownの折りたたみなし
let g:vim_markdown_folding_disabled=1

"閉括弧が入力された時、対応する括弧を強調する
set showmatch

" ctrl+jをescキーにする
inoremap <C-j> <esc>
vnoremap <C-j> <esc>
cnoremap <C-j> <esc>
nnoremap <C-j> <esc>

" usキーボードの場合は入れ替える
noremap ; :
noremap : ;

"}}}

""""""""""""""""""""
" matchit.vim
""""""""""""""""""""
"{{{
source $VIMRUNTIME/macros/matchit.vim
"}}}

""""""""""
" dein.vim
""""""""""
"{{{
if &compatible
  set nocompatible
endif
set runtimepath^=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('$HOME/.vim/dein')) 
call dein#add('Shougo/dein.vim')          " dein自体をdeinで管理
call dein#add('Shougo/neomru.vim')        " a unite dependency
call dein#add('Shougo/unite.vim')         " unite
call dein#add('plasticboy/vim-markdown')  " markdown用
call dein#add('kannokanno/previm')        " markdown用
call dein#add('tyru/open-browser.vim')    " markdown用
call dein#add('tpope/vim-surround')       " 括弧の柔軟な操作
call dein#add('thinca/vim-quickrun')      " コンパイル
call dein#add('Shougo/vimproc', {'build' : 'make'}) "非同期実行
call dein#add('scrooloose/nerdtree')      " ディレクトリ情報を見れる
call dein#add('junegunn/vim-easy-align')  " アラインメント
call dein#add('scrooloose/syntastic.git') " シンタックスチェッカー
call dein#add('mattn/emmet-vim')          " htmlコーディングを効率化
call dein#add('elzr/vim-json')            " jsonを綺麗に表示
call dein#add('Shougo/neocomplete.vim')   " 候補
call dein#add('Konfekt/FastFold')
call dein#add('Konfekt/FoldText')         " neocompleteでエラーがでるため追加
"call dein#add('tpope/vim-rails' )         " Rails向けのコマンドを提供する
call dein#add('tpope/vim-endwise')        " Ruby向けにendを自動挿入してくれる
call dein#add('tomtom/tcomment_vim')      " コメントON/OFFを手軽に実行
call dein#add('NigoroJr/rsense')          " Rubyにおける強力な補完
call dein#add('othree/yajs.vim')
call dein#add("pangloss/vim-javascript")
call dein#add("mxw/vim-jsx")
call dein#add('fatih/vim-go')             "Go
call dein#add('tpope/vim-haml') " haml
call dein#end()
filetype plugin indent on     " required!
filetype indent on
syntax on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"# 文書内の"ex"などの単語がvimのコマンドと勘違いされることに対処
"http://s25r.blogspot.jp/2010/01/blog-post.html
autocmd FileType make set modelines=0
"}}}

""""""""""""""""""""
" Unite-vim
""""""""""""""""""""
"{{{
" バッファ一覧
"noremap <C-P> :Unite buffer<CR>
" ファイル一覧
"noremap <C-N> :Unite -buffer-name=file file<CR>

" 最近使ったファイルの一覧
noremap <C-z> :Unite file_mru<CR>
" NERDTree
noremap <C-e> :NERDTreeToggle<CR>
" Required:
filetype plugin indent on
"}}}

""""""""""""""""""""
" QuickRun
""""""""""""""""""""
"{{{
let c_opt = "-std=c99 -lm -ljpeg -framework GLUT -framework OpenGL -Wno-deprecated"
let cpp_opt = "-std=c++11"

let g:quickrun_config = {
\   "c/gcc" : {
\       "cmdopt" : c_opt
\   },
\   "cpp/g++" : {
\       "cmdopt" : cpp_opt
\   },
\   "tex" : {
\       'command' : 'latexmk',
\       'hook/cd/directory': '%S:h',
\       'exec': '%c %s'
\   },
\   "_" : {
\       "runner"    : 'vimproc',
\       "runner/vimproc/updatetime" : 60,
\       "outputter" : 'error',
\       "outputter/error/success" : "buffer",
\       "outputter/error/error"   : "quickfix",
\       "outputter/buffer/split"  : ":45vs",
\       "outputter/buffer/close_on_empty" : 1
\   }
\ }
"q でquickfixを閉じれるようにする。
au FileType qf nnoremap <silent><buffer>q :quit<CR>
"<C-c> でquickrunを停止
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
"}}}

""""""""""""""""""""
" Syntastic
""""""""""""""""""""
"{{{
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_python_exec = '/usr/local/var/pyenv/shims/python'
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
\}
    "\ 'active_filetypes': ['c', 'html', 'css', 'javascript', 'python', 'ruby', 'php'],
" augroup AutoSyntastic autocmd!
"     autocmd InsertLeave,TextChanged * call s:syntastic() 
" augroup END
" function! s:syntastic()
"     SyntasticCheck
" endfunction
"}}}

""""""""""""""""""""
" vim-easy-align
""""""""""""""""""""
"{{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}}

""""""""""""""""""""
" NeoComplete
""""""""""""""""""""
"{{{
" neocomplete用設定
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
"}}}

""""""""""""""""""""
" vim-json
""""""""""""""""""""
"{{{
let g:vim_json_syntax_conceal = 0
"}}}

""""""""""""""""""""
" jsx
""""""""""""""""""""
"{{{
" js 拡張子でも有効にする
let g:jsx_ext_required = 0
" @jsx React.DOM プラグマがある場合のみ有効にする
let g:jsx_pragma_required = 1
"}}}
