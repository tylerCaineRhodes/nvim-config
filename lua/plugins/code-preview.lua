return {
  "Cannon07/code-preview.nvim",
  config = function()
    require("code-preview").setup({
      neo_tree = {
        enabled = false,
      },
    })
  end,
}
