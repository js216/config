" Plugins
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mileszs/ack.vim'
filetype plugin indent on
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ack_autoclose = 1

" Appearance
syntax on
colorscheme torte
let g:netrw_banner = 0

" Line wrapping
set formatoptions+=t "auto-wrap using textwidth
set textwidth=80
autocmd FileType * set formatoptions+=t
set nowrap
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
noremap K <C-w><C-w>
noremap <C-P> <C-B>
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
command Wall wall
nnoremap _ :Hexplore<CR>
nnoremap + :Explore<CR>

" Copy to clipboard
noremap Y "+y
"vnoremap Y "+y
"onoremap Y y

" Leader commands
let mapleader = " "
map <leader><Space> :noh<CR>
map <leader>h <C-w>h
map <leader>l <C-w>l
map <leader>k <C-w>k
map <leader>j <C-w>j
map <leader>f :Ack!<space>
map <leader>g :let @/=expand("<cword>")<Bar>wincmd w<Bar>normal n<CR>
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
map <leader>d <Esc>:bd<CR>
map <leader>q <Esc>:q<CR>

" Function keys
map <F1> <Esc>:tabp<CR>
map <F2> <Esc>:tabn<CR>
map <F3> <Nop>
map <F4> <Nop>
noremap <F5> @a
inoremap <F12> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" Tab line formatter function
function! Tabline() abort
   let l:line = ''
   let l:current = tabpagenr()
   for l:i in range(1, tabpagenr('$'))
      " Distinguish between current and other tabs
      if l:i == l:current
         let l:line .= '%#TabLineSel#'
      else
         let l:line .= '%#TabLine#'
      endif
      " Put filename in the tab label
      let l:label = fnamemodify(
               \ bufname(tabpagebuflist(l:i)[tabpagewinnr(l:i) - 1]),
               \ ':t'
               \ )
      " Add '[+]' if one of the buffers in the tab page is modified
      let bufnrlist = tabpagebuflist(l:i)
      for bufnr in bufnrlist
         if getbufvar(bufnr, "&modified")
            let l:label .= '[+]'
            break
         endif
      endfor
      " Assemble tab line from tab labels
      let l:line .= '%' .  i .  'T' " Starts mouse click target region.
      let l:line .= ' ' .  l:label .  ' '
   endfor
   " Finish the tab line
   let l:line .= '%#TabLineFill#'
   let l:line .= '%T' " Ends mouse click target region(s).
   return l:line
endfunction

" Format tab line
set tabline=%!Tabline()
highlight TabLine ctermbg=lightgrey ctermfg=black
highlight TabLineSel ctermbg=blue

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

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown set spell

" Automatically highlight Kconfig files
au BufNewFile,BufRead Kconfig,Kconfig.debug,*.in setf kconfig

"https://stackoverflow.com/questions/20979403/how-to-add-total-line-count-of-file-to-vim-status-bar
set statusline =%1*\ %n\ %*     "buffer number
set statusline +=%5*%{&ff}%*    "file format
set statusline +=%3*%y%*        "file type
set statusline +=%4*\ %<%F%*    "full path
set statusline +=%2*%m%*        "modified flag
set statusline +=%1*%=%5l%*     "current line
set statusline +=%2*/%L%*       "total lines
set statusline +=%1*%4v\ %*     "virtual column number
set statusline +=%2*0x%04B\ %*  "character under cursor

" Colors for statusline (terminal mode)
hi StatusLineNC cterm=NONE
hi User1 ctermfg=black ctermbg=cyan
hi User2 ctermfg=black ctermbg=cyan
hi User3 ctermfg=black ctermbg=cyan
hi User4 ctermfg=black ctermbg=cyan
hi User5 ctermfg=black ctermbg=cyan
