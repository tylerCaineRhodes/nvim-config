return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind recently opened [F]iles" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind code via [G]rep" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind [W]ord in project" })
      vim.keymap.set("n", "<leader>f?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[B]uffers" })
      vim.keymap.set("n", "<leader>f/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = true,
        }))
      end, { desc = "[/] Fuzzily search in current buffer]" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = require("telescope.actions").move_selection_next,
              ["<C-p>"] = require("telescope.actions").move_selection_previous,
              ["<C-c>"] = require("telescope.actions").close,
            },
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
