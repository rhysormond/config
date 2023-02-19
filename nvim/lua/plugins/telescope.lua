require 'utils'

nnoremap('[f]ind [k]eymap', '<Leader>fk', ':Telescope keymaps <CR>')
nnoremap('[f]ind lines within [a]ll files in the project', '<Leader>fa', require 'telescope.builtin'.live_grep)
nnoremap('[f]ind [l]ines in the open buffer', '<Leader>fl', require 'telescope.builtin'.current_buffer_fuzzy_find)
nnoremap('[f]ind git [f]iles in the project', '<Leader>ff', require 'telescope.builtin'.git_files)
nnoremap('[f]ind [b]uffers', '<Leader>fb', require 'telescope.builtin'.buffers)

-- use native fzf to improve performance
require 'telescope'.setup()
require 'telescope'.load_extension('fzf')
