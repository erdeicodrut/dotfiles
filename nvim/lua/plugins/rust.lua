return {
  -- Use LazyVim's Rust extras for base configuration
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- Override rustaceanvim with custom keybindings
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        on_attach = function(_, bufnr)
          -- Additional useful Rust keybindings
          vim.keymap.set("n", "<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, { desc = "Rust Runnables", buffer = bufnr })

          vim.keymap.set("n", "<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, { desc = "Rust Testables", buffer = bufnr })

          vim.keymap.set("n", "<leader>re", function()
            vim.cmd.RustLsp("explainError")
          end, { desc = "Explain Error", buffer = bufnr })

          vim.keymap.set("n", "<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, { desc = "Open Cargo.toml", buffer = bufnr })

          vim.keymap.set("n", "<leader>rp", function()
            vim.cmd.RustLsp("parentModule")
          end, { desc = "Parent Module", buffer = bufnr })

          vim.keymap.set("n", "<leader>rm", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Expand Macro", buffer = bufnr })
        end,
      },
    },
  },
}
