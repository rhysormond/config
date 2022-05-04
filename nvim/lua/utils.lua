function nnoremap(keys, fn)
  vim.keymap.set('n', keys, fn, { silent = true })
end
