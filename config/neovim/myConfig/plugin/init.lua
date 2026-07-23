require('ui.colors')
require('ui.bufferline')
require('ui.snacks')
require('ui.notify')
require('ui.noice')

require('general.treesitter')
require('general.telescope')
require('general.nvimtree')
require('general.mini')
require('general.gitsigns')
require('general.fugitive')
require('general.leetcode')
require('general.startup')
require('general.ollama')
require('general.oil')
require('general.image')

require('lsp.lsp_config')
require('lsp.lspkind')
require('lsp.lspsaga')

require('completion.cmp')
require('completion.luasnip')

require('keymaps.general')

-- Put this line last so other shjt wouldn't override it
require('ui.statusline')
