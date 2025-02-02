return {
  "projekt0n/github-nvim-theme",
  lazy = false,
  priority = 1000,
  config = function()
    require("github-theme").setup({
      options = {
        styles = {
          comments = "italic",
        },
      },
    })
    vim.cmd("colorscheme github_dark_dimmed")

    function set_rel_number_colors()
      local normal_bg = vim.api.nvim_get_hl(0, { name = "LineNr" }).bg
      local primary_fg = 'yellow'
      local secondary_fg = 'magenta'

      vim.cmd(string.format(
        "highlight HL_RltvNmbr_Minus gui=none,italic guifg=%s guibg=%s",
        primary_fg, normal_bg
      ))
      vim.cmd(string.format(
        "highlight HL_RltvNmbr_Positive gui=none,italic guifg=%s guibg=%s",
        secondary_fg, normal_bg
      ))
    end

    set_rel_number_colors()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.schedule(function()
          set_rel_number_colors()
        end)
      end,
    })
  end,
}
