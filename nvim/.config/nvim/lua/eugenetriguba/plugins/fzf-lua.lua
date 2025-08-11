vim.pack.add({
  {
    name = 'fzf-lua',
    src = 'https://github.com/ibhagwan/fzf-lua',
  },
  {
    name = 'nvim-web-devicons',
    src = 'https://github.com/nvim-tree/nvim-web-devicons',
  },
}, { load = false })

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    require('fzf-lua').setup {}
    vim.keymap.set('n', '<leader>sh', require('fzf-lua').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', require('fzf-lua').keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', require('fzf-lua').files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', require('fzf-lua').builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', require('fzf-lua').grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', require('fzf-lua').diagnostics_document, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', require('fzf-lua').resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', require('fzf-lua').oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', require('fzf-lua').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sn', function()
      require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
})
