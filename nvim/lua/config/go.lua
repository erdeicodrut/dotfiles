-- Go-specific configuration
local M = {}

M.mason_tools = {
  "goimports",
  "gofumpt",
  "gomodifytags",
  "impl",
  "delve",
}

M.treesitter_parsers = {
  "go",
  "gomod",
  "gowork",
  "gosum",
}

return M

