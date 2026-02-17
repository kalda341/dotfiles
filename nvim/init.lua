-- ~/.config/nvim/init.lua
-- Author: Max Lay

-- Load configuration modules
require('config.options')
require('config.keymaps')

-- Load plugins and plugin configurations
require('plugins')
require('plugins.ui')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.completion')
require('plugins.lsp')
