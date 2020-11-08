" bindings for the lsp ecosystem

" use a completion menu instead of automatically completing things
set completeopt=menuone,noinsert,noselect

" use (shift) tab to select completion options
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" lsp key bindings
nnoremap gd        <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gy        <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap go        <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap gg        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap ge        <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap ga        <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>s <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap ]d        <cmd>NextDiagnostic<CR>
nnoremap [d        <cmd>PrevDiagnostic<CR>

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

