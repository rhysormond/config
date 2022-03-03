local map = vim.api.nvim_set_keymap

function nnoremap(keys, fn)
  map('n', keys, fn, { noremap = true, silent = true })
end
