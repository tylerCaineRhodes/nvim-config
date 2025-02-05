return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
    vim.keymap.set("v", "<leader>k", ":ChatGPTEditWithInstructions<CR>", {})
    vim.keymap.set({ "n", "v" }, "<leader>l", ":ChatGPT<CR>", {})
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
