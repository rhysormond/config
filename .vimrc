" remove all existing autocmds
autocmd!

" enable file type detection
filetype indent plugin on

" leader key
let mapleader=","

" general configuration
set hidden " hide buffers rather than abandoning them
set autoread " reload outside changes automatically
set encoding=utf8 " unicode support
set history=10000 " preserve lots of command history
set spell spelllang=en_us " spell checking language

" colors
syntax on
set t_Co=256
set background=dark
colorscheme gruvbox
hi Normal ctermbg=NONE

" highlighting
set hlsearch " highlight search results
set showmatch " highlight matching braces
set cursorline " highlight current cursor line
set colorcolumn=80 " highlight the over-length column

" mode-depenent cursor style
let &t_EI = "\<Esc>[2 q" " block in normal mode
let &t_SR = "\<Esc>[4 q" " underscore in replace mode
let &t_SI = "\<Esc>[6 q" " bar in insert mode

" line wrapping
set wrap " visually wrap lines
set nolist " list disables line break
set linebreak " only wrap at specific characters

" folding
set foldenable " enable folding
set foldnestmax=10 " 10 nested fold max
set foldlevelstart=10 " open most folds by default
set foldmethod=indent " fold based on indent level
noremap <leader><tab> za

" use the system clipboard
noremap <Leader><leader> "+

" open the netrw explorer
noremap <leader>e :Explore<cr>
let g:netrw_banner = 0 " don't show the netrw banner

" line numbers
set number " always show line numbers
set relativenumber " set line numbers to be relative to current row
augroup RelativeNumberFocus " only use relativenumber for the active window
    autocmd!
    autocmd WinEnter * set relativenumber
    autocmd WinLeave * set norelativenumber
augroup END

" split window sizing
set scrolloff=5 " scroll buffer size
set winwidth=80 " focused split width
set winheight=24 " focused split height
set winminwidth=40 " minimum split width
set winminheight=12 " minimum split height

" split window navigation
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        silent! execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
            call system("tmux select-pane -" . a:tmuxdir)
            redraw!
        endif
    endfunction

    nnoremap <silent> <c-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    nnoremap <silent> <c-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    nnoremap <silent> <c-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    nnoremap <silent> <c-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
    nnoremap <c-h> <c-w>h
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-l> <c-w>l
endif

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
set statusline+=%=%1*[%P\ -\ c%02v]

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
noremap! <Up> <Nop>
noremap! <Down> <Nop>
noremap! <Left> <Nop>
noremap! <Right> <Nop>

" fuzzy finding integration
let fuzzy_finder='fzy'
if executable(fuzzy_finder)
    function! FuzzyFind(input_command, vim_command)
        try
            let selection=system(a:input_command . " | " . g:fuzzy_finder)
        catch /Vim:Interrupt/
        endtry
        redraw!
        if v:shell_error == 0 && !empty(selection)
            " slice the first field from the selection
            let selected_field=split(selection)[0]
            exec a:vim_command . ' ' . selected_field
        endif
    endfunction

    " [F]ind [L]ine in file
    nnoremap <leader>fl :call FuzzyFind("cat -n " . @%, 0, ":")<cr>

    " find that ignores certain directories
    let find_cmd="find -type f ! -ipath '*/.git/*' ! -ipath '*/target/*'"

    " [F]ind [F]ile in directory
    nnoremap <leader>ff :call FuzzyFind(find_cmd, ":e")<cr>
    " [F]ind file in directory and open in [V]ertical split
    nnoremap <leader>fv :call FuzzyFind(find_cmd, ":vs")<cr>
    " [F]ind file in directory and open in horizontal [S]plit
    nnoremap <leader>fs :call FuzzyFind(find_cmd, ":sp")<cr>

    function! Buffers()
        let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
        let buffers = map(bufnrs, 'bufname(v:val)')
        return join(buffers, "\n")
    endfunction

    " [F]ind [B]uffer
    nnoremap <leader>fb :call FuzzyFind('echo "' . Buffers() . '"', ":b")<cr>
endif

" persist undo between sessions
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
endif

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
