vim.pack.add({
  {
    name = 'which-key',
    src = 'https://github.com/folke/which-key.nvim',
  },
}, { load = false })

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    require('which-key').setup {}
  end,
})
