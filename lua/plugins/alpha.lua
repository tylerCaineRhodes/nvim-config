return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")
    dashboard.section.header.val = { "don't look at me" }
    alpha.setup(dashboard.opts)
  end,
}

