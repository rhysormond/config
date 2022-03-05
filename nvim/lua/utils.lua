function nnoremap(keys, fn)
  vim.api.nvim_set_keymap('n', keys, fn, { noremap = true, silent = true })
end
