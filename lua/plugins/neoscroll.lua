return {
  "karb94/neoscroll.nvim",
  config = function()
    vim.g.smoothscroll = vim.g.smoothscroll or false
    if vim.g.smoothscroll then
      require("neoscroll").setup({})
    end
  end,
}
