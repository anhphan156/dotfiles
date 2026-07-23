local telescope = require('telescope')

telescope.setup {
  defaults = {
    cwd = vim.fn.getcwd(), -- Set the current directory to the root of your project
    mappings = {
      i = {
        ["<Esc>"] = require('telescope.actions').close,
      },
    },
    file_ignore_patterns = {
      "node_modules"
    }
  },
}

-- Keymaps
vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { silent = true, desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fr", ":Telescope lsp_references<CR>", { silent = true, desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { silent = true, desc = "Telescope find files" })

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true, desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find<CR>",
  { silent = true, desc = "Telescope find files" })
