" set leader key
let mapleader = "\<Space>"

" treat ctrl-j as esc
inoremap <C-j> <esc>
vnoremap <C-j> <esc>
cnoremap <C-j> <esc>
nnoremap <C-j> <esc>

" swap ; and :
noremap ; :
noremap : ;

" turn highlight off with esc twice
nnoremap <Esc><Esc> :noh<CR>
nnoremap <C-j><C-j> :noh<CR>

" window keymap
" nnoremap <Leader>i :split<Return>
" nnoremap <Leader>s :vsplit<Return>
map <Leader>h <C-w>h
map <Leader>k <C-w>k
map <Leader>j <C-w>j
map <Leader>l <C-w>l

" don't move cursor when highlighting word on cursor
nnoremap <silent><expr> * v:count ? '*': ':sil exe "keepj norm! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'
nnoremap <silent><expr> # v:count ? '#': ':sil exe "keepj norm! #" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'

" turn off IME when exiting normal mode
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" reaload init.vim
nnoremap <silent> <leader>c :source ~/.config/nvim/init.vim<CR>
