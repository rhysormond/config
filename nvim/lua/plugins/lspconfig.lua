require 'utils'

-- format on save
local format_save = vim.api.nvim_create_augroup('format_on_save', { clear = true })
vim.api.nvim_create_autocmd('BufWrite', {
  group = format_save,
  pattern = '*',
  callback = function() vim.lsp.buf.format { async = true } end,
})

-- goto commands
nnoremap(
  '[g]o to [D]eclaration',
  'gD',
  vim.lsp.buf.declaration
)
nnoremap(
  '[g]o to [d]efinition',
  'gd',
  vim.lsp.buf.definition
)
nnoremap(
  '[g]o to [i]mplementation',
  'gi',
  vim.lsp.buf.implementation
)
nnoremap(
  '[g]o to [r]eference',
  'gr',
  require "telescope.builtin".lsp_references
)
nnoremap(
  '[g]o to t[y]pe definition',
  'gy',
  vim.lsp.buf.type_definition
)

-- popup hints
nnoremap(
  'hover',
  'K',
  vim.lsp.buf.hover
)

-- refactoring
nnoremap(
  '[c]ode [a]ction',
  '<leader>ca',
  vim.lsp.buf.code_action
)
nnoremap(
  '[r]e[n]ame',
  '<leader>rn',
  vim.lsp.buf.rename
)

-- file and project outlines
nnoremap(
  '[s]ymbols in [f]ile/document',
  '<leader>sf',
  require "telescope.builtin".lsp_document_symbols
)
nnoremap(
  '[s]ymbols [a]ll (all public symbols in workspace)',
  '<leader>sa',
  require "telescope.builtin".lsp_workspace_symbols
)

-- language server config
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)

-- special config for nvim lua config editing
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
        library = vim.api.nvim_get_runtime_file('', true),
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
