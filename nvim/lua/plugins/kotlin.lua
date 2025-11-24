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
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "kotlin-language-server" },
    },
  },
}
