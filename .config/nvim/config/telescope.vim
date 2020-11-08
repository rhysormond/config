" bindings for the fzf plugin

" [F]ind a line within [A]ll open buffers
nnoremap <Leader>fa <cmd>lua require'telescope.builtin'.live_grep{}<CR>
" [F]ind [L]ine in open buffer
nnoremap <Leader>fl <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>
" [F]ind [F]ile in directory
nnoremap <Leader>ff <cmd>lua require'telescope.builtin'.git_files{}<CR>
" [F]ind [B]uffer with name
nnoremap <Leader>fb <cmd>lua require'telescope.builtin'.buffers{}<CR>

