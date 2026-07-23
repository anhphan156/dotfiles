require('lspsaga').setup({
  rename = {
    auto_save = true
  }
})

-- Keymaps
vim.keymap.set("n", "<leader>sh", ":Lspsaga hover_doc<CR>", { silent = true, desc = "Hover doc" })
vim.keymap.set("n", "<leader>sa", ":Lspsaga code_action<CR>", { silent = true, desc = "code action" })
vim.keymap.set("n", "<leader>sd", ":Lspsaga peek_definition<CR>", { silent = true, desc = "peek definition" })
vim.keymap.set("n", "<leader>sr", ":Lspsaga rename<CR>", { silent = true, desc = "rename" })
