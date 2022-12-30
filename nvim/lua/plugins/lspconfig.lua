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
  ':lua vim.lsp.buf.declaration()<CR>'
)
nnoremap(
  '[g]o to [d]efinition',
  'gd',
  ':lua vim.lsp.buf.definition()<CR>'
)
nnoremap(
  '[g]o to [i]mplementation',
  'gi',
  ':lua vim.lsp.buf.implementation()<CR>'
)
nnoremap(
  '[g]o to [r]eference',
  'gr',
  ':lua require "telescope.builtin".lsp_references()<CR>'
)
nnoremap(
  '[g]o to t[y]pe definition',
  'gy',
  ':lua vim.lsp.buf.type_definition()<CR>'
)

-- popup hints
nnoremap(
  'hover',
  'K',
  ':lua vim.lsp.buf.hover()<CR>'
)

-- refactoring
nnoremap(
  '[c]ode [a]ction',
  '<leader>ca',
  ':lua vim.lsp.buf.code_action()<CR>'
)
nnoremap(
  '[r]e[n]ame',
  '<leader>rn',
  ':lua vim.lsp.buf.rename()<CR>'
)

-- file and project outlines
nnoremap(
  '[s]ymbols in [f]ile/document',
  '<leader>sf',
  ':lua require "telescope.builtin".lsp_document_symbols()<CR>'
)
nnoremap(
  '[s]ymbols [a]ll (all public symbols in workspace)',
  '<leader>sa',
  ':lua require "telescope.builtin".lsp_workspace_symbols()<CR>'
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
