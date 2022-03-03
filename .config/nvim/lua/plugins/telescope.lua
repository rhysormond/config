require 'utils'

-- [F]ind a line within [A]ll open buffers
nnoremap('<Leader>fa', ':lua require "telescope.builtin".live_grep()<CR>')
-- [F]ind [L]ine in open buffer
nnoremap('<Leader>fl', ':lua require "telescope.builtin".current_buffer_fuzzy_find()<CR>')
-- [F]ind [F]ile in directory
nnoremap('<Leader>ff', ':lua require "telescope.builtin".git_files()<CR>')
-- [F]ind [B]uffer with name
nnoremap('<Leader>fb', ':lua require "telescope.builtin".buffers()<CR>')
