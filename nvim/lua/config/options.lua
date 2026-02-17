-- Options / Settings

-- Leader key (must be set before plugins load)
vim.g.mapleader = " "

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

-- Indentation
vim.opt.shiftround = true

-- Statusline
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.showcmd = true

-- Hide command line when not in use (Neovim 0.8+)
vim.opt.cmdheight = 0

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

-- Diff settings
vim.opt.diffopt:append('vertical')

-- %% expands to directory of current file
vim.cmd([[cnoreabbrev <expr> %% expand('%:p:h')]])

-- Auto resize panes on terminal resize
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd ='
})
