return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
    -- cursor-like
    vim.keymap.set("v", "<leader>k", ":ChatGPTEditWithInstructions<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>l", ":ChatGPT<CR>", {})

    vim.keymap.set({ "n", "v" }, "<leader>cg", ":ChatGPTRun grammar_correction<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>ct", ":ChatGPTRun translate<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>ck", ":ChatGPTRun keywords<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>cc", ":ChatGPTRun docstring<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>ca", ":ChatGPTRun add_tests<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>co", ":ChatGPTRun optimize_code<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>cs", ":ChatGPTRun summarize<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>cb", ":ChatGPTRun fix_bugs<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>cx", ":ChatGPTRun explain_code<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>cl", ":ChatGPTRun code_readability_analysis<CR>", {})
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
