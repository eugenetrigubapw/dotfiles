return {
  {
    'https://github.com/mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Default linters, which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- They can be disabled by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil

      local lint = require 'lint'
      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['cpp'] = { 'cppcheck' }
      lint.linters_by_ft['dockerfile'] = { 'hadolint' }
      lint.linters_by_ft['json'] = { 'jsonlint' }
      lint.linters_by_ft['terraform'] = { 'tflint', 'terraform_validate' }
      lint.linters_by_ft['python'] = { 'ruff', 'bandit' }
      lint.linters_by_ft['markdown'] = nil
      lint.linters_by_ft['text'] = nil
      lint.linters_by_ft['sh'] = { 'shellcheck' }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
