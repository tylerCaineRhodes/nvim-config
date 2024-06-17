return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        -- other nice themes: base16, 16color, ayu_dark, codedark, iceberg_dark
        globalstatus = true,
      },
    })
  end,
}
