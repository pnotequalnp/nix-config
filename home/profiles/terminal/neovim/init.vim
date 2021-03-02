" {{{ Settings
set nocompatible

set ttimeout ttimeoutlen=0

set completeopt=menuone,noinsert,noselect
set shortmess+=ac
set wildmenu

set number relativenumber
set ignorecase smartcase incsearch

set tildeop
set backspace=indent,eol,start
set nojoinspaces

set splitbelow splitright

set autoindent smartindent expandtab softtabstop=2 shiftwidth=2 tabstop=2

set showmatch matchtime=2

set updatetime=300

set nowrap linebreak

set list listchars=tab:>=>,trail:×,extends:⋯,precedes:⋯,nbsp:␣
set fillchars=fold:\ 
set showbreak=↪

set colorcolumn=100

set scrolloff=1
set sidescrolloff=1

set hidden autoread

set clipboard+=unnamedplus

filetype indent plugin on

let g:loaded_netrwPlugin=1

set termguicolors
syntax enable
let &t_VS = "\<esc>[1 q"
let &t_EI = "\<esc>[1 q"
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"

set history=256
set undofile undodir=$XDG_CACHE_HOME/vim/undo
set swapfile dir=$XDG_CACHE_HOME/vim/swap
set backup backupdir=$XDG_CACHE_HOME/vim/backup
" }}}
" {{{ Mappings
noremap <Space> <Nop>
let mapleader="\<Space>"
" let maplocalleader="\<Space>\<Space>"

vnoremap az :<C-U>silent! normal! [zV]z<CR>
vmap iz az
omap az :normal Vaz<CR>
omap iz :normal Vaz<CR>

nnoremap <silent> Y y$
nnoremap <silent> <leader>` <C-^>
nnoremap <silent> <Esc> <Esc>:nohlsearch<CR>
nnoremap <silent> <leader><leader> :Files<CR>
nnoremap <silent> <leader>/ :Rg<CR>
nnoremap <silent> <leader>< :Buffers<CR>
nnoremap <silent> <leader>bb :Buffers<CR>
nnoremap <silent> <leader>fs :w<CR>
nnoremap <silent> <leader>qq :qa<CR>
nnoremap <silent> <leader>qQ :qa!<CR>
nnoremap <silent> zx :bd<CR>

nnoremap <silent> <leader>wq <C-w>q
nnoremap <silent> <leader>wv <C-w>v
nnoremap <silent> <leader>ws <C-w>s
nnoremap <silent> <leader>wh <C-w>h
nnoremap <silent> <leader>wj <C-w>j
nnoremap <silent> <leader>wk <C-w>k
nnoremap <silent> <leader>wl <C-w>l
nnoremap <silent> <leader>wH <C-w>H
nnoremap <silent> <leader>wJ <C-w>J
nnoremap <silent> <leader>wK <C-w>K
nnoremap <silent> <leader>wL <C-w>L
nnoremap <silent> <leader>wmm <C-w>o

" nnoremap <silent> <BS> <C-^>
" nnoremap <silent> <leader>. q:

" nnoremap <silent> # #:noh<CR>
" nnoremap <silent> * *:noh<CR>
" noremap <silent> <leader>/ :nohlsearch<CR>

map <silent> Q <Nop>
map <silent> gQ <Nop>
map <silent> gH <Nop>

xnoremap <silent> cc c
xnoremap <silent> dd d
" }}}
" {{{ Colors
colorscheme neodark
highlight Folded guibg=#18181A
highlight Normal guibg=#1E2127
highlight ColorColumn guibg=#222830
highlight SpecialKey guibg=#1E2127 guifg=#3E4147
" }}}
" {{{ vim-sandwich
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1

nmap <silent> ys <Plug>(operator-sandwich-add)
xmap <silent> ys <Plug>(operator-sandwich-add)
omap <silent> ys <Plug>(operator-sandwich-g@)
nmap <silent> cs <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
xmap <silent> cs <Plug>(operator-sandwich-replace)
nmap <silent> csb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nmap <silent> ds <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
xmap <silent> ds <Plug>(operator-sandwich-delete)
nmap <silent> dsb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
" }}}
" {{{ fzf-vim
let g:fzf_buffers_jump=1

" nmap <silent> <leader>fa :Lines<CR>
" nmap <silent> <leader>fb :Buffers<CR>
" nmap <silent> <leader>fc :Commands<CR>
" nmap <silent> <leader>ff :Files<CR>
" nmap <silent> <leader>fg :GFiles<CR>
" nmap <silent> <leader>fh :Helptags<CR>
" nmap <silent> <leader>fH :History:<CR>
" nmap <silent> <leader>fl :BLines<CR>
" nmap <silent> <leader>fm :Maps<CR>
" nmap <silent> <leader>fr :Rg<CR>
" nmap <silent> <leader>fw :Windows<CR>
" }}}
" {{{ vim-easy-align
nmap <silent> X <Plug>(EasyAlign)
xmap <silent> X <Plug>(EasyAlign)
" }}}
" {{{ vim-exchange
nmap <silent> gx <Plug>(Exchange)
xmap <silent> gx <Plug>(Exchange)
nmap <silent> gxc <Plug>(ExchangeClear)
nmap <silent> gxs <Plug>(ExchangeLine)
" }}}
" {{{ vim-easymotion
map <silent> x <Plug>(easymotion-prefix)
let g:EasyMotion_verbose=0
" }}}
" {{{ indentLine
let g:indentLine_char = '│'
let g:indentLine_bgcolor_gui='#1E2127'
" }}}
" {{{ pear-tree
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
" }}}
" {{{ vim-exchange
let g:exchange_no_mappings=1
" }}}
" {{{ vim-rainbow
let g:rainbow_active=1

let g:rainbow_guifgs=[
            \ 'deepSkyBlue',
            \ 'MediumPurple1',
            \ 'springGreen3',
            \ 'DarkOrange1',
            \ 'HotPink1',
            \ 'purple2',
            \ 'firebrick1',
            \ 'springGreen2',
            \ 'cyan2',
            \ ]
" }}}
" {{{ vimtex
" let g:vimtex_view_method='zathura'
" let g:vimtex_quickfix_mode=0
" let g:vimtex_fold_enabled=1
" let g:tex_flavor='latex'
" augroup vimtex
  " autocmd!
  " autocmd VimLeave *.tex,*.sty :VimtexClean
" augroup END
" }}}
" vim:fdm=marker
