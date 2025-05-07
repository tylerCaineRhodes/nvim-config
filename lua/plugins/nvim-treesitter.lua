return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true, -- install automatically when it encounters a new language
        ensure_installed = {
          "lua",
          "javascript",
          "ruby",
          "python",
          "elixir",
          "erlang",
          "html",
          "vim",
          "vimdoc",
          "dockerfile",
          "css",
          "scss",
          "bash",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitignore",
          "gitcommit",
          "graphql",
          "json",
          "java",
          "regex",
          "sql",
          "typescript",
          "tsx",
          "yaml",
          "tmux",
          "markdown",
          "markdown_inline",
          "c",
          "cpp",
          "rust",
          "go",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "v",
            node_decremental = "V",
            scope_incremental = "grc",
          },
        },
        highlight = { enable = true },
        indent = { enable = true },
        fold = { enable = true },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
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
            },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>a"] = "@parameter.inner" },
            swap_previous = { ["<leader>A"] = "@parameter.inner" },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        }
      })
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldlevelstart = 99
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    config = function()
      local opts = require("nvim-treesitter.configs").get_module("textobjects")
      require("nvim-treesitter.configs").setup({ textobjects = opts })

      local move = require("nvim-treesitter.textobjects.move")
      local configs = require("nvim-treesitter.configs")

      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name]
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  }
}
