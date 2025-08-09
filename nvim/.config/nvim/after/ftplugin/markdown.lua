local opt_local = vim.opt_local

opt_local.textwidth = 80
opt_local.formatoptions:append { 't' }
opt_local.formatoptions:remove { 'l' }

opt_local.wrap = true
opt_local.linebreak = true
opt_local.breakindent = true
opt_local.conceallevel = 3

opt_local.spell = true
opt_local.spelllang = 'en_us'

opt_local.expandtab = true
opt_local.tabstop = 2
opt_local.shiftwidth = 2

opt_local.list = true
opt_local.listchars = 'tab:»·,trail:·'
