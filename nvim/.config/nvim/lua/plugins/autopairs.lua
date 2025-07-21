-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local autopairs = require 'nvim-autopairs'
    autopairs.setup {
      check_ts = true, -- Use treesitter for smarter pairing
      disable_filetype = { 'TelescopePrompt' },
    }
  end,
}
