return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local languages = {
        "lua", "javascript", "ruby", "python", "elixir", "erlang",
        "html", "vim", "vimdoc", "dockerfile", "css", "scss", "bash",
        "git_config", "git_rebase", "gitattributes", "gitignore", "gitcommit",
        "graphql", "json", "java", "regex", "sql", "typescript", "tsx",
        "yaml", "tmux", "markdown", "markdown_inline", "c", "cpp", "rust", "go",
      }

      require("nvim-treesitter").install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local ft = vim.bo.filetype

          if not vim.tbl_contains(languages, ft) then
            return
          end

          if ft ~= "" then
            require("nvim-treesitter").install(ft)
          end
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldlevelstart = 99
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = { lookahead = true },
        move = { set_jumps = true },
      }

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      local select_maps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ii'] = '@conditional.inner',
        ['ai'] = '@conditional.outer',
        ['il'] = '@loop.inner',
        ['al'] = '@loop.outer',
        ['at'] = '@comment.outer',
      }
      for key, query in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(query, "textobjects")
        end)
      end

      vim.keymap.set("n", "<leader>a", function() swap.swap_next("@parameter.inner") end)
      vim.keymap.set("n", "<leader>A", function() swap.swap_previous("@parameter.inner") end)

      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer") end)
      vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer") end)
      vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer") end)
      vim.keymap.set({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer") end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer") end)
      vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer") end)
      vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer") end)
      vim.keymap.set({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer") end)
    end,
  },
}
