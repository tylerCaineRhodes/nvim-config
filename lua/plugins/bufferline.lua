return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup{
      options = {
        themable = false,
        diagnostics = "nvim_lsp",
        show_tab_indicators = true,
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
          }
        }
      }
    }
  end,
}
