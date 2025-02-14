return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.g.overwrite_tabs_like_a_savage = vim.g.overwrite_tabs_like_a_savage or false

    if vim.g.overwrite_tabs_like_a_savage then
      vim.cmd("set tabline=")
      require('bufferline').setup {
        options = {
          themable = false,
          diagnostics = "nvim_lsp",
          show_tab_indicators = true,
          always_show_bufferline = false,
          separator_style = "slant",
          show_close_icon = false,
          enforce_regular_tabs = true,
          offsets = {
            {
              filetype = "neo-tree",
            }
          },
        }
      }
      vim.api.nvim_set_keymap('n', 'bp', ':BufferLinePick<CR>', { noremap = true, silent = true })
    end
  end,
}
