require 'utils'

-- format on save
vim.cmd([[autocmd BufWrite * silent! lua vim.lsp.buf.formatting()]])

-- goto commands
nnoremap('gD', ':lua  vim.lsp.buf.declaration()<CR>')
nnoremap('gd', ':lua  vim.lsp.buf.definition()<CR>')
nnoremap('gi', ':lua  vim.lsp.buf.implementation()<CR>')
nnoremap('gr', ':lua  require "telescope.builtin".lsp_references()<CR>')
nnoremap('gy', ':lua  vim.lsp.buf.type_definition()<CR>')

-- popup hints
nnoremap('K', ':lua  vim.lsp.buf.hover()<CR>')

-- refactoring
nnoremap('<leader>ca', ':lua  vim.lsp.buf.code_action()<CR>')
nnoremap('<leader>rn', ':lua  vim.lsp.buf.rename()<CR>')

-- file and project outlines
nnoremap('<leader>sf', ':lua  require "telescope.builtin".lsp_document_symbols()<CR>')
nnoremap('<leader>sa', ':lua  require "telescope.builtin".lsp_workspace_symbols()<CR>')

-- language server config
local servers = { 'rust_analyzer', 'metals' }
for _, server in ipairs(servers) do
  require('lspconfig')[server].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }
end

