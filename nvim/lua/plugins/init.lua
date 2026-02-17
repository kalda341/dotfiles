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
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = 'Next hunk'})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = 'Previous hunk'})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
          map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk' })
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk' })
          map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
          map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Blame line' })
          map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle line blame' })
          map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
          map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle deleted' })

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'GitSigns select hunk' })
        end
      })
    end,
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
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    },
    config = function()
      require('Comment').setup()
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
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
    end,
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
