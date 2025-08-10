vim.pack.add({
  {
    name = 'conform',
    src = 'https://github.com/stevearc/conform.nvim',
  },
}, { load = false })

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    local prettier_fmt = { 'prettierd', 'prettier', stop_after_first = true }
    require('conform').setup {
      notify_on_error = true,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
        python = { 'isort', 'black' },
        rust = { 'rustfmt' },
        javascript = prettier_fmt,
        typescript = prettier_fmt,
        javascriptreact = prettier_fmt,
        typescriptreact = prettier_fmt,
        css = prettier_fmt,
        htmldjango = prettier_fmt,
        html = prettier_fmt,
        sh = { 'shfmt' },
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        tf = { 'terraformfmt' },
      },
      formatters = {
        isort = {
          prepend_args = { '--profile', 'black' },
        },
      },
    }
  end,
})

-- Format current buffer
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

-- Toggle autoformat for current buffer
vim.keymap.set('n', '<leader>tf', function()
  if vim.b.disable_autoformat then
    vim.cmd 'FormatEnable'
    vim.notify 'Enabled autoformat for current buffer'
  else
    vim.cmd 'FormatDisable!'
    vim.notify 'Disabled autoformat for current buffer'
  end
end, { desc = 'Toggle autoformat for current buffer' })

-- Toggle autoformat globally
vim.keymap.set('n', '<leader>tF', function()
  if vim.g.disable_autoformat then
    vim.cmd 'FormatEnable'
    vim.notify 'Enabled autoformat globally'
  else
    vim.cmd 'FormatDisable'
    vim.notify 'Disabled autoformat globally'
  end
end, { desc = 'Toggle autoformat globally' })

-- :FormatDisable! disables autoformat for this buffer only
-- :FormatDisable disables autoformat globally
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

-- :FormatEnable enables autoformat globally and for this buffer
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
