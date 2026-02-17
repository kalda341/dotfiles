-- Plugin Management with vim-plug

-- Auto-install vim-plug
local plug_install_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_install_path)) > 0 then
  vim.fn.system({
    'curl', '-fLo', plug_install_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

-- Plugin list
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

-- ArgWrap keybinding
vim.keymap.set('', '<leader>a', ':ArgWrap<CR>', { silent = true })

-- Copilot settings
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  silent = true,
  script = true,
  replace_keycodes = false
})
