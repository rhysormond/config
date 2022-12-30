function nnoremap(desc, keys, fn)
  vim.keymap.set('n', keys, fn, { silent = true, desc = desc })
end
