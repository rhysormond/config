" remove all existing autocmds
autocmd!

" enable plugins
execute pathogen#infect()

" save long long command history
set history=10000

" reload outside changes automatically
set autoread

" enable file type detection
filetype indent plugin on

" Unicode support
set encoding=utf8

" prevent automatic backups
set nowb
set nobackup
set noswapfile
set nowritebackup

" colors
syntax on
set t_Co=256
colorscheme gruvbox

" general configuration
set hidden " hide buffers rather than abandoning them
set spell spelllang=en_us " spell checking

" split window sizing
set winwidth=84 " focused split width
set winheight=30 " focused split height
silent! set winminwidth=84 " minimum split width
silent! set winminheight=5 " minimum split height

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

  let tmux_display = "tmux display-message -p '#{pane_title}'"
  let previous_title = substitute(system(tmux_display), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

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
augroup RelativeNumberFocus " only show relative numbers for the current split
    autocmd!
    autocmd WinEnter * set relativenumber
    autocmd WinLeave * set norelativenumber
augroup END

" line wrapping
set wrap " visually wrap lines
set nolist " list disables line break
set linebreak " only wrap at specific characters

" highlighting
set showmatch " highlight matching braces
set cursorline " highlight current cursor line
set colorcolumn=81 " highlight the over-length column
augroup InsertHighlighting " highlight column in insert mode
    autocmd!
    autocmd InsertEnter * set cursorcolumn
    autocmd InsertLeave * set nocursorcolumn
augroup END

" line numbers
set number " always show line numbers
set relativenumber " set line numbers to be relative to current row
set scrolloff=5 " 5 lines of scroll buffer

" commands
set showcmd " always show the current command
set showmode " show current mode (insert, visual)
set cmdheight=1 " height of the command line

" status line
set laststatus=2 " always show the status line
set statusline=%{pathshorten(expand('%:~:h'))}/%t\ (%{&ft})\ %m
set statusline+=%=\ col:\ %02v\ 

" tab behavior
set expandtab " tab inserts spaces instead of tabs
set autoindent " auto indent
set shiftwidth=4 " automatic indentation width
set softtabstop=4 " tab space equivalents

" searching
set magic " regex magic
set hlsearch " highlight search results
set incsearch " modern search
set smartcase " when searching be smart about cases.
set ignorecase " ignore case when searching

" command line completion
set wildmenu
set wildmode=longest:full,full
set wildignore+=.*

" key remapping
let mapleader=","

" configure backspace so it works as expected
set backspace=eol,indent,start

" allow cursor wrapping with movement keys
set whichwrap+=<,>,h,l
nnoremap j gj
nnoremap k gk

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

" performance optimizations
set lazyredraw " don't redraw while executing macros
set ttimeout " don't wait for escape codes; modern terminals are plenty fast
augroup NoInsertTimeout
    autocmd!
    autocmd InsertEnter * set ttimeoutlen=0 " no timeout
    autocmd InsertLeave * set ttimeoutlen=-1 " default value
augroup END

