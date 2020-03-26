filetype plugin indent on
syntax on
colorscheme torte

set number
set shiftwidth=4
set ignorecase
set autoindent
set incsearch
set lbr
set timeoutlen=0
set hidden
set splitbelow
set splitright
set expandtab
set display+=lastline
set textwidth=0
set wrapmargin=0
let fortran_free_source=1

noremap k gk
noremap j gj
noremap Q <Nop>
noremap K <C-w><C-w>

noremap <C-P> <C-b>
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>

noremap <F1> <Esc>:tabp<CR>
noremap <F2> <Esc>:tabn<CR>
noremap <F5> @a
noremap <F6> @s
inoremap <F10> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
noremap <F12> ggg?G

set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
