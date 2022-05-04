local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- general completion settings
cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = {
    ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm { select = true },
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
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }
}

-- completion for search
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- completion for commands
cmp.setup.cmdline(':', {
  sources = cmp.config.sources {
    { name = 'cmdline' },
    { name = 'path' },
  }
})