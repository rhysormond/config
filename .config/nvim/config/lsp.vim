" use a completion menu instead of automatically completing things
set completeopt=menuone,noinsert,noselect

" format on save
autocmd BufWrite * silent! lua vim.lsp.buf.formatting()

" inlay hints
autocmd BufRead,BufWrite * silent! lua require'lsp_extensions'.inlay_hints{ aligned = true }

" (shift) tab to select completion alternatives
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" goto commands
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gr <cmd>lua require'telescope.builtin'.lsp_references()<CR>
nnoremap gy <cmd>lua vim.lsp.buf.type_definition()<CR>

" popup hints about the highlighted token
nnoremap K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>k <cmd>lua vim.lsp.buf.signature_help()<CR>

" diagnostics
nnoremap [g        <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]g        <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>

" refactoring
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<CR>

" file and project outlines
nnoremap <leader>of <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>
nnoremap <leader>oo <cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>

" adding language servers and hooks
lua <<EOF
local lsp = require("lspconfig")

local attach = function()
  require("completion").on_attach()
end

lsp.metals.setup{ on_attach = attach }
lsp.rust_analyzer.setup{ on_attach = attach }
EOF

