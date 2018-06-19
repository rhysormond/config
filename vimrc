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
set number " show line numbers
set relativenumber " set line numbers to be relative to current row
set scrolloff=5 " 5 lines of scroll buffer

" window focus changes
augroup WINDOW
    autocmd!
    " only set relative line numbers for the current window
    autocmd WinEnter * set relativenumber
    autocmd WinLeave * set norelativenumber
augroup END

" command & status lines
set showcmd " always show the current command
set showmode " show current mode (insert, visual)
set cmdheight=1 " height of the command line
set laststatus=2 " always show the status line

" status line
set statusline=%{expand('%:~:h')}/\ ❮❮\ %f\ %y\ ❯❯\ %m
set statusline+=%=❮❮\ %03v\ ::\ %P\ ::\ %n\ ❯❯

" insert mode changes
augroup INSERT
    autocmd!
    " only set cursor column when inserting text
    autocmd InsertEnter * set cursorcolumn
    autocmd InsertLeave * set nocursorcolumn
augroup END

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
nnoremap j gj
nnoremap k gk

" fuzzy search integration
if !empty($FUZZY_SELECTOR)
    function! FuzzySelect(input)
        try
            let selection=system(a:input . " | " . $FUZZY_SELECTOR)
        catch /Vim:Interrupt/
            redraw!
        return
        endtry
        redraw!
        return selection
    endfunction

    function! SearchWithinFile()
        let line_selection = FuzzySelect("cat -n " .@%)
        let line_number = split(line_selection)[0]
        exec ": " . line_number
    endfunction

    function! SearchFilePaths()
        let path_selection = FuzzySelect("find * -type f")
        exec ":e " . path_selection
    endfunction

    function! SearchBuffers()
        let bufnrs=filter(range(1, bufnr("$")), 'buflisted(v:val)')
        let buffers=map(bufnrs, 'bufname(v:val)')
        let buffer_selection = FuzzySelect('echo "' . join(buffers, "\n") . '"')
        exec ":b " . buffer_selection
    endfunction

    nnoremap <leader>s :call SearchWithinFile()<cr>
    nnoremap <leader>f :call SearchFilePaths()<cr>
    nnoremap <leader>b :call SearchBuffers()<cr>
endif

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

