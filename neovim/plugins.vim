" automatic install vim-plug
let s:plug_dir = expand('~/.config/nvim/plugged')
if !isdirectory(s:plug_dir)
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins and settings
call plug#begin(s:plug_dir)

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" filer
Plug 'vifm/vifm.vim'
Plug 'scrooloose/nerdtree'
" configs of nerdtree {{{
noremap <C-e> :NERDTreeToggle<CR>
filetype plugin indent on
" let NERDTreeShowHidden=1
" }}}

" language server client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
  Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
  Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'}
  Plug 'josa42/coc-docker', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
  Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-tslint-plugin', {'do': 'yarn install --frozen-lockfile'}
  Plug 'fannheyward/coc-styled-components', {'do': 'yarn install --frozen-lockfile'}
  Plug 'weirongxu/coc-kotlin', {'do': 'yarn install --frozen-lockfile'}
  Plug 'fannheyward/coc-sql', {'do': 'yarn install --frozen-lockfile'}
" configs of coc.nvim {{{
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" show diagnostic information with hover
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" keymaps
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
xmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>ac <Plug>(coc-codeaction)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nmap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <silent> <leader>m :<C-u>CocList mru<cr>
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
nnoremap <silent> <leader><leader> :<C-u>CocList<cr>
nnoremap <silent> <leader>o :CocCommand git.browserOpen<CR>

let g:coc_snippet_next = '<tab>'
 
" " statuline config
" set statusline^=%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"}}}

Plug 'bfredl/nvim-miniyank'
"configs of nvim-miniyank{{{
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
"}}}

" formatting without blocking
Plug 'dense-analysis/ale'
" configs of ale {{{
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0

let g:ale_fixers = {
  \ 'go': ['gofmt', 'goimports'],
  \ 'python': ['black', 'isort'],
  \ 'sh': ['shfmt'],
  \ 'html': ['prettier'],
  \ 'javascript': ['prettier'],
  \ 'javascriptreact': ['prettier'],
  \ 'typescript': ['prettier'],
  \ 'typescriptreact': ['prettier'],
  \ 'vue': ['eslint'],
  \ 'yaml': ['prettier'],
  \ 'sql': [
  \   { buffer -> {
  \       'command': 'sql-formatter -l mysql'
  \   }},
  \ ]
\}

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '⚑'
let g:ale_sign_warning = '⚑'
" }}}

" fuzzy searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" configs of fzf.vim {{{
noremap <Leader>gf :GFiles<CR>
noremap <Leader>f :Files<CR>
noremap <Leader>r :Rg<CR>
" }}}

" operaion supports
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'mattn/emmet-vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" configs of snippets {{{
let g:UltiSnipsExpandTrigger="<c-k>"
" }}}

" languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlight

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" configs of vim-airline {{{
set noshowmode
set cmdheight=1
set laststatus=2
let g:airline_theme='angr'
"}}}

" Github
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
" configs of Github {{{
nnoremap <silent> <leader>o :'<,'>OpenGithubFile<CR>
" }}}

call plug#end()

" configs for nvim-treesitter
"{{{
lua<<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "go",
      "python",
      "java",
      "kotlin",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "vue",
      "sql",
      "yaml",
      "toml",
      "json",
      "dockerfile",
      "markdown",
      "fish"
    },
    sync_install = false,
    auto_install = true,
  }
EOF
"}}}
