local map = vim.keymap.set

-- Create split panes using leader key
map('n', '<leader>sh', ':split<CR>')
map('n', '<leader>sv', ':vsplit<CR>')

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Use tab and shift-tab to navigate buffers
map('n', '<Tab>', '<cmd>bnext<CR>', { noremap = true, silent = true })
map('n', '<S-Tab>', '<cmd>bprevious<CR>', { noremap = true, silent = true })

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- to remember.
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<leader>rdt', function()
  local func_name = vim.fn.expand '<cword>'
  local output = vim.fn.systemlist('django-test --list ' .. func_name)
  if #output == 0 then
    vim.notify('No tests found for: ' .. func_name, vim.log.levels.WARN)
  elseif #output == 1 then
    -- Single match, run directly
    vim.cmd('split | terminal ' .. output[1])
  else
    -- Multiple matches, prompt user
    vim.ui.select(output, {
      prompt = 'Select test to run:',
    }, function(choice)
      if choice then
        vim.cmd('split | terminal ' .. choice)
      end
    end)
  end
end, { desc = '[R]un [D]jango [T]est for word under cursor' })
