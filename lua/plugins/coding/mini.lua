return {
  {
    "echasnovski/mini-git",
    version = false,
    main = "mini.git",
    keys = {
      { "<leader>gA", "<cmd>Git add %<cr>" },
      { "<leader>gc", "<cmd>Git commit<cr>" },
      { "<leader>gC", "<cmd>Git commit -a<cr>" },
      { "<leader>gd", "<cmd>vert Git diff %<cr>" },
      { "<leader>gD", "<cmd>vert Git diff<cr>" },
      { "<leader>gl", "<cmd>vert Git log<cr>" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>" },
      { "<leader>gp", "<cmd>Git push origin main<cr>" },
      { "<leader>gP", ":Git push origin " },
      { "<leader>gg", ":Git " },
    },
    opts = {},
  },
  {
    "echasnovski/mini.diff",
    version = false,
    opts = {
      mappings = {
        apply = "<leader>ga",
        reset = "<leader>gr",
        goto_next = "<leader>gn",
        goto_prev = "<leader>gp",
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    version = false,
    opts = {
      silent = true,
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "┋",
    },
  },
  {
    "echasnovski/mini.comment",
    version = false,
  },
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup({
        mappings = {
          ["<"] = {
            action = "closeopen",
            pair = "<>",
            neigh_pattern = "[^\\].",
            register = { cr = false },
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup({
        icons = {
          lsp = {
            ["function"] = { glyph = "󰡱", hl = "MiniIconsCyan" },
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
}
