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

-- Local config
vim.o.exrc = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"
