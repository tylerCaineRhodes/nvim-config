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

function ChangeTestStrategy(strategy)
  vim.g["test#strategy"] = strategy
  print("Test strategy changed to: " .. strategy)
end

vim.api.nvim_create_user_command("TestStrategy", function(inner_options)
  vim.g["test#strategy"] = inner_options.args
  print("Test strategy changed to: " .. inner_options.args)
end, { nargs = 1 })


vim.api.nvim_create_user_command('Google', function(o)
  local escaped = vim.uri_encode(o.args)
  local url = ('https://www.google.com/search?q=%s'):format(escaped)
  vim.ui.open(url)
end, { nargs = 1, desc = 'just google it' })

vim.api.nvim_create_user_command('DuckDuckGo', function(o)
  local escaped = vim.uri_encode(o.args)
  local url = ('https://duckduckgo.com/?q=%s'):format(escaped)
  vim.ui.open(url)
end, { nargs = 1, desc = 'just google i mean duckduckgo it' })

-- close all buffers except the current one
vim.api.nvim_create_user_command(
  'Bufo',
  '%bd|e#|bd#',
  {}
)

-- close every buffer
vim.api.nvim_create_user_command(
  'Bufc',
  '%bd',
  {}
)

vim.api.nvim_create_user_command(
  'Delmark',
  'delmark A-Za-z',
  {}
)

vim.api.nvim_create_user_command(
  'FormatJson',
  '%!jq .',
  {}
)

require("vim-settings")
require("lazy").setup("plugins", opts)

-- Load the colorscheme
vim.cmd("colorscheme github_dark_dimmed")
