return {
  {
    'https://github.com/stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    lazy = false,
    keys = {
      {
        '<leader>bf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[B]uffer [F]ormat',
      },
      {
        '<leader>tf',
        function()
          -- If autoformat is currently disabled for this buffer,
          -- then enable it, otherwise disable it
          if vim.b.disable_autoformat then
            vim.cmd 'FormatEnable'
            vim.notify 'Enabled autoformat for current buffer'
          else
            vim.cmd 'FormatDisable!'
            vim.notify 'Disabled autoformat for current buffer'
          end
        end,
        desc = 'Toggle autoformat for current buffer',
      },
      {
        '<leader>tF',
        function()
          -- If autoformat is currently disabled globally,
          -- then enable it globally, otherwise disable it globally
          if vim.g.disable_autoformat then
            vim.cmd 'FormatEnable'
            vim.notify 'Enabled autoformat globally'
          else
            vim.cmd 'FormatDisable'
            vim.notify 'Disabled autoformat globally'
          end
        end,
        desc = 'Toggle autoformat globally',
      },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        -- Disable "format_on_save lsp_fallback" for certain languages.
        local disable_filetypes = { sql = true, c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end

        return {
          timeout_ms = 3000,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
        python = { 'black', 'isort' },
        rust = { 'rustfmt' },
        sh = { 'shfmt' },
        xml = { 'xmlformatter' },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        htmldjango = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        tf = { 'terraform_fmt' },
        nix = { 'nixfmt' },
        java = { 'google-java-format' },
      },
      formatters = {
        isort = {
          prepend_args = { '--profile', 'black' },
        },
        xmlformatter = {
          command = function()
            local python_path = vim.g.python3_host_prog
            if python_path and python_path ~= '' then
              local venv_bin = vim.fn.fnamemodify(python_path, ':h')
              return venv_bin .. '/xmlformat'
            end
            return 'xmlformat'
          end,
          prepend_args = { '--blanks' },
        },
      },
    },
    config = function(_, opts)
      require('conform').setup(opts)

      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- :FormatDisable! disables autoformat for this buffer only
          vim.b.disable_autoformat = true
        else
          -- :FormatDisable disables autoformat globally
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true, -- allows the ! variant
      })

      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = 'Re-enable autoformat-on-save',
      })
    end,
  },
}
