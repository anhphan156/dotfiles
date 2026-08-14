-- General keymaps
vim.keymap.set("n", "<space>w", "<ESC>:w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("n", "Y", "<ESC>Vy", { silent = true, desc = "Copy line" })

vim.keymap.set("n", "<space>bn", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<space>bp", "<cmd>bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<space>bd", "<cmd>bd<CR>", { silent = true, desc = "Delete buffer" })

-- Quote wrapping keymaps
-- Quotes
vim.keymap.set("v", "<space>'", "<ESC>`>a'<ESC>`<i'<ESC>", { silent = true, desc = "wrap single quote" })
vim.keymap.set("v", "<space>\"", "<ESC>`>a\"<ESC>`<i\"<ESC>", { silent = true, desc = "wrap double quote" })

-- Escape quotes
vim.keymap.set("v", "<space><space>'", "<ESC>`>a\\'<ESC>`<i\\'<ESC>",
	{ silent = true, desc = "wrap escape single quote" })
vim.keymap.set("v", "<space><space>\"", "<ESC>`>a\\\"<ESC>`<i\\\"<ESC>",
	{ silent = true, desc = "wrap escape double quote" })

-- Brackets
vim.keymap.set("v", "<space>(", "<ESC>`>a)<ESC>`<i(<ESC>", { silent = true, desc = "wrap parenthese" })
vim.keymap.set("v", "<space>[", "<ESC>`>a]<ESC>`<i[<ESC>", { silent = true, desc = "wrap square backet" })
vim.keymap.set("v", "<space>{", "<ESC>`>a}<ESC>`<i{<ESC>", { silent = true, desc = "wrap curly backet" })

-- Escape brackets
vim.keymap.set("v", "<space><space>(", "<ESC>`>a\\)<ESC>`<i\\(<ESC>",
	{ silent = true, desc = "wrap escape parenthese" })

-- Others
vim.keymap.set("v", "<space>`", "<ESC>`>a`<ESC>`<i`<ESC>", { silent = true, desc = "wrap backtick" })
vim.keymap.set("v", "<space><", "<ESC>`>a><ESC>`<i<<ESC>", { silent = true, desc = "wrap triangle" })

-- Telescope
vim.keymap.set("n", "<space>fs", ":Telescope lsp_dynamic_workspace_symbols<CR>",
	{ silent = true, desc = "Telescope search symbols" })
vim.keymap.set("n", "<space>fr", ":Telescope lsp_references<CR>",
	{ silent = true, desc = "Telescope search references" })
vim.keymap.set("n", "<space>fd", ":Telescope lsp_definitions<CR>",
	{ silent = true, desc = "Telescope search definitions" })

vim.keymap.set("n", "<space>ff", ":Telescope find_files<CR>", { silent = true, desc = "Telescope find files" })
vim.keymap.set("n", "<space>fg", ":Telescope live_grep<CR>", { silent = true, desc = "Telescope live grep" })
vim.keymap.set("n", "<space>fb", ":Telescope current_buffer_fuzzy_find<CR>",
	{ silent = true, desc = "Telescope buffer fuzzy finder" })

vim.keymap.set("n", "<space>bi", ":Telescope buffers<CR>", { silent = true, desc = "Telescope buffers browser" })
vim.keymap.set("n", "<space>xd", ":Telescope file_browser<CR>", { silent = true, desc = "Telescope file browser" })
vim.keymap.set("n", "<space>pp", ":Telescope project<CR>", { silent = true, desc = "Telescope project browser" })

vim.keymap.set("n", "<space>fp", ":Telescope registers<CR>", { silent = true, desc = "Telescope registers" })

-- Nvimtree
vim.keymap.set('n', '<space>t', ':NvimTreeToggle<CR>', { silent = true, desc = "Open nvim tree" })

-- Neogit
vim.keymap.set("n", "<space>gg", ":Neogit<CR>", { silent = true, desc = "Open Neogit" })

-- lsp saga
vim.keymap.set("n", "<space>sh", ":Lspsaga hover_doc<CR>", { silent = true, desc = "Hover doc" })
vim.keymap.set("n", "<space>sa", ":Lspsaga code_action<CR>", { silent = true, desc = "code action" })
vim.keymap.set("n", "<space>sd", ":Lspsaga peek_definition<CR>", { silent = true, desc = "peek definition" })
vim.keymap.set("n", "<space>sr", ":Lspsaga rename<CR>", { silent = true, desc = "rename" })

-- quickfix
vim.keymap.set("n", "<space>cc", ":silent make!<CR>", { silent = true, desc = "make" })
vim.keymap.set("n", "<space>co", function()
	local qf = vim.fn.getqflist({ winid = 0 }).winid
	if qf ~= 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { silent = true, desc = "ctoggle" })

-- Terminal
vim.keymap.set("n", "<space>rr", "<cmd>term<CR>", { silent = true, desc = "Terminal normal mode" })
vim.keymap.set("n", "<space>rt", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end, { silent = true, desc = "Open terminal" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { silent = true, desc = "Terminal normal mode in new window" })
