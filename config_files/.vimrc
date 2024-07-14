" Plugins
set nocompatible               " turns off legacy vi mode
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'mileszs/ack.vim'
call vundle#end()            " required
filetype plugin indent on     " required!

" Ack options
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ack_autoclose = 1

syntax on
colorscheme torte
let g:netrw_banner = 0

set number
set shiftwidth=3
set ignorecase
set autoindent
set incsearch
set lbr
set timeoutlen=500
set hidden
set splitbelow
set splitright
set expandtab
set visualbell
set textwidth=80
set autochdir
set showmode
set showcmd
set ruler
set laststatus=1
set hlsearch
set belloff=all

" Undo options
set undofile
set undodir=$HOME/.vim/undo
set undolevels=10000
set undoreload=100000

noremap k gk
noremap j gj
noremap Q <Nop>
noremap <F1> <Nop>
noremap <F2> <Nop>
noremap K <C-w><C-w>
noremap <C-P> <C-B>
command Wall wall
nnoremap _ :Explore<CR>
noremap <F5> @a
inoremap <F12> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
map <F11> <Esc>:call Maximize()<CR>

" Leader commands
let mapleader = " "
map <leader><Space> :noh<CR>
map <leader>h <C-w>h
map <leader>l <C-w>l
map <leader>k <C-w>k
map <leader>j <C-w>j
map <leader>f :Ack!<space>
map <leader>g :let @/=expand("<cword>")<Bar>wincmd w<Bar>normal n<CR>

" Tabs
noremap <C-1> <Esc>:tabn 1<CR>
noremap <C-2> <Esc>:tabn 2<CR>
noremap <C-3> <Esc>:tabn 3<CR>
noremap <C-4> <Esc>:tabn 4<CR>
noremap <C-5> <Esc>:tabn 5<CR>
noremap <C-6> <Esc>:tabn 6<CR>
noremap <C-7> <Esc>:tabn 7<CR>
noremap <C-8> <Esc>:tabn 8<CR>
noremap <C-9> <Esc>:tablast<CR>
noremap <Tab> <Esc>:tabn<CR>
noremap <S-Tab> <Esc>:tabp<CR>

"https://stackoverflow.com/questions/20979403/how-to-add-total-line-count-of-file-to-vim-status-bar
set statusline =%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

" Colors for statusline
hi User1 ctermfg=red ctermbg=darkgray
hi User2 ctermfg=green ctermbg=darkgray
hi User3 ctermfg=black ctermbg=darkgray
hi User4 ctermfg=black ctermbg=darkgray
hi User5 ctermfg=black ctermbg=darkgray
