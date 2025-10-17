-- Shared configuration utilities
local M = {}

-- Common function to disable inlay hints
M.disable_inlay_hints = function(client, bufnr)
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end
end

-- Common treesitter parsers
M.common_parsers = {
  "bash",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

-- Common Mason tools
M.common_tools = {
  "stylua",
  "shellcheck",
  "shfmt",
  "flake8",
}

return M