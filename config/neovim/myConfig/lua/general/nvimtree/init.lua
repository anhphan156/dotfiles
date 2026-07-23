require('lz.n').load {
  {
    "nvim-tree.lua",
    cmd = "NvimTreeToggle",
    after = function()
      -- Setup
      require('nvim-tree').setup {
        update_focused_file = {
          enable = true,
        },
        filters = { custom = { "^.git$" } },
        renderer = {
          icons = {
            show = {
              file = true,         -- Show file icons
              folder = true,       -- Show folder icons
              folder_arrow = true, -- Show arrow for folders
              git = true,          -- Show git icons
            },
            glyphs = {
              symlink = "",
            },
          },
        },
      }

      -- Autoclose
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd "quit"
          end
        end
      })
    end
  }
}
--require("nvim-tree").setup
-- Colors
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#000000" })

-- Keymaps
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { silent = true, desc = "Open nvim tree" })
