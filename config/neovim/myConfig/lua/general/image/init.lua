local pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }
require('lz.n').load {
  {
    "image.nvim",
    event = {
      event = { "BufEnter" },
      pattern = pattern
    },
    after = function()
      require("image").setup({
        backend = "kitty",
        processor = "magick_rock",
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        hijack_file_patterns = pattern,          -- render image files as images when opened
      })
    end
  },
}
