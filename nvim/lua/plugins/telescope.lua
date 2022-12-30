require 'utils'

nnoremap(
  '[f]ind [k]eymap',
  '<Leader>fk',
  ':Telescope keymaps <CR>'
)
nnoremap(
  '[f]ind a line within [a]ll open buffers',
  '<Leader>fa',
  require 'telescope.builtin'.live_grep
)
nnoremap(
  '[f]ind [l]ine in open buffer',
  '<Leader>fl',
  require 'telescope.builtin'.current_buffer_fuzzy_find
)
nnoremap(
  '[f]ind [f]ile in directory',
  '<Leader>ff',
  require 'telescope.builtin'.find_files
)
nnoremap(
  '[f]ind [b]uffer with name',
  '<Leader>fb',
  require 'telescope.builtin'.buffers
)

-- use native fzf to improve performance
require 'telescope'.setup()
require 'telescope'.load_extension('fzf')
