"automatic install vim-plug
let s:plug_dir = expand('~/.config/nvim/plugged')
if !isdirectory(s:plug_dir)
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins and settings
call plug#begin(s:plug_dir)

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Filer
Plug 'vifm/vifm.vim'
Plug 'scrooloose/nerdtree'
" configs for nerdtree {{{
noremap <C-e> :NERDTreeToggle<CR>
filetype plugin indent on
" }}}

" Language Server Client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" configs for coc.nvim {{{
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> <Leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>n <Plug>(coc-diagnostic-next)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap keys for gotos
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>rn <Plug>(coc-rename)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ac  <Plug>(coc-codeaction) " Remap for do codeAction of current line
nmap <leader>qf  <Plug>(coc-fix-current) " Fix autofix problem of current line

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>h  :<C-u>CocListResume<CR>
"}}}

" File / Line Fuzzy Searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" configs for fzf.vim {{{
noremap <Leader>gf :GFiles<CR>
noremap <Leader>ff :Files<CR>
noremap <Leader>r :Rg<CR>
" }}}

" Operaion Supports
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'preservim/nerdcommenter'
" configs for nerdcommenter {{{
noremap gcc :NERDCommenterToggle<CR>
" }}}
Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/emmet-vim'

" Languages
Plug 'cespare/vim-toml'
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

" Status line
Plug 'vim-airline/vim-airline'
" configs for vim-airline {{{
set noshowmode
set cmdheight=1
set laststatus=2
let g:airline_theme='angr'
"}}}
Plug 'vim-airline/vim-airline-themes'

" Github
Plug 'tyru/open-browser.vim'
Plug 'k0kubun/vim-open-github'

" Coding Tracker
Plug 'wakatime/vim-wakatime', { 'on': [] }

call plug#end()

" load asynchronously after start-up
augroup load_us_insert
    autocmd!
    autocmd InsertEnter * call plug#load(
      \ 'vim-wakatime',
      \ )| autocmd! load_us_insert
augroup END
