return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				-- other nice themes: base16, 16color, ayu_dark, codedark, iceberg_dark, catppuccin
				globalstatus = true,
			},
		})
	end,
}
