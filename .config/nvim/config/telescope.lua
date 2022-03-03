-- [F]ind a line within [A]ll open buffers
vim.api.nvim_set_keymap('n', '<Leader>fa', ':lua require "telescope.builtin".live_grep()<CR>', {noremap = true})
-- [F]ind [L]ine in open buffer
vim.api.nvim_set_keymap('n', '<Leader>fl', ':lua require "telescope.builtin".current_buffer_fuzzy_find()<CR>', {noremap = true})
-- [F]ind [F]ile in directory
vim.api.nvim_set_keymap('n', '<Leader>ff', ':lua require "telescope.builtin".git_files()<CR>', {noremap = true})
-- [F]ind [B]uffer with name
vim.api.nvim_set_keymap('n', '<Leader>fb', ':lua require "telescope.builtin".buffers()<CR>', {noremap = true})

