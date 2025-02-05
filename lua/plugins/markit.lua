return {
  '2kabhishek/markit.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('marks').setup({
      default_mappings = true,
      -- builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = false,
      sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
      excluded_filetypes = {},
      excluded_buftypes = {},
      bookmark_0 = {
        sign = " ",
        virt_text = "follow the banana",
        annotate = false,
      },
      bookmark_1 = {
        sign = "🍌",
        virt_text = "also a banana",
        annotate = false,
      },
    })

    vim.keymap.set("n", "<leader>mf", ":MarksQFListBuf<CR>", {})
    vim.keymap.set("n", "<leader>mc", ":MarksQFListGlobal<CR>", {})
    vim.keymap.set("n", "<leader>mq", ":MarksQFListAll<CR>", {})
    vim.keymap.set("n", "<leader>mt", ":MarksToggleSigns<CR>", {})
  end,
}

