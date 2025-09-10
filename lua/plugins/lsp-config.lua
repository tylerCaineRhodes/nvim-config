return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = { "mason.nvim" },
    event = "BufReadPre",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "jedi_language_server",
          "pylsp",
          "elixirls",
          "ruby_lsp",
          "terraformls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- for capabilities
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local servers = {
        lua_ls = {},
        ts_ls = {
          filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        },
        html = {},
        jedi_language_server = {},
        pylsp = {},
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") }
        },
        terraformls = {
          filetypes = { "terraform", "tf", "tfvars" },
      },
        elixirls = {
          filetypes = { "elixir", "eelixir" },
        },
        proto_ls = {
          filetypes = { "proto" },
        }
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),

        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", 'gd', require('telescope.builtin').lsp_definitions,
            vim.tbl_extend("force", opts, { desc = '[G]oto [D]efinition' }))


          vim.keymap.set({ "n", "v" }, "<leader>ca", function()
            require("lazy").load({ plugins = { "telescope-ui-select.nvim" } })
            vim.schedule(function()
              vim.lsp.buf.code_action()
            end)
          end, opts, { desc = "[C]ode [A]ction" })

          vim.keymap.set("n", "gr", vim.lsp.buf.references,
            vim.tbl_extend("force", opts, { desc = "LSP References" }))

          vim.keymap.set("n", "<leader>gr", function()
            require("telescope.builtin").grep_string({
              search = vim.fn.expand("<cword>"),
              additional_args = function() return { "--case-sensitive" } end,
            })
          end, vim.tbl_extend("force", opts, {
            desc = "[G]rep References with Ripgrep (Case Sensitive)"
          }))
        end,
      })
    end,
  },
}
