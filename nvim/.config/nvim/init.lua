-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

-- Make line numbers default
opt.number = true

-- Use relative line numbers, to help with jumping.
opt.relativenumber = true

-- In Insert mode, replace <Tab> with the appropriate
-- number of spaces.
opt.expandtab = true

-- When starting a new line, use smart indentation to
-- figure out what indentation the new line should be
-- at.
opt.autoindent = true
opt.smartindent = true

-- Number of spaces to use for each step of autoindentation.
opt.shiftwidth = 2

-- Number of spaces to use when using <Tab>.
opt.tabstop = 2

-- Case-insensitive searching UNLESS \C or one
-- or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Explicitly enable 24-bit RGB colors in the terminal.
-- Neovim will normally automatically attempt to enable
-- this if it detects the terminal can support it.
opt.termguicolors = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Show which line your cursor is on
opt.cursorline = true

-- If performing an operation that would fail due to unsaved
-- changes in the buffer (like `:q`), instead raise a dialog
-- asking if you wish to save the current file(s)
--
-- See `:help 'confirm'`
opt.confirm = true

-- Save undo history
opt.undofile = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Enable mouse mode e.g. can be useful for resizing splits
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--
-- Schedule the setting after `UiEnter` because it can increase
-- startup-time. Remove this option to keep the OS clipboard
-- independent from neovim.
--
-- See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Continue to visually indent wrapped lines
-- to preserve horizontal blocks of text
opt.breakindent = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- See `:help 'list'` and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

local map = vim.keymap.set

-- Create split panes using leader key
map('n', '<leader>sh', ':split<CR>')
map('n', '<leader>sv', ':vsplit<CR>')

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- to remember.
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<leader>rdt', function()
  local func_name = vim.fn.expand '<cword>'
  local output = vim.fn.systemlist('django-test --list ' .. func_name)
  if #output == 0 then
    vim.notify('No tests found for: ' .. func_name, vim.log.levels.WARN)
  elseif #output == 1 then
    -- Single match, run directly
    vim.cmd('split | terminal ' .. output[1])
  else
    -- Multiple matches, prompt user
    vim.ui.select(output, {
      prompt = 'Select test to run:',
    }, function(choice)
      if choice then
        vim.cmd('split | terminal ' .. choice)
      end
    end)
  end
end, { desc = '[R]un [D]jango [T]est for word under cursor' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.pack.add {
  {
    name = 'tokyonight',
    src = 'https://github.com/folke/tokyonight.nvim',
  },
}
require('tokyonight').setup {
  styles = {
    comments = { italic = false },
  },
}
vim.cmd.colorscheme 'tokyonight'

vim.pack.add {
  {
    name = 'mini',
    src = 'https://github.com/nvim-mini/mini.nvim',
    version = 'main',
  },
}
require('mini.pairs').setup()
require('mini.tabline').setup()
require('mini.statusline').setup()
require('mini.indentscope').setup {
  symbol = '│',
  options = { try_as_border = true },
}
local miniclue = require 'mini.clue'
miniclue.setup {
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },
    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },
    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    -- Window commands
    { mode = 'n', keys = '<C-w>' },
    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = {
    delay = 300,
  },
}

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup { n_lines = 500 }

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

require('mini.diff').setup()
vim.keymap.set('n', '<leader>ho', '<cmd>lua minidiff.toggle_overlay()<cr>', { desc = 'git [o]verlay hunk diff' })
vim.keymap.set('n', '<leader>hs', ':lua MiniDiff.toggle_overlay()<CR>', { desc = '[H]unk [S]tage (toggle overlay)' })
vim.keymap.set('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal { ']c', bang = true }
  else
    require('mini.diff').goto_hunk 'next'
  end
end, { desc = 'jump to next git [c]hange' })
vim.keymap.set('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal { '[c', bang = true }
  else
    require('mini.diff').goto_hunk 'prev'
  end
end, { desc = 'jump to previous git [c]hange' })

require('mini.git').setup()
vim.keymap.set('n', '<leader>hb', '<cmd>lua minigit.show_at_cursor()<cr>', { desc = 'git [b]lame at cursor' })
vim.keymap.set('n', '<leader>hd', '<cmd>lua minigit.show_diff_source()<cr>', { desc = 'git [d]iff source' })
vim.keymap.set('n', '<leader>hs', '<cmd>lua minigit.show_range_history()<cr>', { desc = 'git [s]how range history' })
vim.keymap.set('v', '<leader>hs', '<cmd>lua minigit.show_range_history()<cr>', { desc = 'git [s]how range history' })
vim.keymap.set(
  'n',
  '<leader>gl',
  '<cmd>lua minigit.show_range_history(nil, nil, {show_level = "buffer"})<cr>',
  { desc = 'git [l]og' }
)
-- vim.keymap.set('n', ']h', ':lua MiniDiff.goto_hunk("next")<CR>', { desc = 'Next hunk' })
-- vim.keymap.set('n', '[h', ':lua MiniDiff.goto_hunk("prev")<CR>', { desc = 'Previous hunk' })

-- Support navigating between tmux splits and vim splits
vim.pack.add {
  {
    name = 'vim-tmux-navigator',
    src = 'https://github.com/christoomey/vim-tmux-navigator',
  },
}
vim.keymap.set('n', '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>')
vim.keymap.set('n', '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>')
vim.keymap.set('n', '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>')
vim.keymap.set('n', '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>')
vim.keymap.set('n', '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>')

-- Replace netrw with Oil to work with the file hierarchy as a regular
-- vim buffer.
vim.pack.add {
  {
    name = 'oil',
    src = 'https://github.com/stevearc/oil.nvim',
  },
  {
    name = 'mini.icons',
    src = 'https://github.com/nvim-mini/mini.icons',
  },
}
require('oil').setup {
  keymaps = {
    -- Clashes with tmux navigator
    ['<C-l>'] = false,
    ['<C-h>'] = false,
    ['<C-r>'] = 'actions.refresh',
  },
}
vim.keymap.set('n', '\\', '<CMD>Oil --float<CR>', { desc = 'Open parent directory in floating window' })
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

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
local treesitter = require 'nvim-treesitter'
treesitter.setup {
  ensure_installed = 'all',
  auto_install = true,
  modules = {},
  sync_install = false,
  ignore_install = { 'norg', 'org', 'ipkg', 'verilog' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby', 'cpp' },
  },
  indent = { enable = true, disable = { 'ruby', 'cpp' } },
  incremental_selection = { enable = true },
  context_commentstring = { enable = true },
  textobjects = { enable = true },
}
require('treesitter-context').setup {
  multiline_threshold = 10,
}
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'nvim-treesitter' and args.data.kind == 'update' then
      vim.schedule(function()
        -- If nvim-treesitter was updated, run ':TSUpdate' via the lua API to
        -- ensure the installed parsers are also updated.
        vim.cmd 'TSUpdate all'
      end)
    end
  end,
})

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

vim.pack.add {
  {
    name = 'lazygit.nvim',
    src = 'https://github.com/kdheepak/lazygit.nvim',
  },
  {
    name = 'plenary.nvim',
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
}
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

vim.pack.add {
  {
    name = 'harpoon',
    src = 'https://github.com/ThePrimeagen/harpoon',
    version = 'harpoon2',
  },
  {
    name = 'plenary.nvim',
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
}
local harpoon = require 'harpoon'
harpoon:setup()
vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<leader>1', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<leader>2', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<leader>3', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<leader>4', function()
  harpoon:list():select(4)
end)

vim.keymap.set('n', '<C-x>', function()
  harpoon:list():clear()
end, { desc = 'Clear Harpoon list' })
vim.keymap.set('n', '<leader>hp', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<leader>hn', function()
  harpoon:list():next()
end)

vim.pack.add {
  {
    name = 'nvim-lint',
    src = 'https://github.com/mfussenegger/nvim-lint',
  },
}
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
lint.linters_by_ft['python'] = { 'ruff' }
lint.linters_by_ft['markdown'] = nil
lint.linters_by_ft['text'] = nil
lint.linters_by_ft['xml'] = { 'xmllint' }
lint.linters_by_ft['sh'] = { 'shellcheck' }
table.insert(lint.linters.shellcheck.args, '-x')
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

vim.pack.add {
  {
    name = 'conform.nvim',
    src = 'https://github.com/stevearc/conform.nvim',
  },
}
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- Disable "format_on_save lsp_fallback" for certain languages.
    local disable_filetypes = { sql = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end
    return {
      timeout_ms = 3000,
      lsp_format = 'fallback',
    }
  end,
  formatters_by_ft = {
    c = { 'clang-format' },
    lua = { 'stylua' },
    go = { 'gofmt' },
    python = { 'black', 'isort' },
    rust = { 'rustfmt' },
    sh = { 'shfmt' },
    md = { 'prettierd', 'prettier', stop_after_first = true },
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
  },
}
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

vim.keymap.set('', '<leader>bf', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[B]uffer [F]ormat' })

vim.keymap.set('n', '<leader>tf', function()
  -- If autoformat is currently disabled for this buffer,
  -- then enable it, otherwise disable it
  if vim.b.disable_autoformat then
    vim.cmd 'FormatEnable'
    vim.notify 'Enabled autoformat for current buffer'
  else
    vim.cmd 'FormatDisable!'
    vim.notify 'Disabled autoformat for current buffer'
  end
end, { desc = 'Toggle autoformat for current buffer' })

vim.keymap.set('n', '<leader>tF', function()
  -- If autoformat is currently disabled globally,
  -- then enable it globally, otherwise disable it globally
  if vim.g.disable_autoformat then
    vim.cmd 'FormatEnable'
    vim.notify 'Enabled autoformat globally'
  else
    vim.cmd 'FormatDisable'
    vim.notify 'Disabled autoformat globally'
  end
end, { desc = 'Toggle autoformat globally' })

vim.pack.add {
  {
    name = 'copilot.lua',
    src = 'https://github.com/zbirenbaum/copilot.lua',
  },
  {
    name = 'CopilotChat.nvim',
    src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
  },
  {
    name = 'plenary.nvim',
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
}
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'CopilotChat.nvim' then
      if args.data.kind == 'install' or args.data.kind == 'update' then
        vim.notify('Building CopilotChat.nvim...', vim.log.levels.INFO)
        vim.system({ 'make', 'tiktoken' }, { cwd = spec.path, text = true }, function(result)
          if result.code == 0 then
            vim.notify('CopilotChat.nvim build successful!', vim.log.levels.INFO)
          else
            vim.notify('CopilotChat.nvim build failed: ' .. (result.stderr or ''), vim.log.levels.ERROR)
          end
        end)
      end
    end
  end,
})
require('copilot').setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}
require('CopilotChat').setup {
  model = 'claude-sonnet-4.5',
}
vim.keymap.set('n', '<leader>tc', function()
  vim.cmd 'CopilotChatToggle'
end, { desc = '[T]oggle [C]opilot Chat' })

vim.pack.add {
  {
    name = 'blink.cmp',
    src = 'https://github.com/saghen/blink.cmp',
  },
  {
    name = 'LuaSnip',
    src = 'https://github.com/L3MON4D3/LuaSnip',
  },
  {
    name = 'friendly-snippets',
    src = 'https://github.com/rafamadriz/friendly-snippets',
  },
  {
    name = 'lazydev.nvim',
    src = 'https://github.com/folke/lazydev.nvim',
  },
  {
    name = 'blink-cmp-copilot',
    src = 'https://github.com/giuxtaposition/blink-cmp-copilot',
  },
}
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'blink.cmp' then
      if args.data.kind == 'install' or args.data.kind == 'update' then
        vim.notify('Building blink.cmp...', vim.log.levels.INFO)
        vim.system({ 'cargo', '+nightly', 'build', '--release' }, { cwd = spec.path, text = true }, function(result)
          if result.code == 0 then
            vim.notify('blink.cmp build successful!', vim.log.levels.INFO)
          else
            vim.notify('blink.cmp build failed: ' .. (result.stderr or ''), vim.log.levels.ERROR)
          end
        end)
      end
    end
  end,
})
require('luasnip.loaders.from_vscode').lazy_load()
require('blink.cmp').setup {
  keymap = {
    preset = 'default',
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'copilot' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      copilot = {
        name = 'copilot',
        module = 'blink-cmp-copilot',
        score_offset = 100,
        async = true,
      },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
}

vim.pack.add {
  {
    name = 'lazydev.nvim',
    src = 'https://github.com/folke/lazydev.nvim',
  },
  {
    name = 'nvim-lspconfig',
    src = 'https://github.com/neovim/nvim-lspconfig',
  },
  {
    name = 'mason.nvim',
    src = 'https://github.com/williamboman/mason.nvim',
  },
  {
    name = 'mason-lspconfig.nvim',
    src = 'https://github.com/williamboman/mason-lspconfig.nvim',
  },
  {
    name = 'mason-tool-installer.nvim',
    src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  {
    name = 'fidget.nvim',
    src = 'https://github.com/j-hui/fidget.nvim',
  },
}

-- Lazydev for Lua development
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}
-- Fidget for LSP progress
require('fidget').setup {}
require('mason').setup()
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grr', fzf.lsp_references, '[G]oto [R]eferences')
    map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')
    map('grd', fzf.lsp_definitions, '[G]oto [D]efinition')
    map('grD', fzf.lsp_declarations, '[G]oto [D]eclaration')
    map('gO', fzf.lsp_document_symbols, 'Open Document Symbols')
    map('gW', fzf.lsp_workspace_symbols, 'Open Workspace Symbols')
    map('grt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}

local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
  clangd = {},
  gopls = {},
  basedpyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          typeCheckingMode = 'basic',
        },
      },
    },
  },
  rust_analyzer = {},
  ts_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  stylua = {},
  tailwindcss = {},
  mesonlsp = {},
  terraformls = {},
  bashls = {},
  jdtls = {
    settings = {
      java = {
        configuration = {
          updateBuildConfiguration = 'interactive',
          refreshBundles = true,
        },
        completion = {
          favoriteStaticMembers = {
            'org.hamcrest.MatcherAssert.assertThat',
            'org.hamcrest.Matchers.*',
            'org.hamcrest.CoreMatchers.*',
            'org.junit.jupiter.api.Assertions.*',
            'java.util.Objects.requireNonNull',
            'java.util.Objects.requireNonNullElse',
          },
        },
        contentProvider = { preferred = 'fernflower' },
        eclipse = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = 'all',
          },
        },
        maven = {
          downloadSources = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        saveActions = {
          organizeImports = true,
        },
        signatureHelp = { enabled = true },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
      },
    },
  },
}

local ensure_installed = vim.tbl_keys(servers or {})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }
require('mason-lspconfig').setup {
  ensure_installed = {},
  automatic_installation = false,
  automatic_enable = true,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}
