vim.pack.add({
  { name = 'copilot.lua', src = 'https://github.com/zbirenbaum/copilot.lua' },
  { name = 'plenary.nvim', src = 'https://github.com/nvim-lua/plenary.nvim' },
  {
    name = 'CopilotChat.nvim',
    src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
  },
}, { load = false })

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
    }

    require('CopilotChat').setup {
      model = 'claude-3.5-sonnet',
    }

    vim.keymap.set('n', '<leader>tc', function()
      vim.cmd 'CopilotChatToggle'
    end, { desc = '[T]oggle [C]opilot Chat' })
  end,
})

vim.api.nvim_create_user_command('CopilotChatBuild', function()
  local utils = require 'eugenetriguba.utils'
  local copilot_path = vim.fn.stdpath 'data' .. '/site/pack/core/opt/CopilotChat.nvim'
  utils.build_with_job({ 'make', 'tiktoken' }, copilot_path, 'CopilotChat.nvim')
end, { desc = 'Build CopilotChat' })
