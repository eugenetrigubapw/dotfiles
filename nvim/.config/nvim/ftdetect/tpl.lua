vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.sh.tpl',
  callback = function()
    vim.bo.filetype = 'sh'
  end,
})
