return {
  "ej-shafran/compile-mode.nvim",
  version = "^5.0.0",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>mc",
      "<cmd>Compile<cr>",
      desc = "Compile",
    },
    {
      "<leader>mr",
      "<cmd>Recompile<cr>",
      desc = "Recompile",
    },
  },
  config = function()
    vim.g.compile_mode = {
      -- Enable improved tab completion in command mode
      input_word_completion = true,
      -- Enable bang expansion for :Compile command
      bang_expansion = true,
    }
  end,
}
