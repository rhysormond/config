" use actual modern vim features
set nocompatible

" remove all existing autocmds
autocmd!

" leader key
let mapleader=" "

" vim plugin manager autoinstall
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'nanotech/jellybeans.vim'
call plug#end()

" enable file type detection
filetype indent plugin on

" general configuration
set hidden " hide buffers rather than abandoning them
set autoread " reload outside changes automatically
set encoding=utf8 " unicode support
set history=10000 " preserve lots of command history

" colors
syntax on
set t_Co=256
set background=dark
colorscheme jellybeans
hi Normal ctermbg=NONE
hi SpellBad ctermfg=009 cterm=bold,underline

" highlighting
set hlsearch " highlight search results
set showmatch " highlight matching braces
set cursorline " highlight current cursor line
set colorcolumn=80 " highlight the over-length column

" mode-dependent cursor style
let &t_EI = "\<Esc>[2 q" " block in normal mode
let &t_SR = "\<Esc>[4 q" " underscore in replace mode
let &t_SI = "\<Esc>[6 q" " bar in insert mode

" line wrapping
set wrap " visually wrap lines
set nolist " list disables line break
set linebreak " only wrap at specific characters

" use enter to clear search results
nnoremap <CR> :noh<CR><CR>

" use the system clipboard with leader
noremap <leader>c "*c
noremap <leader>d "*d
noremap <leader>y "*y
noremap <leader>p "*p

" open the netrw explorer
noremap <leader>e :Explore<cr>
let g:netrw_banner = 0 " don't show the netrw banner

" line numbers
set number " always show line numbers
set relativenumber " set line numbers to be relative to current row

" split window sizing
set scrolloff=5 " scroll buffer size
set winwidth=86 " focused split width (+ 1 (margin) +3 (numbers) +2 (signify))
set winheight=24 " focused split height
set winminwidth=40 " minimum split width
set winminheight=12 " minimum split height

" split window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" command line
set showcmd " always show the current command
set showmode " show the current mode if it's not normal
set cmdheight=1 " height of the command line

" status line
hi User1 ctermbg=black ctermfg=white
hi User2 ctermbg=black ctermfg=darkgrey
hi User3 ctermbg=black ctermfg=darkmagenta
hi User4 ctermbg=black ctermfg=yellow cterm=bold
hi User5 ctermbg=black ctermfg=green cterm=bold
hi User6 ctermbg=black ctermfg=red cterm=bold
set laststatus=2 " always show the status line
set statusline=%3*[%n]\ %2*%{pathshorten(expand('%:~:h'))}/%4*%t\ %5*%m\ %6*%r
set statusline+=%=%1*[%3p:%3v]

" tab behavior
set expandtab " tab inserts spaces instead of tabs
set autoindent " auto indent
set shiftwidth=4 " automatic indentation width
set softtabstop=4 " tab space equivalents
function! InsertTabWrapper() " multi function tab key
    let col=col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" searching
set magic " regex magic
set incsearch " modern search
set smartcase " when searching be smart about cases
set ignorecase " ignore case when searching
set path+=** " recursively search through directories

" command line completion
set wildmenu " menu for tab completion from the command line
set wildmode=longest:full,full " command line completion using wildmenu
set wildignore+=.* " ignore any hidden files for completion

" configure backspace so it works as expected
set backspace=eol,indent,start

" allow cursor wrapping when moving left/right
set whichwrap+=h,l

" unmap arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" persist undo between sessions
if !isdirectory("/tmp/.vim-undo")
    call mkdir("/tmp/.vim-undo", "", 0700)
endif
set undodir=/tmp/.vim-undo
set undofile

" persist cursor position between sessions
augroup PersistCursorPosition
    autocmd!
    autocmd BufReadPost * silent! normal! g`"zv
augroup END

" prevent automatic backups
set nowb
set nobackup
set noswapfile
set nowritebackup

" performance optimizations
set lazyredraw " don't redraw while executing macros
set ttimeout " enable escape code timeout
set ttimeoutlen=0 " set timeout length to 0
