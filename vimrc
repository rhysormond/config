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

" spell checking
set spell spelllang=en_us

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
set wildignore=*/.git/*

" key remapping
let mapleader = ","
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" selecta integration
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

function! SelectaBuffer()
  let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
  let buffers = map(bufnrs, 'bufname(v:val)')
  call SelectaCommand('echo "' . join(buffers, "\n") . '"', "", ":b")
endfunction

nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>
nnoremap <leader>b :call SelectaBuffer()<cr>

" multi function tab key
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" delete trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" silence error sounds
set noerrorbells visualbell t_vb=

" performance optimizations
set lazyredraw " don't redraw while executing macros

