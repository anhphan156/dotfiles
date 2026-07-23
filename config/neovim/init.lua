-- Numberline
vim.wo.number = true
vim.wo.relativenumber = true

-- Indentation settings
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = false
vim.o.expandtab = false

-- Scrolling settings
vim.o.scrolloff = 8 -- Keep 8 lines above and below the cursor while scrolling
vim.o.scl = "yes"   -- Scroll behavior (optional, depends on use case)

-- vim.opt.guicursor =
--     "r-v-c-sm:block," ..
--     "i-ci-ve:ver25," ..
--     "n-cr-o:hor20," ..
--     "t:block-blinkon500-blinkoff500-TermCursor"

-- Autocmd
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.nix",
	callback = function()
		local cursor = vim.api.nvim_win_get_cursor(0) -- Get the current cursor position
		vim.cmd('silent %!alejandra -qq')             -- Run the Alejandra formatter
		vim.api.nvim_win_set_cursor(0, cursor)        -- Restore the cursor position
	end,
})

-- Load config.lua locally
local cwd = vim.fn.getcwd()
local project_config = cwd .. "/config.lua"

if vim.fn.filereadable(project_config) == 1 then
	dofile(project_config)
end

-- Clipboard
vim.opt.clipboard = "unnamedplus"
