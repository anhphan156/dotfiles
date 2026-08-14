require('lz.n').load {
  {
    "leetcode.nvim",
    cmd = "Leet",
    after = function()
      require('leetcode').setup {
        arg = "leetcode.nvim",
        lang = "cpp",
      }
      vim.keymap.set("n", "<leader>lr", ":Leet run<CR>", {
        noremap = true,
        silent = true,
      })
      vim.keymap.set("n", "<leader>ls", ":Leet submit<CR>", {
        noremap = true,
        silent = true,
      })
    end
  }
}
