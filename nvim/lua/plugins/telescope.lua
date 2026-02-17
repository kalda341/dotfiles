-- Telescope Configuration

require("telescope").load_extension("recent_files")

-- Telescope keybindings
vim.keymap.set('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<cr>')
vim.keymap.set('n', '<C-b>', '<cmd>lua require("telescope.builtin").buffers()<cr>')
vim.keymap.set('n', '<C-n>', '<cmd>lua require("telescope").extensions.recent_files.pick()<cr>')
