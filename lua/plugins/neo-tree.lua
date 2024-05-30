return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
	},
	config = function()
		vim.keymap.set("n", "\\", ":Neotree filesystem reveal left toggle<Enter>")

		require("neo-tree").setup({
			filesystem = {
				follow_current_file = true,
				use_libuv_file_watcher = true,
			},
		})
	end,
}
