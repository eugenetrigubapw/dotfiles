-- Treesitter adds understanding of the source code text (e.g. fields, methods,
-- classes)
vim.pack.add {
  {
    name = 'nvim-treesitter',
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
  {
    name = 'nvim-treesitter-context',
    src = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
  },
}

-- Install parsers
require('nvim-treesitter').setup {
  ensure_installed = 'all',
  auto_install = true,
  ignore_install = { 'norg', 'org', 'ipkg', 'verilog' },
}

-- Enable treesitter highlighting for all buffers
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    -- Start treesitter highlighting if a parser is available
    pcall(vim.treesitter.start, args.buf)
  end,
})

require('treesitter-context').setup {
  multiline_threshold = 5,
}

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == 'nvim-treesitter' and (kind == 'update' or kind == 'install') then
      vim.schedule(function()
        -- If nvim-treesitter was updated, run ':TSUpdate' to
        -- ensure the installed parsers are also updated.
        vim.cmd 'TSUpdate all'
      end)
    end
  end,
})
