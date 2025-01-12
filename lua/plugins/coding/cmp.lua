return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },

    config = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp")

      local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }

      -- Configure completion for search commands
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- Configure completion for command mode
      cmp.setup.cmdline(":", {
        completion = { completeopt = "menu,menuone,noselect" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })

      -- Main completion configuration
      cmp.setup({
        completion = { completeopt = "menu,menuone" },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "spell" },
          { name = "vim-dadbod-completion" },
        }),

        formatting = {
          fields = { "kind", "abbr", "menu" } or nil,
          format = function(entry, item)
            -- Format using lspkind with tailwindcss-colorizer support
            local fmt = lspkind.cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
              ellipsis_char = "...",
              before = tailwindcss_colorizer_cmp.formatter,
            })(entry, item)

            -- Split the kind string to separate icon and text
            local strings = vim.split(fmt.kind, "%s", { trimempty = true })

            -- Format the kind and menu
            fmt.kind = " " .. (kind_icons[strings[2]] or "")
            fmt.menu = strings[2] ~= nil and (strings[2] or "") or ""

            return fmt
          end,
        },

        experimental = {
          ghost_text = false,
        },
      })
    end,
  },

  {
    "hrsh7th/cmp-cmdline",
    keys = { ":", "/", "?" },
  },
}
