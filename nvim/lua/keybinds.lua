require 'utils'

-- leader key
nnoremap(
  'unmap space in normal mode',
  '<Space>',
  ''
)
vim.g.mapleader = ' '

-- use enter to clear search results
nnoremap(
  'use enter to clear search results',
  '<CR>',
  ':noh<CR><CR>'
)

-- use the system clipboard with leader
nnoremap(
  'use system clipboard to copy',
  '<leader>c',
  '"+c'
)
nnoremap(
  'use system clipboard to delete',
  '<leader>d',
  '"+d'
)
nnoremap(
  'use system clipboard to yank',
  '<leader>y',
  '"+y'
)
nnoremap(
  'use system clipboard to paste',
  '<leader>p',
  '"+p'
)

-- use ctrl + hjkl for split navigation
nnoremap(
  'navigate one split left',
  '<c-h>',
  '<c-w>h'
)
nnoremap(
  'navigate one split down',
  '<c-j>',
  '<c-w>j'
)
nnoremap(
  'navigate one split up',
  '<c-k>',
  '<c-w>k'
)
nnoremap(
  'navigate one split right',
  '<c-l>',
  '<c-w>l'
)

-- unmap arrow keys
nnoremap(
  'unmap the up arrow',
  '<Up>',
  '<Nop>'
)
nnoremap(
  'unmap the down arrow',
  '<Down>',
  '<Nop>'
)
nnoremap(
  'unmap the left arrow',
  '<Left>',
  '<Nop>'
)
nnoremap(
  'unmap the right arrow',
  '<Right>',
  '<Nop>'
)
