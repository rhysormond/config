-- use a completion menu instead of automatically completing things
vim.o.completeopt=menuone,noinsert,noselect

-- format on save
vim.cmd([[autocmd BufWrite * silent! lua vim.lsp.buf.formatting()]])

-- goto commands
vim.api.nvim_set_keymap('n', 'gD', ':lua  vim.lsp.buf.declaration()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gd', ':lua  vim.lsp.buf.definition()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gi', ':lua  vim.lsp.buf.implementation()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gr', ':lua  require "telescope.builtin".lsp_references()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gy', ':lua  vim.lsp.buf.type_definition()<CR>', {noremap = true})

-- popup hints
vim.api.nvim_set_keymap('n', 'K', ':lua  vim.lsp.buf.hover()<CR>', {noremap = true})

-- refactoring
vim.api.nvim_set_keymap('n', 'ca', ':lua  vim.lsp.buf.code_action()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'rn', ':lua  vim.lsp.buf.rename()<CR>', {noremap = true})

-- file and project outlines
vim.api.nvim_set_keymap('n', 'sf', ':lua  require "telescope.builtin".lsp_document_symbols()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'sa', ':lua  require "telescope.builtin".lsp_workspace_symbols()<CR>', {noremap = true})

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

