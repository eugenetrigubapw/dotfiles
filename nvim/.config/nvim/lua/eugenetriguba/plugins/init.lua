local plugins = {
  'tree-sitter',
  'colorschemes',
  'which-key',
  'indent_line',
  'conform',
  'fzf-lua',
  'gitsigns',
  'harpoon',
  'lint',
  'mini',
  'oil',
  'lsp',
  'blink',
  'tmux-navigator',
}

for _, plugin in ipairs(plugins) do
  pcall(require, 'eugenetriguba.plugins.' .. plugin)
end
