require 'utils'

-- leader key
nnoremap('<Space>', '')
vim.g.mapleader = ' '

-- use the system clipboard with leader
nnoremap('<leader>c', '"+c')
nnoremap('<leader>d', '"+d')
nnoremap('<leader>y', '"+y')
nnoremap('<leader>p', '"+p')

-- use ctrl + hjkl for split navigation
nnoremap('<c-h>', '<c-w>h')
nnoremap('<c-j>', '<c-w>j')
nnoremap('<c-k>', '<c-w>k')
nnoremap('<c-l>', '<c-w>l')

-- unmap arrow keys
nnoremap('<Up>', '<Nop>')
nnoremap('<Down>', '<Nop>')
nnoremap('<Left>', '<Nop>')
nnoremap('<Right>', '<Nop>')

