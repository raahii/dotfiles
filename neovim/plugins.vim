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
" configs for nerdtree {{{
noremap <C-e> :NERDTreeToggle<CR>
filetype plugin indent on
" let NERDTreeShowHidden=1
" }}}

" language server client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'fannheyward/coc-markdownlint', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'josa42/coc-docker', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile && yarn build'}
" configs for coc.nvim {{{
set hidden
set updatetime=200
set shortmess+=c

" show diagnostic information with hover
augroup mygroup
  autocmd!
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" keymaps
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>ac <Plug>(coc-codeaction)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nmap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>m :<C-u>CocList mru<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <leader><leader> :<C-u>CocList<cr>

autocmd CursorHold * silent call CocActionAsync('highlight')
let g:coc_snippet_next = '<tab>'

" statuline config
set statusline^=%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"}}}

" formatting without blocking
Plug 'dense-analysis/ale'
" configs for ale {{{
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
  \ 'yaml': ['prettier'],
  \ 'java': ['google_java_format'],
\}

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '⚑'
let g:ale_sign_warning = '⚑'
" }}}

" fuzzy Searching
Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" configs for fzf.vim {{{
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
" configs for snippets {{{
let g:UltiSnipsExpandTrigger="<c-k>"
" }}}

" languages
Plug 'cespare/vim-toml'
Plug 'ekalinin/dockerfile.vim'
Plug 'posva/vim-vue'
" configs for vim-vue {{{
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
"}}}

" status line
Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
" configs for vim-airline {{{
set noshowmode
set cmdheight=1
set laststatus=2
let g:airline_theme='angr'
"}}}

" coding tracker
Plug 'wakatime/vim-wakatime', { 'on': [] }

call plug#end()

" load asynchronously after start-up
augroup load_us_insert
  autocmd!
  autocmd InsertEnter * call plug#load(
    \ 'vim-wakatime',
    \ )| autocmd! load_us_insert
augroup END
