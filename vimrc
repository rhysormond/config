" enable plugins
execute pathogen#infect()

" save long long command history
set history=10000

" enable file type plugins
filetype indent plugin on

" Unicode support
set encoding=utf8

" prevent automatic backups
set nowb
set nobackup
set noswapfile

" colors
syntax on
set t_Co=256
colorscheme jellybeans

" general configuration
set hidden " hide buffers rather than abandoning them
set spell spelllang=en_us " spell checking

" window settings
set winwidth=84 " focused split width
set winheight=30 " focused split height
silent! set winminwidth=84 " minimum split width
silent! set winminheight=10 " minimum split height

" line breaks
set wrap " visually wrap lines
set nolist " list disables line break
set linebreak " only wrap at specific characters

" highlighting
set showmatch " highlight matching braces
set cursorline " highlight current cursor line
set colorcolumn=81 " highlight the over-length column

" line numbers
set ruler " show row,col position
set number " show line numbers
set relativenumber " relative line numbers
set scrolloff=5 " 5 lines of scroll buffer

" command & status lines
set showcmd " always show the current command
set showmode " show current mode (insert, visual)
set cmdheight=1 " height of the command line
set laststatus=2 " always show the status line

" tab behavior
set expandtab " tab inserts spaces instead of tabs
set autoindent " auto indent
set shiftwidth=4 " automatic indentation width
set softtabstop=4 " tab space equivalents

" configure backspace so it works as it should
set backspace=eol,indent,start

" allow cursor line wrapping with h and l
set whichwrap+=<,>,h,l

" searching
set magic " regex magic
set hlsearch " highlight search results
set incsearch " modern search
set smartcase " when searching be smart about cases
set ignorecase " ignore case when searching

" command line completion
set wildmenu
set wildmode=longest:full,full
set wildignore+=.*

" key remapping
let mapleader=","
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" selecta integration
function! SelectaCommand(vim_command, selecta_in, selecta_out)
  try
    let selection=system(a:selecta_in . " | selecta  | " . a:selecta_out)
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

nnoremap <leader>s :call SelectaCommand(":", "cat -n " . @%, "cut -f1")<cr>
nnoremap <leader>f :call SelectaCommand(":e", "find * -type f", "cat")<cr>

function! SelectaBuffer()
  let bufnrs=filter(range(1, bufnr("$")), 'buflisted(v:val)')
  let buffers=map(bufnrs, 'bufname(v:val)')
  call SelectaCommand(":b", 'echo "' . join(buffers, "\n") . '"', "cat")
endfunction

nnoremap <leader>b :call SelectaBuffer()<cr>

" multi function tab key
function! InsertTabWrapper()
    let col=col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" persist undo between sessions
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" persist cursor position between sessions
autocmd BufReadPost * silent! normal! g`"zv

" delete trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" performance optimizations
set lazyredraw " don't redraw while executing macros

