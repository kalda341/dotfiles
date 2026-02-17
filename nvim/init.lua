-- ~/.config/nvim/init.lua
-- Author: Max Lay
--
-- Modern modular Neovim configuration

-- Load options first (includes leader key)
require('config.options')

-- Bootstrap lazy.nvim
require('config.lazy')

-- Setup plugins with lazy.nvim (only load specs from plugins/init.lua)
require('lazy').setup(require('plugins.init'))

-- Load remaining configuration
require('config.keymaps')

-- Load plugin configs (protected in case plugins aren't installed yet)
pcall(require, 'plugins.treesitter')
pcall(require, 'plugins.completion')
pcall(require, 'plugins.lsp')
