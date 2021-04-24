" plugins
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/vim/plugged')

" ux improvements
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" colorscheme
Plug 'jacoborus/tender.vim'

" ui improvements
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'

" language server
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

" fuzzy finding
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

call plug#end()

" enable file type detection
filetype indent plugin on

" leader key
let mapleader=" "

" general configuration
set hidden " hide buffers rather than abandoning them
set spell spelllang=en_us " spell checking language

" whitespace
set expandtab " use spaces instead of tabs
set shiftwidth=2 " indents are 4 spaces

" colors
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme tender

" status line
set noshowmode " don't show the current mode
let g:lightline = {}
let g:lightline.colorscheme = 'tender'
let g:lightline.mode_map = {
  \ 'n':      'Nrm',
  \ 'i':      'Ins',
  \ 'R':      'Rep',
  \ 'v':      'Vis',
  \ 'V':      'VLn',
  \ "\<C-v>": 'VBk',
  \ 'c':      'Cmd',
  \ 's':      'Sel',
  \ 'S':      'SLn',
  \ "\<C-s>": 'SBk',
  \ 't':      'Trm',
\ }

" highlighting
set hlsearch " highlight search results
set showmatch " highlight matching braces
set cursorline " highlight current cursor line

" line wrapping
set linebreak " only wrap at specific characters

" use the system clipboard with leader
noremap <leader>c "+c
noremap <leader>d "+d
noremap <leader>y "+y
noremap <leader>p "+p

" netrw file browser
let g:netrw_banner = 0 " don't show the netrw banner
noremap <leader>e :Explore<cr>

" line numbers
set number " show the current line number
set relativenumber " show other line numbers relative to the current one
set signcolumn=yes " always show the gutter

" split window sizing
set scrolloff=10 " scroll buffer size
set winwidth=84 " focused split width (+ 1 (margin) +3 (line numbers + gutter))
set winminwidth=42 " minimum split width

" focused window highlighting
augroup FocusHighlight
  autocmd!
  autocmd WinEnter * set cursorline
  autocmd WinLeave * set nocursorline
augroup END

" split window navigation
if exists('$TMUX')
  " override split navigation if in a tmux session
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  nnoremap <c-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <c-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <c-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <c-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  nnoremap <c-h> <c-w>h
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-l> <c-w>l
endif

" searching
set smartcase ignorecase " only search by case when uppercase letters are used
set path+=** " recursively search through directories

" completion
set wildmode=longest:full,full " command line completion using wildmenu
set wildignore+=.* " ignore any hidden files for completion
set shortmess+=c " don't pass messages to ins-completion-menu

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
set updatetime=300 " faster updates

" source plugin-specific config
for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
  exe 'source' f
endfor
