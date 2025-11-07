return {
  -- Disable snippet plugins
  {
    "garymjr/nvim-snippets",
    enabled = false,
  },
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  {
    "L3MON4D3/LuaSnip",
    enabled = false,
  },

  -- Setup cmp with LSP-only sources
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Override sources to only use LSP
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
      })

      -- Simple tab navigation through completion menu
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      })
    end,
  },
}
