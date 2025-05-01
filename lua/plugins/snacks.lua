return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    input = { enabled = false },
    indent = { enabled = true },
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
    {
      "<leader>S",
      function()
        require('lazy').load({ plugins = { "telescope-ui-select.nvim" } })
        vim.schedule(function()
          Snacks.scratch.select()
        end
        )
      end,
      desc = "Select Scratch Buffer"
    },

    -- bd
    { "<leader>bd", function() Snacks.bufdelete() end,             desc = "Delete Buffer" },
    -- rename
    { "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
    -- notifications
    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
    -- indent guides
    { "<leader>ug", function() Snacks.indent.disable() end,        desc = "Disable indent guides" },
    { "<leader>uG", function() Snacks.indent.enable() end,         desc = "Enable indent guides" },
  }
}
