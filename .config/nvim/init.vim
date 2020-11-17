" plugins
if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('$XDG_CONFIG_HOME/vim/plugged')

" ux improvements
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" ui improvements
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'

" language server
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

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

" colors
set termguicolors
colorscheme gruvbox
hi SpellBad ctermfg=009 cterm=bold,underline

" highlighting
set showmatch " highlight matching braces
set cursorline " highlight current cursor line
set cursorcolumn " highlight the current cursor column
set colorcolumn=80 " highlight the over-length column

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
for f in split(glob('$XDG_CONFIG_HOME/nvim/config/*.vim'), '\n')
    exe 'source' f
endfor
