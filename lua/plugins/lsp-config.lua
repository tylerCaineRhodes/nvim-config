return {
  {
    "williamboman/mason.nvim",
    config = function()
      -- install language lsps with :Mason
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "jedi_language_server",
          "pylsp",
          "ruby_lsp",
          "clangd"
        },
      })
    end,
  },
  {
    -- :LspInfo to see what language servers are running
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.jedi_language_server.setup({
        capabilities = capabilities,
      })
      lspconfig.pylsp.setup({
        capabilities = capabilities,
      })
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          vim.keymap.set("n", 'gd', require('telescope.builtin').lsp_definitions, { buffer = event.buf, desc = '[G]oto [D]efinition' })
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

          vim.keymap.set("n", "gr", function()
            vim.lsp.buf.references()
          end, { desc = "LSP References" })

          vim.keymap.set("n", "<leader>gr", function()
            require("telescope.builtin").grep_string({
              search = vim.fn.expand("<cword>"),
              additional_args = function() return { "--case-sensitive" } end
            })
          end, { desc = "[G]rep References with Ripgrep (Case Sensitive)" })
        end,
      })
    end,
  },
}
