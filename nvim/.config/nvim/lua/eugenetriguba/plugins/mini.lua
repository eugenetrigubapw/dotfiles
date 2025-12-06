vim.pack.add {
  {
    name = 'mini',
    src = 'https://github.com/nvim-mini/mini.nvim',
    version = 'main',
  },
}
require('mini.pairs').setup()
require('mini.align').setup()
require('mini.tabline').setup()
require('mini.statusline').setup()
require('mini.indentscope').setup {
  symbol = '│',
  options = { try_as_border = true },
}
local miniclue = require 'mini.clue'
miniclue.setup {
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },
    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },
    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    -- Window commands
    { mode = 'n', keys = '<C-w>' },
    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = {
    delay = 300,
  },
}

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup { n_lines = 500 }

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

require('mini.diff').setup()
vim.keymap.set('n', '<leader>ho', function()
  require('mini.diff').toggle_overlay(0)
end, { desc = 'git [o]verlay hunk diff' })
vim.keymap.set('n', '<leader>hs', function()
  require('mini.diff').toggle_overlay(0)
end, { desc = '[H]unk [S]tage (toggle overlay)' })
vim.keymap.set('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal { ']c', bang = true }
  else
    require('mini.diff').goto_hunk 'next'
  end
end, { desc = 'jump to next git [c]hange' })
vim.keymap.set('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal { '[c', bang = true }
  else
    require('mini.diff').goto_hunk 'prev'
  end
end, { desc = 'jump to previous git [c]hange' })

require('mini.git').setup()
vim.keymap.set('n', '<leader>hb', function()
  require('mini.git').show_at_cursor()
end, { desc = 'git [b]lame at cursor' })
vim.keymap.set('n', '<leader>hd', function()
  require('mini.git').show_diff_source()
end, { desc = 'git [d]iff source' })
vim.keymap.set('n', '<leader>hs', function()
  require('mini.git').show_range_history()
end, { desc = 'git [s]how range history' })
vim.keymap.set('v', '<leader>hs', function()
  require('mini.git').show_range_history()
end, { desc = 'git [s]how range history' })
vim.keymap.set('n', '<leader>gl', function()
  require('mini.git').show_range_history { show_level = 'buffer' }
end, { desc = 'git [l]og' })
