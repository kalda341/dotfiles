-- Plugin specifications for lazy.nvim

return {
  -- File search/browse
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<F2>', ':NvimTreeToggle<CR>', desc = 'Toggle nvim-tree' },
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require('nvim-tree').setup({
        update_focused_file = {
          enable = true
        }
      })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<cr>', desc = 'Find files' },
      { '<C-b>', '<cmd>lua require("telescope.builtin").buffers()<cr>', desc = 'Buffers' },
      { '<C-n>', '<cmd>lua require("telescope").extensions.recent_files.pick()<cr>', desc = 'Recent files' },
    },
    config = function()
      require('telescope').load_extension('recent_files')
    end,
  },
  {
    'smartpde/telescope-recent-files',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    'tpope/vim-abolish',
    cmd = { 'Abolish', 'Subvert' },
  },

  -- Git
  {
    'mattn/webapi-vim',
    lazy = true,
  },
  {
    'mattn/gist-vim',
    cmd = 'Gist',
    dependencies = { 'mattn/webapi-vim' },
  },
  {
    'mhinz/vim-signify',
    event = 'BufReadPre',
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' },
  },

  -- Theme
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = 'dark'
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd('colorscheme gruvbox-material')
    end,
  },

  -- LSP support
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'ts_ls',
          'eslint',
          'tailwindcss',
          'terraformls',
          'pyright'
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    lazy = true,
  },
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd,
        },
      })
    end,
  },
  {
    'saadparwaiz1/cmp_luasnip',
    lazy = true,
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    lazy = true,
  },

  -- Tree sitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- Actions
  {
    'scrooloose/nerdcommenter',
    keys = {
      { '<leader>c<space>', mode = { 'n', 'v' }, desc = 'Toggle comment' },
    },
    init = function()
      vim.g.NERDSpaceDelims = 1
    end,
  },
  {
    'FooSoft/vim-argwrap',
    keys = {
      { '<leader>a', ':ArgWrap<CR>', silent = true, desc = 'Toggle argument wrapping' },
    },
  },
  {
    'tpope/vim-speeddating',
    keys = {
      { '<C-a>', mode = { 'n', 'v' } },
      { '<C-x>', mode = { 'n', 'v' } },
    },
  },

  -- Motions
  {
    'tpope/vim-surround',
    keys = {
      { 'ys', mode = 'n' },
      { 'cs', mode = 'n' },
      { 'ds', mode = 'n' },
      { 'S', mode = 'v' },
    },
  },

  -- Text objects
  {
    'wellle/targets.vim',
    event = 'BufReadPost',
  },
  {
    'gorkunov/smartpairs.vim',
    event = 'BufReadPost',
  },

  -- Filetypes
  {
    'tpope/vim-sleuth',
    event = 'BufReadPre',
  },
  {
    'editorconfig/editorconfig-vim',
    event = 'BufReadPre',
  },

  -- Traverse the undo/redo tree
  {
    'mbbill/undotree',
    keys = {
      { '<F3>', ':UndotreeToggle<CR>', desc = 'Toggle undotree' },
    },
  },

  -- Copilot
  {
    'github/copilot.vim',
    event = 'InsertEnter',
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        silent = true,
        script = true,
        replace_keycodes = false
      })
    end,
  },
}
