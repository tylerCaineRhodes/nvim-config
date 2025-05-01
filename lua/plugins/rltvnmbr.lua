return {
  "vim-scripts/RltvNmbr.vim",
  config = function()
    vim.g.rltvnmbr = vim.g.rltvnmbr or false

    if vim.g.rltvnmbr then
      vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
        pattern = "*",
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          if vim.bo[buf].buftype == "" and vim.bo[buf].buflisted then
            vim.cmd("RltvNmbr")
          end
        end,
      })
    end

    local function set_rel_number_colors()
      local normal_bg = vim.api.nvim_get_hl(0, { name = "LineNr" }).bg
      local primary_fg = "#AAE682"
      local secondary_fg = "#FF7878"

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
