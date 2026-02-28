-- Remove LazyVim codelens keybindings so <leader>cc is always compile mode
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    vim.defer_fn(function()
      pcall(vim.keymap.del, "n", "<leader>cc", { buffer = bufnr })
      pcall(vim.keymap.del, "x", "<leader>cc", { buffer = bufnr })
      pcall(vim.keymap.del, "n", "<leader>cC", { buffer = bufnr })
    end, 0)
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local highlights = {
      "Normal",
      "LineNr",
      "Folded",
      "NonText",
      "SpecialKey",
      "VertSplit",
      "SignColumn",
      "EndOfBuffer",
      "TablineFill",
    }
    for _, name in pairs(highlights) do
      vim.cmd.highlight(name .. " guibg=none ctermbg=none")
    end
  end,
})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
