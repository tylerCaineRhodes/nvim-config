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

-- set working directory to what was passed in as an argument to nvim
local function set_initial_cwd()
  local arg_dir = vim.fn.expand("%:p:h")
  if arg_dir ~= "" then
    vim.cmd("lcd " .. arg_dir)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = set_initial_cwd,
})

-- setting a default macro on @p
vim.api.nvim_command('command! ReplaceWordRepeatable execute "normal! ciw<C-r>0"')
vim.api.nvim_set_keymap("n", "@p", ":ReplaceWordRepeatable<CR>", { noremap = true, silent = true })

local opts = {}

require("vim-settings")
require("lazy").setup("plugins", opts)
