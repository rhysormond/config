require 'utils'

-- use a completion menu instead of automatically completing things
vim.o.completeopt=menuone,noinsert,noselect

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
nnoremap('ca', ':lua  vim.lsp.buf.code_action()<CR>')
nnoremap('rn', ':lua  vim.lsp.buf.rename()<CR>')

-- file and project outlines
nnoremap('sf', ':lua  require "telescope.builtin".lsp_document_symbols()<CR>')
nnoremap('sa', ':lua  require "telescope.builtin".lsp_workspace_symbols()<CR>')

-- completion config
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- language server config
local servers = { 'rust_analyzer', 'metals' }
for _, server in ipairs(servers) do
  require('lspconfig')[server].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }
end

