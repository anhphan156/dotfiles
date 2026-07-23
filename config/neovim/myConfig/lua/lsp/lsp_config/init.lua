local lspformat = require('lsp-format')

lspformat.setup {}

vim.lsp.config('lua_ls', {
	on_attach = lspformat.on_attach
})
vim.lsp.enable('lua_ls')

vim.lsp.config('clangd', {
	on_attach = lspformat.on_attach
})
vim.lsp.enable('clangd')

vim.lsp.config('eslint', {
	on_attach = lspformat.on_attach
})
vim.lsp.enable('eslint')

vim.lsp.config('glsl_analyzer', {
	on_attach = lspformat.on_attach
})
vim.lsp.enable('glsl_analyzer')

vim.lsp.config('hls', {
	on_attach = lspformat.on_attach
})
vim.lsp.enable('hls')

vim.lsp.config('nixd', {
	cmd = { "nixd" },
})
vim.lsp.enable('nixd')

vim.lsp.config('rust_analyzer', {
	on_attach = lspformat.on_attach,
	settings = {
		["rust-analyzer"] = {
			-- diagnostics = {
			--   enable = true,
			--   disabled = { "unresolved-proc-macro" },
			--   enableExperimental = true,
			-- },
			-- cargo = {
			--   buildScripts = {
			--     enable = true,
			--   },
			-- },
			-- procMacro = {
			--   enable = true,
			-- },
		}
	}
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('omnisharp', {
	filetypes = { "cs", "c_sharp" },
})
vim.lsp.enable('omnisharp')

vim.diagnostic.config({
	virtual_text = true, -- This enables virtual text
})
