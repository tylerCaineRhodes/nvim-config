return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", desc = "[F]ind recently opened [F]iles" },
      { "<leader>fg", desc = "[F]ind code via [G]rep" },
      { "<leader>fw", desc = "[F]ind [W]ord in project" },
      { "<leader>fo", desc = "[?] Find recently opened files" },
      { "<leader>fb", desc = "[B]uffers" },
      { "<leader>gt", desc = "Telescope git changes" },
      { "<leader>gc", desc = "Telescope git commits" },
      { "<leader>gb", desc = "Telescope git branches" },
      { "<leader>ma", desc = "Telescope marks" },
      { "<leader>fh", desc = "Telescope help_tags" },
      { "<leader>f/", desc = "[/] Fuzzily search in current buffer" },
    },
    init = function()
      local function lazy_load_builtin(fn)
        return function()
          require("lazy").load({ plugins = { "telescope.nvim" } })
          vim.schedule(function()
            require("telescope.builtin")[fn]()
          end)
        end
      end

      local themes = require("telescope.themes")

      vim.keymap.set("n", "<leader>ff", lazy_load_builtin("find_files"))
      vim.keymap.set("n", "<leader>fg", lazy_load_builtin("live_grep"))
      vim.keymap.set("n", "<leader>fw", lazy_load_builtin("grep_string"))
      vim.keymap.set("n", "<leader>fo", lazy_load_builtin("oldfiles"))
      vim.keymap.set("n", "<leader>fb", function()
        require("lazy").load({ plugins = { "telescope.nvim" } })
        vim.schedule(function()
          require("telescope.builtin").buffers({
            attach_mappings = function(_, map)
              map("i", "<C-d>", function(prompt_bufnr)
                local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                local multi_selection = picker:get_multi_selection()
                local current_selection = require("telescope.actions.state").get_selected_entry()
                local buffers_to_delete = {}

                if #multi_selection > 0 then
                  for _, selection in ipairs(multi_selection) do
                    table.insert(buffers_to_delete, selection.bufnr)
                  end
                else
                  table.insert(buffers_to_delete, current_selection.bufnr)
                end

                for _, bufnr in ipairs(buffers_to_delete) do
                  vim.api.nvim_buf_delete(bufnr, { force = true })
                end
                require("telescope.actions").close(prompt_bufnr)
              end)
              map("n", "<C-d>", function(prompt_bufnr)
                local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                local multi_selection = picker:get_multi_selection()
                local current_selection = require("telescope.actions.state").get_selected_entry()
                local buffers_to_delete = {}

                if #multi_selection > 0 then
                  for _, selection in ipairs(multi_selection) do
                    table.insert(buffers_to_delete, selection.bufnr)
                  end
                else
                  table.insert(buffers_to_delete, current_selection.bufnr)
                end

                for _, bufnr in ipairs(buffers_to_delete) do
                  vim.api.nvim_buf_delete(bufnr, { force = true })
                end
                require("telescope.actions").close(prompt_bufnr)
              end)
              return true
            end
          })
        end)
      end)
      vim.keymap.set("n", "<leader>gt", lazy_load_builtin("git_status"))
      vim.keymap.set("n", "<leader>gc", lazy_load_builtin("git_commits"))
      vim.keymap.set("n", "<leader>gb", lazy_load_builtin("git_branches"))
      vim.keymap.set("n", "<leader>ma", function()
        require("lazy").load({ plugins = { "telescope.nvim" } })
        vim.schedule(function()
          require("telescope.builtin").marks({
            attach_mappings = function(_, map)
              map("i", "<C-d>", function(prompt_bufnr)
                local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                local multi_selection = picker:get_multi_selection()
                local current_selection = require("telescope.actions.state").get_selected_entry()
                local marks_to_delete = {}

                if #multi_selection > 0 then
                  for _, selection in ipairs(multi_selection) do
                    table.insert(marks_to_delete, string.sub(selection.display, 1, 1))
                  end
                elseif current_selection then
                  table.insert(marks_to_delete, string.sub(current_selection.display, 1, 1))
                end

                if #marks_to_delete > 0 then
                  local marks_string = table.concat(marks_to_delete, "")
                  vim.cmd("delmarks " .. marks_string)
                  require("telescope.actions").close(prompt_bufnr)
                end
              end)

              map("n", "<C-d>", function(prompt_bufnr)
                local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                local multi_selection = picker:get_multi_selection()
                local current_selection = require("telescope.actions.state").get_selected_entry()
                local marks_to_delete = {}

                if #multi_selection > 0 then
                  for _, selection in ipairs(multi_selection) do
                    table.insert(marks_to_delete, string.sub(selection.display, 1, 1))
                  end
                elseif current_selection then
                  table.insert(marks_to_delete, string.sub(current_selection.display, 1, 1))
                end

                if #marks_to_delete > 0 then
                  local marks_string = table.concat(marks_to_delete, "")
                  vim.cmd("delmarks " .. marks_string)
                  require("telescope.actions").close(prompt_bufnr)
                end
              end)
              return true
            end
          })
        end)
      end)
      vim.keymap.set("n", "<leader>fh", lazy_load_builtin("help_tags"))
      vim.keymap.set("n", "<leader>f/", function()
        require("lazy").load({ plugins = { "telescope.nvim" } })
        vim.schedule(function()
          require("telescope.builtin").current_buffer_fuzzy_find(themes.get_dropdown({ previewer = false }))
        end)
      end)
    end,
    config = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        file_ignore_patterns = {
          "node_modules",
          "vendor",
          "%.git/",
          "%.cache/",
          "log/",
          "tmp/",
        },
        find_command = {
          "fd",
          "--type", "f",
          "--hidden",
          "--exclude", ".git",
          "--exclude", "node_modules",
          "--exclude", "vendor",
          "--exclude", ".cache",
          "--exclude", "log",
          "--exclude", "tmp",
        },
      })

      require("telescope").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = true,
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
            n = {
              ["<C-t>"] = require("telescope.actions").select_tab,
              ["<C-v>"] = require("telescope.actions").select_vertical,
            },
          },
        },
      })
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
