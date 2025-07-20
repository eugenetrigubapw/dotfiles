return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    config = function()
      require('CopilotChat').setup {
        model = 'claude-sonnet-4',
      }
      vim.keymap.set('n', '<leader>tc', function()
        vim.cmd 'CopilotChatToggle'
      end, { desc = '[Copilot] Toggle Copilot Chat' })
    end,
  },
}
