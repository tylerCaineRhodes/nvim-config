return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    input = { enabled = false },
    indent = { enabled = false },
    words = { enabled = false },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    scratch = { enabled = true },
  },
  keys = {
    --scratch
    { "<leader>.",  function() Snacks.scratch() end,               desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,        desc = "Select Scratch Buffer" },

    -- bd
    { "<leader>bd", function() Snacks.bufdelete() end,             desc = "Delete Buffer" },
    -- rename
    { "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
    -- notifications
    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
  }
}
