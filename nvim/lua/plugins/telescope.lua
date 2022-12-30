require 'utils'

nnoremap(
  '[f]ind [k]eymap',
  '<Leader>fk',
  ':Telescope keymaps <CR>'
)
nnoremap(
  '[f]ind a line within [a]ll open buffers',
  '<Leader>fa',
  ':lua require "telescope.builtin".live_grep()<CR>'
)
nnoremap(
  '[f]ind [l]ine in open buffer',
  '<Leader>fl',
  ':lua require "telescope.builtin".current_buffer_fuzzy_find()<CR>'
)
nnoremap(
  '[f]ind [f]ile in directory',
  '<Leader>ff',
  ':lua require "telescope.builtin".git_files()<CR>'
)
nnoremap(
  '[f]ind [b]uffer with name',
  '<Leader>fb',
  ':lua require "telescope.builtin".buffers()<CR>'
)

-- use native fzf to improve performance
require 'telescope'.setup()
require 'telescope'.load_extension('fzf')
