"""""""""""""""""""""""""""""
" basic setting
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
" ESCを二回押すことでハイライトを消す
nnoremap <Esc><Esc> :noh<CR>
nnoremap <C-j><C-j> :noh<CR>
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
" タブ機能を使おう！
nnoremap <C-n> gt
nnoremap <C-p> gT
" 自動的に閉じ括弧を入力
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" markdownの折りたたみなし
let g:vim_markdown_folding_disabled=1

"閉括弧が入力された時、対応する括弧を強調する
set showmatch

set wildmenu

" ctrl+jをescキーにする
inoremap <C-j> <esc>
vnoremap <C-j> <esc>
cnoremap <C-j> <esc>
nnoremap <C-j> <esc>

" usキーボードの場合は入れ替える
noremap ; :
noremap : ;

autocmd BufRead,BufNewFile *.slim setfiletype slim

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
call dein#add('tpope/vim-surround')       " 括弧の柔軟な操作
call dein#add('Shougo/vimproc', {'build' : 'make'}) "非同期実行
call dein#add('scrooloose/nerdtree')      " ディレクトリ情報を見れる
call dein#add('junegunn/vim-easy-align')  " アラインメント
call dein#add('mattn/emmet-vim')          " htmlコーディングを効率化
call dein#add('elzr/vim-json')            " jsonを綺麗に表示
call dein#add('Shougo/neocomplete.vim')   " 候補
call dein#add('Konfekt/FastFold')
call dein#add('Konfekt/FoldText')         " neocompleteでエラーがでるため追加
call dein#add('airblade/vim-gitgutter')   "
call dein#add('tomtom/tcomment_vim')      " コメントON/OFFを手軽に実行
call dein#add('posva/vim-vue')            " for vue.js
call dein#add('w0rp/ale')                 " lint
call dein#add('terryma/vim-multiple-cursors')
call dein#add('fatih/vim-go')
call dein#add('Vimjas/vim-python-pep8-indent')
call dein#add('dag/vim-fish ')

call dein#end()
filetype plugin indent on     " required!
filetype indent on
syntax on

" " If you want to install not installed plugins on startup.
" if dein#check_install()
"   call dein#install()
" endif

"# 文書内の"ex"などの単語がvimのコマンドと勘違いされることに対処
"http://s25r.blogspot.jp/2010/01/blog-post.html
autocmd FileType make set modelines=0
"}}}

""""""""""""""""""""
" matchit.vim
""""""""""""""""""""
"{{{
source $VIMRUNTIME/macros/matchit.vim
"}}}

""""""""""""""""""""
" Unite-vim
""""""""""""""""""""
"{{{
" バッファ一 覧
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
" gitgutter
""""""""""""""""""""
"{{{
let g:gitgutter_sign_added = '・'
let g:gitgutter_sign_modified = '・'
let g:gitgutter_sign_removed = '・'
let g:gitgutter_sign_removed_first_line = '・'
let g:gitgutter_sign_modified_removed = '・'
"}}}

""""""""""""""""""""
" multiple cursors
""""""""""""""""""""
"{{{
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction
"}}}

