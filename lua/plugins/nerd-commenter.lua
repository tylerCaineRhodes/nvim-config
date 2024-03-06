return {
	"preservim/nerdcommenter",
	config = function()
		vim.cmd("let g:NERDCompactSexyComs = 1")
		vim.cmd("let g:NERDCommentEmptyLines = 1")
		vim.cmd("let g:NERDTrimTrailingWhitespace = 1")
		vim.cmd("let g:NERDToggleCheckAllLines = 1")
		vim.cmd("let g:NERDSpaceDelims = 1")

		vim.cmd("nmap <leader>/ <plug>NERDCommenterToggle")
		vim.cmd("vmap <leader>/ <plug>NERDCommenterToggle")
	end,
}
