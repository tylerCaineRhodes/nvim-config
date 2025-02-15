return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")

      telescope.setup(opts)

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind recently opened [F]iles" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind code via [G]rep" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind [W]ord in project" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[?] Find recently opened files" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[B]uffers" })
      vim.keymap.set("n", "<leader>gt", builtin.git_status, { desc = "Telescope git changes" })
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Telescope git commits" })
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git branches" })
      vim.keymap.set("n", "<leader>ma", builtin.marks, { desc = "Telescope marks" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help_tags" })
      vim.keymap.set("n", "<leader>f/", function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown({
          previewer = false,
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
          winblend = 10,
          mappings = {
            i = {
              ["<C-n>"] = require("telescope.actions").move_selection_next,
              ["<C-p>"] = require("telescope.actions").move_selection_previous,
              ["<C-c>"] = require("telescope.actions").close,
            },
            n = { -- Normal mode mappings
              ["<C-t>"] = require("telescope.actions").select_tab,        -- Open selection in a new tab
              ["<C-v>"] = require("telescope.actions").select_vertical,   -- Open selection in a vertical split
            },
          },
        },
      })
      -- Set line numbers for the preview window
      vim.api.nvim_set_hl(0, 'TelescopePreviewLine', { link = 'CursorLine' })
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function()
          vim.opt.number = true
        end,
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
