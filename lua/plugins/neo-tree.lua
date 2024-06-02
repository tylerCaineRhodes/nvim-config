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
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
					["l"] = "focus_preview",
					["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
					["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
				},
			},
		})
	end,
}
