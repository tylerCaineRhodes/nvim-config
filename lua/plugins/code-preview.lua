return {
  "Cannon07/code-preview.nvim",
  config = function()
    require("code-preview").setup({
      neo_tree = {
        enabled = false,
      },
      diff = {
        layout = "inline",
        defer_claude_permissions = true,
      }
    })
  end,
}
