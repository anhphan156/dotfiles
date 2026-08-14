local path = os.getenv("SNIPPETS")
local ls = require("luasnip")

-- Setup
ls.config.set_config {
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
}

-- Load snippets
if path then
  require("luasnip.loaders.from_lua").load({ paths = path })
else
  print("SNIPPETS variable not found!")
end

-- Keymaps
vim.keymap.set("i", "<C-h>", function() ls.jump(-1) end, { silent = true, desc = "Snippet jump next" })
vim.keymap.set("i", "<C-l>", function() ls.jump(1) end, { silent = true, desc = "Snippet jump prev" })
