return {
  {
    'https://github.com/zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'https://github.com/zbirenbaum/copilot.lua' },
      { 'https://github.com/nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    config = function()
      require('CopilotChat').setup {
        model = 'claude-3.5-sonnet',
        vim.keymap.set('n', '<leader>tc', function()
          vim.cmd 'CopilotChatToggle'
        end, { desc = '[T]oggle [C]opilot Chat' }),
      }
    end,
  },
}
