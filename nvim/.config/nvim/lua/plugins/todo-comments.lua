-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
      keywords = {
        NOTE = {
          color = 'hint',
          alt = { 'INFO', 'Note' },
        },
      },
    },
    keys = {
      {
        '<leader>]t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
      {
        '<leader>[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
      {
        '<leader>st',
        function()
          vim.cmd 'TodoTelescope'
        end,
        desc = 'Search todo comments',
      },
    },
  },
}
