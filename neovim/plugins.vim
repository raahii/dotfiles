" automatic install vim-plug
let s:plug_dir = expand('~/.config/nvim/plugged')
if !isdirectory(s:plug_dir)
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let g:plug_window='botright new'

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
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile && yarn build'}
  Plug 'fannheyward/coc-markdownlint', {'do': 'yarn install --frozen-lockfile'}
  Plug 'josa42/coc-docker', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
" configs for coc.nvim {{{
set hidden
set updatetime=300
set shortmess+=c

" show diagnostic information with hover
augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
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
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> <Leader>p <Plug>(coc-diagnostic-prev)
nnoremap <silent> <Leader>n <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>ac <Plug>(coc-codeaction)
nnoremap <silent> <leader>qf <Plug>(coc-fix-current)
nnoremap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>m :<C-u>CocList mru<cr>
nnoremap <silent> <leader><leader> :<C-u>CocList<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>

autocmd CursorHold * silent call CocActionAsync('highlight')

" statuline config
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

let g:ale_fixers = {
  \ 'go': ['gofmt', 'goimports'],
  \ 'python': ['black', 'isort'],
  \ 'sh': ['shfmt'],
  \ 'html': ['prettier'],
  \ 'javascript': ['prettier'],
  \ 'yaml': ['prettier'],
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
Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/emmet-vim'

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

" github
Plug 'tyru/open-browser.vim'
  Plug 'k0kubun/vim-open-github'

" coding Tracker
Plug 'wakatime/vim-wakatime', { 'on': [] }

call plug#end()

" load asynchronously after start-up
augroup load_us_insert
    autocmd!
    autocmd InsertEnter * call plug#load(
      \ 'vim-wakatime',
      \ )| autocmd! load_us_insert
augroup END
