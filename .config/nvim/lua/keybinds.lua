require 'utils'

-- leader key
nnoremap('n', '<Space>', '', {})
vim.g.mapleader = ' '

-- use the system clipboard with leader
nnoremap('<leader>c', '"+c')
nnoremap('<leader>d', '"+d')
nnoremap('<leader>y', '"+y')
nnoremap('<leader>p', '"+p')

-- unmap arrow keys
nnoremap('<Up>', '<Nop>')
nnoremap('<Down>', '<Nop>')
nnoremap('<Left>', '<Nop>')
nnoremap('<Right>', '<Nop>')

