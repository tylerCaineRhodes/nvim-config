return {
  {
    "vim-test/vim-test",
    config = function()
      -- https://github.com/vim-test/vim-test?tab=readme-ov-file#strategies
      vim.g["test#strategy"] = "dispatch"

      vim.keymap.set('n', 't<C-n>', '<cmd>TestNearest<CR>', { desc = 'Test nearest' })
      vim.keymap.set('n', 't<C-f>', '<cmd>TestFile<CR>', { desc = 'Test file' })
      vim.keymap.set('n', 't<C-s>', '<cmd>TestSuite<CR>', { desc = 'Test suite' })
      vim.keymap.set('n', 't<C-l>', '<cmd>TestLast<CR>', { desc = 'Test last' })
      vim.keymap.set('n', 't<C-g>', '<cmd>TestVisit<CR>', { desc = 'Test visit' })
    end,
  },
}
