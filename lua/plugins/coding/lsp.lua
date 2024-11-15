return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "luacheck",
        "shellcheck",
        "shfmt",
        "prettierd",
        "eslint_d",
        "tailwindcss-language-server",
        "typescript-language-server",
      })
    end,
  },
}
