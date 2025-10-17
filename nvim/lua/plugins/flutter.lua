return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          settings = {
            dart = {
              lineLength = vim.opt.textwidth,
              showTodos = false,
              completeFunctionCalls = false,
              enableSnippets = false,
            },
          },
          on_attach = function(client, bufnr)
            require("config.shared").disable_inlay_hints(client, bufnr)
            -- Additional Dart-specific inlay hint disabling
            if client.name == "dartls" then
              vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end
          end,
        },
      })
    end,
  },
}
