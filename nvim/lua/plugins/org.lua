return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- Setup orgmode
    require("orgmode").setup({
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    })
  end,
}
