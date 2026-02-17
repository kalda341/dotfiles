-- Keymaps

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

-- QuickFix toggle
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
