return {
  -- Kotlin LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {},
      },
    },
  },

  -- Ensure mason installs kotlin-language-server
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "kotlin-language-server" },
    },
  },
}
