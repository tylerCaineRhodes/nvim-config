return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "NvimTree",
        "TelescopePrompt",
        "toggleterm",
        "help",
        "markdown",
        "text",
      },
      providers = {
        "lsp",
        "treesitter",
      },
      delay = 200,
    })

    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LspReferenceText" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LspReferenceRead" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceWrite" })
  end,
}
