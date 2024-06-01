local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.api.nvim_set_keymap(
	"n",
	"<leader>fg",
	"<cmd>lua require('telescope.builtin').live_grep()<CR>",
	{ noremap = true, silent = true }
)

local opts = {}

require("vim-settings")
require("lazy").setup("plugins", opts)

