vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    -- PEP 8 indentation settings
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true

    -- 88 character length lines for Black formatter
    vim.opt_local.colorcolumn = '88'

    -- Google-style docstrings
    vim.g.python_style = 'google'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.commentstring = '-- %s'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
