return {
  -- Use LazyVim's Rust extras for base configuration
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- Override rustaceanvim with custom keybindings and clippy settings
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
        default_settings = {
          ["rust-analyzer"] = {
            -- Enable clippy with pedantic, nursery, and unwrap_used lints
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = {
                "--",
                "-Wclippy::pedantic",
                "-Wclippy::nursery",
                "-Wclippy::unwrap_used",
              },
            },
            -- Make rust-analyzer more resilient to dependency errors
            cargo = {
              -- Don't fail if build scripts fail
              buildScripts = {
                enable = true,
                overrideCommand = nil,
              },
              -- Only check the workspace members, not dependencies
              allTargets = false,
            },
            -- Don't load output directories from check, can cause issues with broken deps
            procMacro = {
              enable = true,
              ignored = {},
            },
          },
        },
      },
    },
  },
}
