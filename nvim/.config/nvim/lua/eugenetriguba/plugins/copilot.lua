vim.pack.add {
  {
    name = 'copilot.lua',
    src = 'https://github.com/zbirenbaum/copilot.lua',
  },
  {
    name = 'CopilotChat.nvim',
    src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
  },
  {
    name = 'plenary.nvim',
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
}
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local name, kind, path = event.data.spec.name, event.data.kind, event.data.path
    if name == 'CopilotChat.nvim' and (kind == 'install' or kind == 'update') then
      vim.notify('Building CopilotChat.nvim...', vim.log.levels.INFO)
      vim.system({ 'make', 'tiktoken' }, { cwd = path, text = true }, function(result)
        if result.code == 0 then
          vim.notify('CopilotChat.nvim build successful!', vim.log.levels.INFO)
        else
          vim.notify('CopilotChat.nvim build failed: ' .. (result.stderr or ''), vim.log.levels.ERROR)
        end
      end)
    end
  end,
})
require('copilot').setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}
require('CopilotChat').setup {
  model = 'claude-sonnet-4.5',
}
vim.keymap.set('n', '<leader>tc', function()
  vim.cmd 'CopilotChatToggle'
end, { desc = '[T]oggle [C]opilot Chat' })
