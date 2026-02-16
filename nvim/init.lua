-- ~/.config/nvim/init.lua
-- Author: Max Lay

-- Leader key
vim.g.mapleader = " "

-- Auto-install vim-plug
local plug_install_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_install_path)) > 0 then
  vim.fn.system({
    'curl', '-fLo', plug_install_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')

  -- File search/browse
  Plug('nvim-tree/nvim-web-devicons')
  Plug('nvim-tree/nvim-tree.lua')
  Plug('nvim-telescope/telescope.nvim')
  Plug('smartpde/telescope-recent-files')
  Plug('tpope/vim-abolish', {on = {'Abolish', 'Subvert'}})

  -- Git
  Plug('mattn/webapi-vim')
  Plug('mattn/gist-vim', {on = 'Gist'})
  Plug('mhinz/vim-signify')
  Plug('tpope/vim-fugitive')

  -- Theme
  Plug('sainnhe/gruvbox-material')

  -- LSP support
  Plug('nvim-lua/plenary.nvim')
  Plug('mason-org/mason.nvim')
  Plug('mason-org/mason-lspconfig.nvim')
  Plug('neovim/nvim-lspconfig')
  Plug('hrsh7th/nvim-cmp')
  Plug('hrsh7th/cmp-nvim-lsp')
  Plug('nvimtools/none-ls.nvim')
  Plug('saadparwaiz1/cmp_luasnip')
  Plug('L3MON4D3/LuaSnip', {tag = 'v<CurrentMajor>.*', ['do'] = 'make install_jsregexp'})

  -- Tree sitter
  Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

  -- Actions
  Plug('scrooloose/nerdcommenter')
  Plug('FooSoft/vim-argwrap')
  Plug('tpope/vim-speeddating')

  -- Motions
  Plug('tpope/vim-surround')

  -- Text objects
  Plug('wellle/targets.vim')
  Plug('gorkunov/smartpairs.vim')

  -- Filetypes
  Plug('tpope/vim-sleuth')
  Plug('editorconfig/editorconfig-vim')

  -- Traverse the undo/redo tree
  Plug('mbbill/undotree')

  -- Copilot
  Plug('github/copilot.vim')

vim.call('plug#end')

-- Plugin-specific settings
vim.g.NERDSpaceDelims = 1

-- Theme setup
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'original'
vim.g.gruvbox_material_better_performance = 1
vim.cmd('colorscheme gruvbox-material')

-- Diffs should be vertically split
vim.opt.diffopt:append('vertical')

-- ============================================================================
-- LSP and Completion Configuration
-- ============================================================================

-- LSP Keymaps
local bufopts = { noremap = true, silent = true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
vim.keymap.set('n', '<space>do', vim.diagnostic.open_float, bufopts)
vim.keymap.set('n', '<space>dp', function() vim.diagnostic.jump({ count = -1, float = true }) end, bufopts)
vim.keymap.set('n', '<space>dn', function() vim.diagnostic.jump({ count = 1, float = true }) end, bufopts)

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

-- LuaSnip setup
local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- none-ls (null-ls replacement) setup
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
  },
})

-- Telescope setup
require("telescope").load_extension("recent_files")

-- Treesitter setup
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- nvim-tree setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  update_focused_file = {
    enable = true
  }
})

-- ============================================================================
-- LSP Diagnostic Signs
-- ============================================================================
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "DiagnosticSignHint" })

-- ============================================================================
-- Copilot
-- ============================================================================
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true, script = true, replace_keycodes = false })

-- ============================================================================
-- General Settings
-- ============================================================================

-- Backup settings
vim.opt.backupcopy = 'yes'

-- Command history
vim.opt.history = 200

-- Update time and completion settings
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'

-- Buffer management
vim.opt.hidden = true

-- File reload
vim.opt.autoread = true

-- Terminal setup
vim.opt.errorbells = false
vim.opt.visualbell = true

-- Auto resize panes on terminal resize
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd ='
})

-- Indentation
vim.opt.shiftround = true

-- Statusline
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.showcmd = true

-- Wildmenu settings
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildignore:append({'.hg', '.git', '.svn', '*.pyc', 'venv', '*.beam', '*.jpg', '*.bmp', '*.gif', '*.png', '*.jpeg', '*.class', '*.o'})

-- Display whitespace
vim.opt.listchars = { tab = '>.', trail = '.' }
vim.opt.list = true

-- Line numbers and limits
vim.opt.number = true
vim.opt.colorcolumn = '120'
vim.opt.cursorline = true

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Undo settings
vim.opt.undofile = true
local undodir = vim.fn.stdpath('data') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
vim.opt.undodir = undodir

-- Disable swap and backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Scrolling
vim.opt.scrolloff = 8

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = 'en_nz'

-- Grep settings
vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.opt.grepformat:append('%f:%l:%c:%m')

-- ============================================================================
-- Keymaps
-- ============================================================================

-- Use ; as :
vim.keymap.set('n', ';', ':')

-- Disable ex mode
vim.keymap.set('n', 'q:', '<Nop>')
vim.keymap.set('n', 'Q', '<Nop>')

-- Saving
vim.keymap.set('n', '<Leader>w', ':w!<CR>')

-- Sudo write
vim.keymap.set('c', 'w!!', 'w !sudo tee % >/dev/null')

-- Clear search highlighting
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>')

-- Scroll wrapped lines normally
vim.keymap.set('n', 'k', 'gk', { silent = true })
vim.keymap.set('n', 'j', 'gj', { silent = true })

-- End/Start of line in insert mode
vim.keymap.set('i', '<C-e>', '<C-o>$')
vim.keymap.set('i', '<C-a>', '<C-o>^')

-- Easy ways of getting into normal mode
vim.keymap.set('i', 'kk', '<ESC>')
vim.keymap.set('i', 'jj', '<ESC>')

-- Navigate windows
vim.keymap.set('', '<C-h>', '<C-w>h')
vim.keymap.set('', '<C-j>', '<C-w>j')
vim.keymap.set('', '<C-k>', '<C-w>k')
vim.keymap.set('', '<C-l>', '<C-w>l')

-- Window rotation (i3/sway-like)
vim.keymap.set('', '<Leader><C-h>', '<C-w>R')
vim.keymap.set('', '<Leader><C-j>', '<C-w>R')
vim.keymap.set('', '<Leader><C-k>', '<C-w>r')
vim.keymap.set('', '<Leader><C-l>', '<C-w>r')

-- Vimrc shortcuts
vim.keymap.set('n', '<Leader>ev', ':ed $MYVIMRC<CR>', { silent = true })

-- Newline without entering insert mode
vim.keymap.set('', '<Leader>o', 'o<Esc>')
vim.keymap.set('', '<Leader>O', 'O<Esc>')

-- System clipboard operations
vim.keymap.set('', '<Leader>y', '"+y')
vim.keymap.set('', '<Leader>d', '"+d')
vim.keymap.set('', '<Leader>p', ':set paste<CR>"+p:set nopaste<CR>')
vim.keymap.set('', '<Leader>P', ':set paste<CR>"+P:set nopaste<CR>')

-- Plugin-specific keymaps
vim.keymap.set('n', '<F2>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<F3>', ':UndotreeToggle<CR>')
vim.keymap.set('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<cr>')
vim.keymap.set('n', '<C-b>', '<cmd>lua require("telescope.builtin").buffers()<cr>')
vim.keymap.set('n', '<C-n>', '<cmd>lua require("telescope").extensions.recent_files.pick()<cr>')
vim.keymap.set('', '<silent>', ':ArgWrap<CR>', { silent = true })
vim.keymap.set('', '<leader>a', ':ArgWrap<CR>', { silent = true })

-- QuickFix toggle function
local function toggle_quickfix()
  local quickfix_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      quickfix_open = true
      break
    end
  end
  if quickfix_open then
    vim.cmd('cclose')
  else
    vim.cmd('copen')
  end
end

vim.keymap.set('', '<Leader>q', toggle_quickfix)

-- %% expands to directory of current file
vim.cmd([[cnoreabbrev <expr> %% expand('%:p:h')]])
