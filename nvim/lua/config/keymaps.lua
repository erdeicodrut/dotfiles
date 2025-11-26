-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })

vim.keymap.set("n", "C-w", "<leader>bd", { desc = "Delete buffer" })

vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.api.nvim_set_keymap("n", "U", "<C-r>", { noremap = true })

-- Restore Vim's default macro recording with the `q` key.
-- LazyVim maps `q` to close the current window by default, which prevents
-- using it to start/stop macro recording. Remove that mapping so that the
-- built-in behaviour works again.

pcall(vim.keymap.del, "n", "q")

-- Delete LazyVim's default quit mappings
pcall(vim.keymap.del, "n", "<leader>qq")

-- Navigation shortcuts for quickfix, diagnostics, and git hunks
vim.keymap.set("n", "<leader>q", "<cmd>cnext<CR>zz", { desc = "Next Quickfix" })
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.goto_next()
end, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>h", function()
  if vim.fn.exists(":Gitsigns") == 2 then
    vim.cmd("Gitsigns next_hunk")
  end
end, { desc = "Next Git Hunk" })

-- Toggle diagnostic virtual text
local virtual_text_enabled = true
vim.keymap.set("n", "<leader>hw", function()
  virtual_text_enabled = not virtual_text_enabled
  vim.diagnostic.config({ virtual_text = virtual_text_enabled })
  local status = virtual_text_enabled and "shown" or "hidden"
  vim.notify("Diagnostic virtual text " .. status, vim.log.levels.INFO)
end, { desc = "Toggle Warnings" })

-- Tab navigation
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>p", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })

-- Jump to specific tabs by number
for i = 1, 9 do
  vim.keymap.set("n", "<leader><tab>" .. i, "<cmd>tabnext " .. i .. "<CR>", { desc = "Go to Tab " .. i })
end
