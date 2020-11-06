" bindings for the coc plugin

" install coc extensions
let g:coc_global_extensions = [
	\ 'coc-rls',
	\ 'coc-metals'
  \ ]

" use tab for trigger completion with characters ahead and navigate
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" make <CR> auto-select the first completion and format
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gr <Plug>(coc-references)

" show documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" use <TAB> for selections ranges
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" search document outline
nnoremap <silent> <leader>o :<C-u>CocList outline<cr>

" search all symbols in scope
nnoremap <silent> <leader>s :<C-u>CocList -I symbols<cr>

" implement methods for trait
nnoremap <silent> <leader>i
  \ :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" show available actions
nnoremap <silent> <leader>a :CocAction<cr>

" function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" class text object
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" `:Fmt` to format current buffer
command! -nargs=0 Fmt :call CocAction('format')

" `:Org` for organize import of current buffer
command! -nargs=0 Org
  \ :call CocAction('runCommand', 'editor.action.organizeImport')

