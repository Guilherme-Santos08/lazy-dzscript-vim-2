return {
  "rcarriga/nvim-notify",
  opts = {
    timeout = 10000,
    render = "minimal",
    stages = "static",
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
}
