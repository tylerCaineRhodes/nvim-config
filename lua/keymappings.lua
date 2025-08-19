-- set relative numbers
vim.keymap.set({ "n", "v" }, "<leader>5", ":set number relativenumber<CR>", {})

-- set absolute numbers
vim.keymap.set({ "n", "v" }, "<leader>6", ":set number norelativenumber<CR>", {})

-- set both absolute and relative numbers
vim.keymap.set({ "n", "v" }, "<leader>7", ":RN<CR>", {})

-- Map yanked to clipboard
vim.keymap.set("v", "<C-c>", '"*y', {})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})

vim.keymap.set("n", "<leader>cf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg("+", filepath)
  print("Copied full path to clipboard: " .. filepath)
end, { desc = "Copy full file path to clipboard" })

vim.keymap.set("n", "<leader>cd", function()
  local dirname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
  vim.fn.setreg("+", dirname)
  print("Copied directory path to clipboard: " .. dirname)
end, { desc = "Copy directory path to clipboard" })

-- vimux open pane
vim.keymap.set("n", "<leader>t", function()
  vim.fn.VimuxOpenRunner()
end, { silent = true })

-- vimux close pane

vim.keymap.set("n", "<leader>T", function()
  vim.fn.VimuxCloseRunner()
end, { silent = true })
