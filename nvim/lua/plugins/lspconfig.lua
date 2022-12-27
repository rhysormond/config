require 'utils'

-- format on save
local format_save = vim.api.nvim_create_augroup('format_on_save', { clear = true })
vim.api.nvim_create_autocmd('BufWrite', {
  group = format_save,
  pattern = '*',
  callback = function() vim.lsp.buf.formatting() end,
})

-- goto commands
nnoremap('gD', ':lua vim.lsp.buf.declaration()<CR>')
nnoremap('gd', ':lua vim.lsp.buf.definition()<CR>')
nnoremap('gi', ':lua vim.lsp.buf.implementation()<CR>')
nnoremap('gr', ':lua require "telescope.builtin".lsp_references()<CR>')
nnoremap('gy', ':lua vim.lsp.buf.type_definition()<CR>')

-- popup hints
nnoremap('K', ':lua vim.lsp.buf.hover()<CR>')

-- refactoring
nnoremap('<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
nnoremap('<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

-- file and project outlines
nnoremap('<leader>sf', ':lua require "telescope.builtin".lsp_document_symbols()<CR>')
nnoremap('<leader>sa', ':lua require "telescope.builtin".lsp_workspace_symbols()<CR>')

-- language server config
local capabilities = require 'cmp_nvim_lsp'.default_capabilities(),

require 'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}

local servers = { 'rust_analyzer', 'metals' }
for _, server in ipairs(servers) do
  require 'lspconfig'[server].setup {
    capabilities = capabilities,
  }
end
