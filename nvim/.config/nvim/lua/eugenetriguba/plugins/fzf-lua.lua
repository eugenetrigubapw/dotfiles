vim.pack.add {
  {
    name = 'fzf-lua',
    src = 'https://github.com/ibhagwan/fzf-lua',
  },
}
require('fzf-lua').setup {
  winopts = {
    preview = {
      default = 'bat',
    },
  },
  files = {
    fd_opts = '--type f --hidden --exclude .git',
  },
  grep = {
    rg_opts = "--color=never --no-heading --with-filename --line-number --column --smart-case --hidden --glob '!.git/*'",
  },
}
local fzf = require 'fzf-lua'
vim.keymap.set('n', '<leader>fh', fzf.helptags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fk', fzf.keymaps, { desc = '[F]ind [K]eymaps' })
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fc', fzf.commands, { desc = '[F]ind [C]ommands' })
vim.keymap.set('n', '<leader>fs', fzf.builtin, { desc = '[F]ind [S]elect fzf-lua' })
vim.keymap.set('n', '<leader>fw', fzf.grep_cword, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fd', fzf.diagnostics_document, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', fzf.resume, { desc = '[F]ind [R]esume' })
vim.keymap.set('n', '<leader>f.', fzf.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>f/', function()
  fzf.live_grep {
    filespec = vim.fn.expand '%:p',
    prompt = 'Live Grep in Open Files> ',
  }
end, { desc = '[F]ind [/] in Open Files' })
vim.keymap.set('n', '<leader>fn', function()
  fzf.files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[F]ind [N]eovim files' })
