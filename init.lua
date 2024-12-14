local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- set working directory to what was passed in as an argument to nvim
local function set_initial_cwd()
  local arg_dir = vim.fn.expand("%:p:h")
  if arg_dir ~= "" then
    vim.cmd("lcd " .. arg_dir)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = set_initial_cwd,
})

-- setting a default macro on @p
vim.api.nvim_command('command! ReplaceWordRepeatable execute "normal! ciw<C-r>0"')
vim.api.nvim_set_keymap("n", "@p", ":ReplaceWordRepeatable<CR>", { noremap = true, silent = true })

local opts = {}

-- Lazy.nvim config for custom tabline
vim.cmd([[
" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
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

-- rails projecsts custom alternate files
vim.g.rails_projections = vim.tbl_extend("force", vim.g.rails_projections or {}, {
  ["app/controllers/*_controller.rb"] = {
    alternate = "spec/requests/{}_spec.rb",
    type = "controller"
  },
  ["spec/requests/*_spec.rb"] = {
    alternate = "app/controllers/{}_controller.rb",
    type = "request"
  },
  ["app/models/user.rb"] = {
    alternate = "spec/models/_user/user_spec.rb",
    type = "model"
  },
  ["spec/models/_user/user_spec.rb"] = {
    alternate = "app/models/user.rb",
    type = "model"
  }
})

require("vim-settings")
require("lazy").setup("plugins", opts)
