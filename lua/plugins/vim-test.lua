return {
  {
    "vim-test/vim-test",
    config = function()
      -- https://github.com/vim-test/vim-test?tab=readme-ov-file#strategies
      vim.g["test#strategy"] = "dispatch"

      vim.keymap.set('n', 't<C-n>', function()
        vim.cmd.TestNearest()
      end, { desc = 'Test nearest' })

      vim.keymap.set('n', 't<C-f>', function()
        vim.cmd.TestFile()
      end, { desc = 'Test file' })

      vim.keymap.set('n', 't<C-s>', function()
        vim.cmd.TestSuite()
      end, { desc = 'Test suite' })

      vim.keymap.set('n', 't<C-l>', function()
        vim.cmd.TestLast()
      end, { desc = 'Test last' })

      vim.keymap.set('n', 't<C-g>', function()
        vim.cmd.TestVisit()
      end, { desc = 'Test visit' })
    end,
  },
}
