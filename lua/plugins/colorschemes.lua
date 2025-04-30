return {
  { "EdenEast/nightfox.nvim",          lazy = true },
  { "haishanh/night-owl.vim",          lazy = true },
  { "ayu-theme/ayu-vim",               lazy = true },
  { "chriskempson/vim-tomorrow-theme", lazy = true },
  { "folke/tokyonight.nvim" },
  { "tylercainerhodes/night-wolf.nvim" },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup({
        options = {
          styles = {
            comments = "italic",
          },
        },
      })
    end,
  }
}
