" source lua config
exe 'luafile' '~/.config/nvim/lua/plugins.lua'
exe 'luafile' '~/.config/nvim/lua/settings.lua'
exe 'luafile' '~/.config/nvim/lua/keybinds.lua'

" colors
set termguicolors
colorscheme melange

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

