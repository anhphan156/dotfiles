vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.o.expandtab = true

vim.keymap.set("n", "<leader>cc", "<CMD>! tmux send-keys -t :.+1 \" nix build\" Enter<CR>", {
	noremap = true,
	silent = true,
	buffer = true,
})

vim.keymap.set("n", "<leader>cr", "<CMD>! tmux send-keys -t :.+1 \" nix run\" Enter<CR>", {
	noremap = true,
	silent = true,
	buffer = true,
})
