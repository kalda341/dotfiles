-- LSP Configuration: Mason + nvim-lspconfig + none-ls

-- LSP Diagnostic Signs
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "DiagnosticSignHint" })

-- LSP Keymaps
local bufopts = { noremap = true, silent = true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', bufopts, { desc = 'Go to declaration' }))
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', bufopts, { desc = 'Go to definition' }))
vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', bufopts, { desc = 'Hover documentation' }))
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', bufopts, { desc = 'Go to implementation' }))
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', bufopts, { desc = 'Signature help' }))
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, vim.tbl_extend('force', bufopts, { desc = 'Add workspace folder' }))
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, vim.tbl_extend('force', bufopts, { desc = 'Remove workspace folder' }))
vim.keymap.set('n', '<space>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, vim.tbl_extend('force', bufopts, { desc = 'List workspace folders' }))
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, vim.tbl_extend('force', bufopts, { desc = 'Type definition' }))
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, vim.tbl_extend('force', bufopts, { desc = 'Rename symbol' }))
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', bufopts, { desc = 'Code action' }))
vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', bufopts, { desc = 'Go to references' }))
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, vim.tbl_extend('force', bufopts, { desc = 'Format buffer' }))
vim.keymap.set('n', '<space>do', vim.diagnostic.open_float, vim.tbl_extend('force', bufopts, { desc = 'Open diagnostic float' }))
vim.keymap.set('n', '<space>dp', function() vim.diagnostic.jump({ count = -1, float = true }) end, vim.tbl_extend('force', bufopts, { desc = 'Previous diagnostic' }))
vim.keymap.set('n', '<space>dn', function() vim.diagnostic.jump({ count = 1, float = true }) end, vim.tbl_extend('force', bufopts, { desc = 'Next diagnostic' }))

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    'ts_ls',
    'eslint',
    'tailwindcss',
    'terraformls',
    'pyright'
  },
}

-- none-ls (null-ls replacement) setup
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
  },
})
