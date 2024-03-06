return {
  {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },

    config = function()
      vim.g["test#neovim#start_normal"] = 1
      vim.g["test#strategy"] = "vimux"

      vim.cmd("let test#strategy = 'vimux'")

      vim.keymap.set("n", "<leader>tt", "<cmd>TestNearest<CR>", { desc = "Test nearest" })
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>", { desc = "Test last" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>", { desc = "Test file" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<CR>", { desc = "Test suite" })
    end,
  },
}
