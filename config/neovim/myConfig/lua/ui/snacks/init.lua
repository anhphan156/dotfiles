require('snacks').setup {
  animate = {
    enabled = vim.fn.has("nvim-0.10") == 1,
    style = "out",
    easing = "linear",
    duration = {
      step = 20,   -- ms per step
      total = 500, -- maximum duration
    },
  },
  indent = {
    enabled = true,
  },
  scroll = {}
}
