return {
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
        "yaml",
        "tmux",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
