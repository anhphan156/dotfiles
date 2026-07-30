-- Leader remap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General keymaps
vim.keymap.set("n", "<leader>w", "<ESC>:w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("n", "Y", "<ESC>Vy", { silent = true, desc = "Copy line" })

-- Quote wrapping keymaps
-- Quotes
vim.keymap.set("v", "<leader>'", "<ESC>`>a'<ESC>`<i'<ESC>", { silent = true, desc = "wrap single quote" })
vim.keymap.set("v", "<leader>\"", "<ESC>`>a\"<ESC>`<i\"<ESC>", { silent = true, desc = "wrap double quote" })

-- Escape quotes
vim.keymap.set("v", "<leader><leader>'", "<ESC>`>a\\'<ESC>`<i\\'<ESC>",
	{ silent = true, desc = "wrap escape single quote" })
vim.keymap.set("v", "<leader><leader>\"", "<ESC>`>a\\\"<ESC>`<i\\\"<ESC>",
	{ silent = true, desc = "wrap escape double quote" })

-- Brackets
vim.keymap.set("v", "<leader>(", "<ESC>`>a)<ESC>`<i(<ESC>", { silent = true, desc = "wrap parenthese" })
vim.keymap.set("v", "<leader>[", "<ESC>`>a]<ESC>`<i[<ESC>", { silent = true, desc = "wrap square backet" })
vim.keymap.set("v", "<leader>{", "<ESC>`>a}<ESC>`<i{<ESC>", { silent = true, desc = "wrap curly backet" })

-- Escape brackets
vim.keymap.set("v", "<leader><leader>(", "<ESC>`>a\\)<ESC>`<i\\(<ESC>",
	{ silent = true, desc = "wrap escape parenthese" })

-- Others
vim.keymap.set("v", "<leader>`", "<ESC>`>a`<ESC>`<i`<ESC>", { silent = true, desc = "wrap backtick" })
vim.keymap.set("v", "<leader><", "<ESC>`>a><ESC>`<i<<ESC>", { silent = true, desc = "wrap triangle" })

-- Telescope
vim.keymap.set("n", "<leader>fs", ":Telescope lsp_dynamic_workspace_symbols<CR>",
	{ silent = true, desc = "Telescope search symbols" })
vim.keymap.set("n", "<leader>fr", ":Telescope lsp_references<CR>",
	{ silent = true, desc = "Telescope search references" })
vim.keymap.set("n", "<leader>fd", ":Telescope lsp_definitions<CR>",
	{ silent = true, desc = "Telescope search definitions" })

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true, desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find<CR>",
	{ silent = true, desc = "Telescope buffer fuzzy finder" })

vim.keymap.set("n", "<leader>xd", ":Telescope file_browser<CR>", { silent = true, desc = "Telescope file browser" })
vim.keymap.set("n", "<leader>pp", ":Telescope project<CR>", { silent = true, desc = "Telescope project browser" })

-- Nvimtree
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { silent = true, desc = "Open nvim tree" })

-- Neogit
vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { silent = true, desc = "Open Neogit" })


-- lsp saga
vim.keymap.set("n", "<leader>sh", ":Lspsaga hover_doc<CR>", { silent = true, desc = "Hover doc" })
vim.keymap.set("n", "<leader>sa", ":Lspsaga code_action<CR>", { silent = true, desc = "code action" })
vim.keymap.set("n", "<leader>sd", ":Lspsaga peek_definition<CR>", { silent = true, desc = "peek definition" })
vim.keymap.set("n", "<leader>sr", ":Lspsaga rename<CR>", { silent = true, desc = "rename" })
