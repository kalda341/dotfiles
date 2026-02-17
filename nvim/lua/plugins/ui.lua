-- UI Configuration: Theme, nvim-tree, diagnostic signs

-- Theme setup
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'original'
vim.g.gruvbox_material_better_performance = 1
vim.cmd('colorscheme gruvbox-material')

-- nvim-tree setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  update_focused_file = {
    enable = true
  }
})

-- nvim-tree keybinding
vim.keymap.set('n', '<F2>', ':NvimTreeToggle<CR>')

-- Undotree keybinding
vim.keymap.set('n', '<F3>', ':UndotreeToggle<CR>')

-- LSP Diagnostic Signs
vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "DiagnosticSignError"
})
vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
  linehl = "",
  numhl = "DiagnosticSignWarn"
})
vim.fn.sign_define("DiagnosticSignInfo", {
  text = "",
  texthl = "DiagnosticSignInfo",
  linehl = "",
  numhl = "DiagnosticSignInfo"
})
vim.fn.sign_define("DiagnosticSignHint", {
  text = "",
  texthl = "DiagnosticSignHint",
  linehl = "",
  numhl = "DiagnosticSignHint"
})
