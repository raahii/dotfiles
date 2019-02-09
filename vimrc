"""""""""""""""""""""""""""""
" basic setting
""""""""""""""""""""""""""""""
"{{{
syntax on
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
set background=dark
colorscheme gruvbox

" enable undo
set undofile
set undodir=~/.vim/undofiles

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

"クリップボード設定
if has('mac')
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

" autocmd BufRead,BufNewFile *.slim setfiletype slim

"}}}

""""""""""
" dein.vim
""""""""""
"{{{
if &compatible
  set nocompatible
endif

" if dein.vim is not available, install it
let s:dein_dir = expand('~/.vim/dein')
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

"# 文書内の"ex"などの単語がvimのコマンドと勘違いされることに対処
"http://s25r.blogspot.jp/2010/01/blog-post.html
" autocmd FileType make set modelines=0
"}}}

""""""""""""""""""""
" Nerdtree
""""""""""""""""""""
"{{{
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
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion  =  1
let g:neocomplcache_max_list = 20
let g:neocomplcache_min_syntax_length = 3

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" 補完ウィンドウの設定
set completeopt=menuone
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

""""""""""""""""""""
" jedi-vim
""""""""""""""""""""
"{{{
if has('python3') && !has('patch-8.1.201')
  silent! python3 1
endif
autocmd FileType python setlocal completeopt-=preview
"}}}

""""""""""""""""""""
" vim-go
""""""""""""""""""""
"{{{
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
""}}}

""""""""""""""""""""
" vim-lsp
""""""""""""""""""""
"{{{
if executable('golsp')
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-lang',
        \ 'cmd': {server_info->['bingo', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
  augroup END
endif
"}}}
