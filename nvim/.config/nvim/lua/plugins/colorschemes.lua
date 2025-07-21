-- Setup the tokyonight color scheme.
--
-- To see what colorschemes are already installed: `:Telescope colorscheme`.

return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Other styles: 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
