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
    picker = { enabled = true },
    notifier = {
      enabled = true,
      -- timeout = 3000,
    },
    notify = { enabled = true },
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
    { "<leader>uC", function() Snacks.picker.colorschemes() end,             desc = "Colorschemes" },
    -- rename
    { "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    -- notifications
    -- { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
    -- indent guides
    { "<leader>ug", function() Snacks.indent.disable() end,        desc = "Disable indent guides" },
    { "<leader>uG", function() Snacks.indent.enable() end,         desc = "Enable indent guides" },
  },
  config = function()
    vim.api.nvim_create_user_command("Pedantic", function()
      vim.opt.cursorline = true
      require("snacks").indent.enable()
    end, { nargs = 0, desc = "Add indent guides and cursorline" })

    vim.api.nvim_create_user_command("Simple", function()
      vim.opt.cursorline = false
      require("snacks").indent.disable()
    end, { nargs = 0, desc = "Remove indent guides and cursorline" })
  end,
}
