return {
  "nvim-lualine/lualine.nvim",
  event = 'VeryLazy',
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        -- other nice themes: base16, 16color, ayu_dark, codedark, iceberg_dark
        globalstatus = true,
      },
      -- sections = {
      --   lualine_x = {
      --     {
      --       require("noice").api.statusline.mode.get,
      --       cond = require("noice").api.statusline.mode.has,
      --       color = { fg = "#ff9e64" },
      --     },
      --     {
      --       require("noice").api.status.command.get,
      --       cond = require("noice").api.status.command.has,
      --       color = { fg = "#ff9e64" },
      --     },
      --   },
      -- },
    })
  end,
}
