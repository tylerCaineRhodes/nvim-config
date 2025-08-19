local M = {}

local function apply_rltvnmbr_to_buffer(buf)
  if buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "" and vim.bo[buf].buflisted then
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! RltvNmbr")
    end)
  end
end

local function remove_rltvnmbr_from_buffer(buf)
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! RltvNmbr!")
    end)
  end
end

local function apply_to_all_buffers(apply_fn)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      apply_fn(buf)
    end
  end
end

function M.toggle_rltvnmbr()
  vim.g.rltvnmbr = not vim.g.rltvnmbr

  if vim.g.rltvnmbr then
    apply_to_all_buffers(apply_rltvnmbr_to_buffer)
    -- Re-register the autocmd for new buffers
    vim.api.nvim_create_augroup("RltvNmbrAuto", { clear = true })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
      group = "RltvNmbrAuto",
      pattern = "*",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        apply_rltvnmbr_to_buffer(buf)
      end,
    })
    vim.notify('Relative numbering enabled', vim.log.levels.INFO)
  else
    apply_to_all_buffers(remove_rltvnmbr_from_buffer)
    -- Clear the autocmd group
    vim.api.nvim_create_augroup("RltvNmbrAuto", { clear = true })
    vim.notify('Relative numbering disabled', vim.log.levels.INFO)
  end
end

_G.rltvnmbr_toggle = M

return {
  "vim-scripts/RltvNmbr.vim",
  config = function()
    vim.g.rltvnmbr = vim.g.rltvnmbr or false

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

    if vim.g.rltvnmbr then
      vim.api.nvim_create_augroup("RltvNmbrAuto", { clear = true })
      vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
        group = "RltvNmbrAuto",
        pattern = "*",
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          apply_rltvnmbr_to_buffer(buf)
        end,
      })
    end

    vim.api.nvim_set_keymap('n', '<leader>ur', [[:lua _G.rltvnmbr_toggle.toggle_rltvnmbr()<CR>]],
      { noremap = true, silent = true, desc = 'Toggle relative line numbers' })

    vim.api.nvim_set_keymap('n', '<leader>7', [[:lua _G.rltvnmbr_toggle.toggle_rltvnmbr()<CR>]],
      { noremap = true, silent = true, desc = 'Toggle relative line numbers (legacy)' })
  end,
}
