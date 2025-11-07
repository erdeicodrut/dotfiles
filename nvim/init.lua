-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Jumplist filtering - prevent pollution from small movements
local function filter_jumplist()
  -- Commands that shouldn't add to jumplist
  local filtered_commands = {
    "{",
    "}", -- paragraph movements
    "f",
    "F",
    "t",
    "T", -- find char movements
    "%", -- matching bracket
    "*",
    "#", -- word search
    "n",
    "N", -- search next/prev
    "H",
    "M",
    "L", -- screen positions
  }

  -- Override these commands to not add jumplist entries
  for _, cmd in ipairs(filtered_commands) do
    if cmd == "%" then
      -- Special handling for % to preserve its bracket matching functionality
      vim.keymap.set("n", cmd, function()
        vim.cmd("keepjumps normal! " .. cmd)
      end, { noremap = true, silent = true })
    else
      vim.keymap.set("n", cmd, function()
        vim.cmd("keepjumps normal! " .. vim.v.count1 .. cmd)
      end, { noremap = true, silent = true })
    end
  end
end

-- Call the function to set up the filtering
filter_jumplist()

-- Disable cursor movement on mouse scroll
vim.keymap.set("", "<ScrollWheelUp>", "<C-Y>", { noremap = true, silent = true })
vim.keymap.set("", "<ScrollWheelDown>", "<C-E>", { noremap = true, silent = true })
