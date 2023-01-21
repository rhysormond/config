require 'utils'

local mason_lspconfig = require 'mason-lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)

local servers = {
  rust_analyzer = {},
  marksman = {},
  sumneko_lua = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false
      },
      telemetry = {
        enable = false
      },
    },
  },
}

local on_attach = function()
  -- goto commands
  nnoremap('[g]o to [D]eclaration', 'gD', vim.lsp.buf.declaration)
  nnoremap('[g]o to [d]efinition', 'gd', vim.lsp.buf.definition)
  nnoremap('[g]o to [i]mplementation', 'gi', vim.lsp.buf.implementation)
  nnoremap('[g]o to [r]eference', 'gr', require "telescope.builtin".lsp_references)
  nnoremap('[g]o to t[y]pe definition', 'gy', vim.lsp.buf.type_definition)

  -- popup hints
  nnoremap('hover documentation', 'K', vim.lsp.buf.hover)
  -- nnoremap('signature documentation', '<C-K>', vim.lsp.buf.signature_help)

  -- refactoring
  nnoremap('[c]ode [a]ction', '<leader>ca', vim.lsp.buf.code_action)
  nnoremap('[r]e[n]ame', '<leader>rn', vim.lsp.buf.rename)

  -- file and project outlines
  nnoremap('[s]ymbols in [f]ile/document', '<leader>sf', require "telescope.builtin".lsp_document_symbols)
  nnoremap('[s]ymbols [a]ll in workspace', '<leader>sa', require "telescope.builtin".lsp_workspace_symbols)

  -- format on save
  local format_save = vim.api.nvim_create_augroup('format_on_save', { clear = true })
  vim.api.nvim_create_autocmd('BufWrite', {
    group = format_save,
    pattern = '*',
    callback = function() vim.lsp.buf.format { async = true } end,
  })
end

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
