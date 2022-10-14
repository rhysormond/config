require 'utils'

-- leader key
nnoremap('<Space>', '')
vim.g.mapleader = ' '

-- use enter to clear search results
nnoremap('<CR>', ':noh<CR><CR>')

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
