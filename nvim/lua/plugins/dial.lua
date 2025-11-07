return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>", function() require("dial.map").inc_normal() end, desc = "Increment" },
    { "<C-x>", function() require("dial.map").dec_normal() end, desc = "Decrement" },
    { "<C-a>", function() require("dial.map").inc_visual() end, mode = "v", desc = "Increment" },
    { "<C-x>", function() require("dial.map").dec_visual() end, mode = "v", desc = "Decrement" },
    { "g<C-a>", function() require("dial.map").inc_gvisual() end, mode = "v", desc = "Increment (sequence)" },
    { "g<C-x>", function() require("dial.map").dec_gvisual() end, mode = "v", desc = "Decrement (sequence)" },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d/%Y"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.constant.new({
          elements = { "true", "false" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "yes", "no" },
          word = true,
          cyclic = true,
        }),
      },
    })
  end,
}
