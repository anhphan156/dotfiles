-- Numberline
vim.wo.number = true
vim.wo.relativenumber = true

-- Indentation settings
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = false
vim.o.expandtab = false

-- Scrolling settings
vim.o.scrolloff = 8
vim.o.scl = "yes"

vim.opt.guicursor:append("t:ver25")
-- vim.opt.guicursor =
--     "r-v-c-sm:block," ..
--     "i-ci-ve:ver25," ..
--     "n-cr-o:hor20," ..
--     "t:block-blinkon500-blinkoff500-TermCursor"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Others
vim.opt.splitright = true
vim.opt.cursorline = true;

local root = vim.fs.root(0, { "meson.build" })
if root then
	vim.opt.makeprg = "meson compile -C " .. root .. "/build"
end
