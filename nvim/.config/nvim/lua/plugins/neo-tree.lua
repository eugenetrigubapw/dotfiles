-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        '.DS_Store',
        'thumbs.db',
        '.git',
      },
      always_show_by_pattern = {
        '.env*',
        '.gitignore',
      },
    },
  },
}
