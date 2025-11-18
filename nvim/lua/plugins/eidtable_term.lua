return {
  "xb-bx/editable-term.nvim",
  opts = {
    promts = {
      ["^ ' "] = {}, -- Your custom prompt ' '
      [" "] = {}, -- Your custom prompt ' '
      [""] = {}, -- Your custom prompt ' '
    },
    wait_for_keys_delay = 50, -- milliseconds to wait for shell processing
  },
}
