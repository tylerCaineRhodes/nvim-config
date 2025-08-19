-- Create module with toggle function that will be accessible from outside
local M = {}

-- Function to restore the custom tabline from init.lua
local function restore_custom_tabline()
  -- Set the custom tabline from init.lua
  vim.cmd([[
    if exists("+showtabline")
        function! MyTabLine()
            let s = ''
            let wn = ''
            let t = tabpagenr()
            let i = 1
            while i <= tabpagenr('$')
                let buflist = tabpagebuflist(i)
                let winnr = tabpagewinnr(i)
                let s .= '%' . i . 'T'
                let s .= (i == t ? '%1*' : '%2*')
                let s .= ' '
                let wn = tabpagewinnr(i,'$')

                let s .= '%#TabNum#'
                let s .= i
                let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
                let bufnr = buflist[winnr - 1]
                let file = bufname(bufnr)
                let buftype = getbufvar(bufnr, 'buftype')
                if buftype == 'nofile'
                    if file =~ '\/.'
                        let file = substitute(file, '.*\/\ze.', '', '')
                    endif
                else
                    let file = fnamemodify(file, ':p:t')
                endif
                if file == ''
                    let file = '[No Name]'
                endif
                let s .= ' ' . file . ' '
                let i = i + 1
            endwhile
            let s .= '%T%#TabLineFill#%='
            let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
            return s
        endfunction
        set stal=2
        set tabline=%!MyTabLine()
        set showtabline=1
        highlight link TabNum Special
    endif
  ]])
end

function M.toggle_bufferline()
  vim.g.overwrite_tabs_like_a_savage = not vim.g.overwrite_tabs_like_a_savage

  if vim.g.overwrite_tabs_like_a_savage then
    vim.cmd("set tabline=")
    require('bufferline').setup {
      options = {
        numbers = "buffer_id",
        themable = false,
        diagnostics = "nvim_lsp",
        show_tab_indicators = true,
        always_show_bufferline = false,
        separator_style = "slant",
        show_close_icon = true,
        enforce_regular_tabs = true,
        offsets = {
          {
            filetype = "neo-tree"
          }
        },
      }
    }
    vim.notify('Bufferline enabled', vim.log.levels.INFO)
  else
    -- Remove bufferline UI if possible
    pcall(function()
      require('bufferline').setup { options = { always_show_bufferline = false } }
    end)

    -- Reset tabline before applying custom one
    vim.cmd("set tabline=")

    -- Restore the custom tabline after a short delay to ensure bufferline is fully disabled
    vim.defer_fn(function()
      restore_custom_tabline()
    end, 10)

    vim.notify('Bufferline disabled, custom tabs restored', vim.log.levels.INFO)
  end
end

-- Export the module
_G.bufferline_toggle = M

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.g.overwrite_tabs_like_a_savage = vim.g.overwrite_tabs_like_a_savage or false

    local function setup_bufferline()
      if vim.g.overwrite_tabs_like_a_savage then
        vim.cmd("set tabline=")
        require('bufferline').setup {
          options = {
            numbers = "buffer_id",
            themable = false,
            diagnostics = "nvim_lsp",
            show_tab_indicators = true,
            always_show_bufferline = false,
            separator_style = "slant",
            show_close_icon = true,
            enforce_regular_tabs = true,
            offsets = {
              {
                filetype = "neo-tree"
              }
            },
          }
        }
        vim.api.nvim_set_keymap('n', 'bp', ':BufferLinePick<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>br', ':BufferLineCloseRight<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>bl', ':BufferLineCloseLeft<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '[B', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', ']B', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
      else
        -- Reset bufferline UI if possible
        pcall(function()
          require('bufferline').setup { options = { always_show_bufferline = false } }
        end)
        vim.cmd("set tabline=")
        -- Restore custom tabline
        vim.defer_fn(function()
          restore_custom_tabline()
        end, 10)
      end
    end

    setup_bufferline()

    -- Toggle mapping: <leader>ub (like lazy-nvim convention)
    vim.api.nvim_set_keymap('n', '<leader>ub', [[:lua _G.bufferline_toggle.toggle_bufferline()<CR>]], { noremap = true, silent = true, desc = 'Toggle bufferline' })
  end,
}
