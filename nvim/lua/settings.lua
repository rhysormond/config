-- buffers
vim.o.hidden = true -- hide buffers rather than abandoning them

-- spellcheck
vim.o.spell = true -- enable spellchecking
vim.o.spelllang = 'en_us' -- set spellcheck language

-- whitespace
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.shiftwidth = 2 -- indents are 2 spaces

-- status line
vim.o.showmode = false -- don't show the current mode

-- line wrapping
vim.o.linebreak = true -- only wrap at specific characters

-- netrw
vim.g.netrw_banner = 0 -- don't show the netrw banner
vim.g.netrw_dirhistmax = 0 -- don't save any netrw history

-- line numbers
vim.o.number = true -- show the current line number
vim.o.relativenumber = true -- show other line numbers relative to the current one
vim.o.signcolumn = 'yes' -- always show the gutter

-- split window sizing
vim.o.scrolloff = 10 -- scroll buffer size

-- searching
vim.o.smartcase = true
vim.o.ignorecase = true -- only search by case when uppercase letters are used

-- completion
vim.o.wildmode = 'longest:full,full' -- command line completion using wildmenu
vim.o.shortmess = vim.o.shortmess .. 'c' -- don't pass messages to ins-completion-menu
vim.o.completeopt = 'menuone,noinsert,noselect' -- use a completion menu instead of automatically completing things

-- allow cursor wrapping when moving left/right
vim.o.whichwrap = 'h,l'

-- persist undo between sessions
vim.o.undofile = true

-- prevent automatic backups
vim.o.wb = false
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false

-- performance optimizations
vim.o.lazyredraw = true -- don't redraw while executing macros
vim.o.ttimeout = true -- enable escape code timeout
vim.o.ttimeoutlen = 0 -- set timeout length to 0
vim.o.updatetime = 300 -- faster updates

-- persist cursor position between sessions
local persist_cursor = vim.api.nvim_create_augroup('persist_cursor_position', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
  group = persist_cursor,
  pattern = '*',
  command = 'silent! normal! g`"zv'
})

-- highlight the current line for the active window
vim.o.cursorline = true
local highlight_active = vim.api.nvim_create_augroup('highlight_active_window', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = highlight_active,
  pattern = '*',
  callback = function() vim.o.cursorline = true end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = highlight_active,
  pattern = '*',
  callback = function() vim.o.cursorline = false end,
})
