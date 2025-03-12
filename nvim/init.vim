" ~/.config/nvim/init.vim
" Author: Max Lay
if &compatible
  set nocompatible
endif

let mapleader = "\<Space>"

" Plugins
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  " File search/browse
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-tree/nvim-tree.lua'
  nnoremap <F2> :NvimTreeToggle<CR>
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'smartpde/telescope-recent-files'

  nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
  nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap <C-n> <cmd>lua require('telescope').extensions.recent_files.pick()<cr>

  Plug 'tpope/vim-abolish', {'on': ['Abolish', 'Subvert']}

  " Git
  Plug 'mattn/webapi-vim'
  Plug 'mattn/gist-vim', {'on': 'Gist'}
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  " Diffs should be vertically split!
  set diffopt+=vertical

  " Theme
  Plug 'sainnhe/gruvbox-material'

  " LSP support
  Plug 'nvim-lua/plenary.nvim'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'mfussenegger/nvim-jdtls'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*', 'do': 'make install_jsregexp'}

  " Tree sitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Language support
  Plug 'sheerun/vim-polyglot'

  " Plug 'Raimondi/delimitMate'
  " let delimitMate_expand_cr = 1
  " let delimitMate_expand_space = 1

  " Actions
  Plug 'scrooloose/nerdcommenter'
  let NERDSpaceDelims=1

  Plug 'FooSoft/vim-argwrap'
  " Arguments on new lines
  map <silent> <leader>a :ArgWrap<CR>

  " Fixes increment and decrement for dates/times
  Plug 'tpope/vim-speeddating'

  " Motions
  Plug 'tpope/vim-surround'

  " Text objects
  " Adds a huge number of text objects
  Plug 'wellle/targets.vim'
  " Allows simple selection of text objects (eg. viv)
  Plug 'gorkunov/smartpairs.vim'

  " Filetypes
  " Guess indents based on file and containing directory
  Plug 'tpope/vim-sleuth'
  " Respect editorconfig
  Plug 'editorconfig/editorconfig-vim'

  " Traverse the undo/redo tree
  Plug 'mbbill/undotree'

  " Copilot
  Plug 'github/copilot.vim'

  nnoremap <F3> :UndotreeToggle<CR>
call plug#end()

if has('termguicolors')
  set termguicolors
endif
set background=dark

let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material
let g:lightline = {'colorscheme' : 'gruvbox_material'}

lua <<EOF

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.diagnostic.config({
    -- Virtual text writes on the line, and is on by default. I prefer
    -- vim.diagnostic.open_float
    virtual_text = false,
    signs = true,
  })

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
  vim.keymap.set('n', '<space>dp', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', '<space>dn', vim.diagnostic.goto_next, bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("nvim-lsp-installer").setup {}
local lspconfig = require('lspconfig')
local servers = { 'ts_ls', 'tailwindcss', 'pyright' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

-- nvim-cmp setup
local cmp = require 'cmp'
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

-- null-ls setup
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettierd,
    },
})

require("telescope").load_extension("recent_files")

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Disable netrw in favour of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  update_focused_file = {
    enable = true
  }
})

EOF

" Show LSP diagnostics in line colour, not in the gutter
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint

" Copilot
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Improve startup time
set guioptions=M

" General
syntax on
filetype on
filetype plugin on
filetype indent on
" Disable safe write to fix autoreload with Parcel
set backupcopy=yes
set shell=/bin/bash
" Uncomment for mouse support
" set mouse=a
" Fix backspace
set backspace=indent,eol,start
" Disable ex mode
map q: <Nop>
nnoremap Q <nop>
" Increase command history
set history=200
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
" Suggested by coc
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use ; as :
nnoremap ; :
" Removes error message when navigating away from unsaved buffer
set hidden
" Saving
nmap <Leader>w :w!<cr>
" Sudo write
cmap w!! w !sudo tee % >/dev/null
" Reload file if edits happen somewhere else
set autoread
"Auto resize panes on terminal resize
autocmd VimResized * wincmd =

" Terminal setup
set termencoding=utf-8
set fileencodings=utf8,cp1251
set encoding=utf8
" fixes terminal draw bug in Tmux
set t_ut=
" Beeps off, not that I ever use a terminal that does
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

set autoindent
" Jump to nearest indentation
set shiftround

" Statusline stuff
" Give more space for displaying messages.
" set cmdheight=2
" Display status line always
set laststatus=2
set ruler
set showcmd

" Ignore some file types
set wildmenu
set wildignorecase
" %% is directory containing current file
cabbr <expr> %% expand('%:p:h')
set wildignore+=.hg,.git,.svn
set wildignore+=*.pyc
set wildignore+=venv
set wildignore+=*.beam
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.class,*.o

" Display whitespace
set listchars=tab:>.,trail:.
set list

" Line numbers and limits
set number                      " Show line numbers
set cc=120                       " Ver line in 120 column
set cursorline

" Search
set hlsearch                    " Highlight searches
set incsearch                   " Highlight dynamically as pattern is typed
set smartcase                   " Ignore case of searches unless they contain an uppercase character
" Leader / to clear search highligting
nmap <Leader>/ :nohlsearch<CR>

" Allows undo after file is closed
if exists("&undodir")
    set undofile
    set undodir=/tmp
endif
" Swap files and backup are super annoying. I save often
set noswapfile
set nobackup

" Movement
set scrolloff=8                 " Start scrolling n lines before border
" Scroll wrapped lines normally
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
" End of line
inoremap <C-e> <C-o>$
" Start of line
inoremap <C-a> <C-o>^

"Easy ways of getting into normal mode
inoremap kk <ESC>
inoremap jj <ESC>

" Spelling
set spell spelllang=en_nz

" Make it easier to navigate windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" The moving commands don't align perfectly (and we can't use shift)
" but make them behave similar to i3/sway
map <Leader><C-h> <C-w>R
map <Leader><C-j> <C-w>R
map <Leader><C-k> <C-w>r
map <Leader><C-l> <C-w>r

" Vimrc shortcuts
nmap <silent> <Leader>ev :ed $MYVIMRC<CR>

" Newline
map <Leader>o o<Esc>
map <Leader>O O<Esc>

" Copy, paste and cut to system clipboard
map <Leader>y "+y
map <Leader>d "+d
map <Leader>p :set paste<CR>"+p:set nopaste<CR>
map <Leader>P :set paste<CR>"+P:set nopaste<CR>

" Vimgrep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat+=%f:%l:%c:%m

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
map <Leader>q :call ToggleQuickFix()<CR>
