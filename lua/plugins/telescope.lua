return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 10,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {},
      },
    },
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
