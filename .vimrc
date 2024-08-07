" Plugins
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mileszs/ack.vim'
filetype plugin indent on

" Ack plugin options
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ack_autoclose = 1

" Appearance
syntax on
colorscheme torte
let g:netrw_banner = 0

" Line wrapping
set fo+=t
set nowrap
set textwidth=80
autocmd FileType * set formatoptions+=t
autocmd BufEnter * highlight OverLength ctermbg=blue guibg=#111111
autocmd BufEnter * match OverLength /\%82v.*/

" Visible tabs and trailing spaces
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd FileType * match WhitespaceEOL /\s\+$/
set list listchars=tab:\|-

" Undo options
set undofile
set undodir=$HOME/.vim/undo
set undolevels=10000
set undoreload=100000

" Misc options
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
set belloff=all
set autochdir
set showmode
set showcmd
set ruler
set laststatus=1
set hlsearch

" Misc Mappings
noremap k gk
noremap j gj
noremap Q <Nop>
noremap <F1> <Nop>
noremap <F2> <Nop>
noremap K <C-w><C-w>
noremap <C-P> <C-B>
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
command Wall wall
nnoremap _ :Explore<CR>
noremap <F5> @a
inoremap <F12> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" Leader commands
let mapleader = " "
map <leader><Space> :noh<CR>
map <leader>h <C-w>h
map <leader>l <C-w>l
map <leader>k <C-w>k
map <leader>j <C-w>j
map <leader>f :Ack!<space>
map <leader>g :let @/=expand("<cword>")<Bar>wincmd w<Bar>normal n<CR>

" Leader commands for Tabs
map <leader>1 <Esc>:tabn 1<CR>
map <leader>2 <Esc>:tabn 2<CR>
map <leader>3 <Esc>:tabn 3<CR>
map <leader>4 <Esc>:tabn 4<CR>
map <leader>5 <Esc>:tabn 5<CR>
map <leader>6 <Esc>:tabn 6<CR>
map <leader>7 <Esc>:tabn 7<CR>
map <leader>8 <Esc>:tabn 8<CR>
map <leader>9 <Esc>:tablast<CR>
map <leader>n <Esc>:tabn<CR>
map <leader>p <Esc>:tabp<CR>


" LaTeX in Markdown
function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
"    hi link math Statement
"    hi link liquid Statement
"    hi link highlight_block Function
    hi link math_block Boolean
endfunction

" Markdown options
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown set spell

" Automatically highlight Kconfig files
au BufNewFile,BufRead Kconfig,Kconfig.debug,*.in setf kconfig

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
