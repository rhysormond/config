" bindings for the lsp ecosystem

" use a completion menu instead of automatically completing things
set completeopt=menuone,noinsert,noselect

" (shift) tab to select completion alternatives
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" finding references forwards/backwards
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gr <cmd>lua require'telescope.builtin'.lsp_references{}<CR>

" popup hints about the highlighted token
nnoremap K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gy    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <C-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <C-s> <cmd>lua vim.lsp.buf.signature_help()<CR>

" diagnostics
nnoremap ge <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap ]e <cmd>NextDiagnostic<CR>
nnoremap [e <cmd>PrevDiagnostic<CR>

" refactoring
nnoremap ga        <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>s <cmd>lua vim.lsp.buf.formatting()<CR>

" file and project outlines
nnoremap <leader>of <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>
nnoremap <leader>oo <cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>

" adding language servers and hooks
lua <<EOF
local lsp = require("nvim_lsp")

local attach = function()
  require("completion").on_attach()
  require("diagnostic").on_attach()
end

lsp.metals.setup{ on_attach = attach }
lsp.rust_analyzer.setup{ on_attach = attach }
EOF

