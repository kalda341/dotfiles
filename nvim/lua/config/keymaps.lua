-- Keymaps

-- Use ; as :
vim.keymap.set('n', ';', ':')

-- Disable ex mode
vim.keymap.set('n', 'q:', '<Nop>')
vim.keymap.set('n', 'Q', '<Nop>')

-- Saving
vim.keymap.set('n', '<Leader>w', ':w!<CR>', { desc = 'Save file' })

-- Sudo write
vim.keymap.set('c', 'w!!', 'w !sudo tee % >/dev/null', { desc = 'Save with sudo' })

-- Clear search highlighting
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Scroll wrapped lines normally
vim.keymap.set('n', 'k', 'gk', { silent = true })
vim.keymap.set('n', 'j', 'gj', { silent = true })

-- End/Start of line in insert mode
vim.keymap.set('i', '<C-e>', '<C-o>$')
vim.keymap.set('i', '<C-a>', '<C-o>^')

-- Easy ways of getting into normal mode
vim.keymap.set('i', 'kk', '<ESC>')
vim.keymap.set('i', 'jj', '<ESC>')

-- Navigate windows (handled by vim-tmux-navigator plugin)

-- Window rotation (i3/sway-like)
vim.keymap.set('', '<Leader><C-h>', '<C-w>R', { desc = 'Rotate windows left' })
vim.keymap.set('', '<Leader><C-j>', '<C-w>R', { desc = 'Rotate windows down' })
vim.keymap.set('', '<Leader><C-k>', '<C-w>r', { desc = 'Rotate windows up' })
vim.keymap.set('', '<Leader><C-l>', '<C-w>r', { desc = 'Rotate windows right' })

-- Vimrc shortcuts
vim.keymap.set('n', '<Leader>ev', ':ed $MYVIMRC<CR>', { silent = true, desc = 'Edit init.lua' })

-- Newline without entering insert mode
vim.keymap.set('', '<Leader>o', 'o<Esc>', { desc = 'Insert line below' })
vim.keymap.set('', '<Leader>O', 'O<Esc>', { desc = 'Insert line above' })

-- System clipboard operations
vim.keymap.set('', '<Leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set('', '<Leader>d', '"+d', { desc = 'Delete to clipboard' })
vim.keymap.set('', '<Leader>p', ':set paste<CR>"+p:set nopaste<CR>', { desc = 'Paste from clipboard' })
vim.keymap.set('', '<Leader>P', ':set paste<CR>"+P:set nopaste<CR>', { desc = 'Paste from clipboard (before)' })

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
vim.keymap.set('', '<Leader>q', toggle_quickfix, { desc = 'Toggle quickfix' })
