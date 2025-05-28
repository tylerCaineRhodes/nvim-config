vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.rltvnmbr = false
vim.g.smoothscroll = false
vim.opt.cursorline = false
vim.g.annotate_marks = false
vim.g.overwrite_tabs_like_a_savage = false

vim.cmd("let g:VimuxHeight = '30%'")
vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd('nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""')
vim.cmd("set showcmd")
vim.cmd("set mouse=a")
vim.cmd("set notimeout")
vim.cmd("syntax enable")
vim.cmd("syntax on")
vim.cmd("set undodir=~/.config/nvim/undodir")
vim.cmd("set undofile")
vim.cmd("set nowrap")
vim.cmd("set autoindent")
vim.cmd("set backspace=indent,eol,start")
vim.cmd("set wildmenu")
vim.cmd("set wildmode=longest:full,full")
vim.cmd("set ruler")
vim.cmd("set nowritebackup")
vim.cmd("set list")
vim.cmd("set listchars=tab:»·,trail:·,extends:→,precedes:←,nbsp:␣")
vim.cmd("set showmatch")
vim.cmd("set noswapfile")
vim.cmd("set nobackup")
vim.cmd("set breakindent")
vim.cmd("set smartindent")
vim.cmd("set smartcase")
vim.cmd("set smarttab")
vim.cmd("set incsearch")
vim.cmd("set hlsearch")
vim.cmd("set hidden")
vim.cmd("set updatetime=250")
vim.cmd("set history=1024")
vim.cmd("set ignorecase")
vim.cmd("set autoread")
vim.cmd("set splitright")
vim.cmd("set splitbelow")
vim.cmd("set scrolloff=4")
vim.cmd("nmap <leader>= gg=G``")
vim.cmd("nmap <leader>y ggyG``")
vim.cmd("inoremap jk <esc>")

vim.opt.showmode = false -- don't show twice when using lualine

vim.api.nvim_exec([[
  autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
]], false)

-- go to next/prev lines with direction keys
-- vim.opt.whichwrap:append("<>[]hl")

-- to enable backup and swap files
-- vim.cmd("set swapfile")
-- vim.cmd("set backup")
-- vim.cmd("set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp")
-- vim.cmd("set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp")

-- set relative numbers
vim.keymap.set({ "n", "v" }, "<leader>5", ":set number relativenumber<CR>", {})

-- set absolute numbers
vim.keymap.set({ "n", "v" }, "<leader>6", ":set number norelativenumber<CR>", {})

-- set both absolute and relative numbers
vim.keymap.set({ "n", "v" }, "<leader>7", ":RN<CR>", {})

-- Map yanked to clipboard
vim.keymap.set("v", "<C-c>", '"*y', {})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})

vim.keymap.set("n", "<leader>cf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg("+", filepath)
  print("Copied full path to clipboard: " .. filepath)
end, { desc = "Copy full file path to clipboard" })

vim.keymap.set("n", "<leader>cd", function()
  local dirname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
  vim.fn.setreg("+", dirname)
  print("Copied directory path to clipboard: " .. dirname)
end, { desc = "Copy directory path to clipboard" })

-- vimux open pane
vim.keymap.set("n", "<leader>t", function()
  vim.fn.VimuxOpenRunner()
end, { silent = true })

-- vimux close pane

vim.keymap.set("n", "<leader>T", function()
  vim.fn.VimuxCloseRunner()
end, { silent = true })

-- cycle through capital marks across buffers
local function collect_capital_marks()
  local marks = vim.fn.getmarklist()
  local capitals = {}

  for _, mark in ipairs(marks) do
    local m = mark.mark
    local pos = mark.pos or {}

    if m and m:match("^'[A-Z]$") and #pos >= 3 then
      local file = mark.file
      local bufnr = file and vim.fn.bufnr(file) or -1

      if bufnr == -1 and file then
        vim.cmd("edit " .. vim.fn.fnameescape(file))
        bufnr = vim.fn.bufnr(file)
      end

      if bufnr ~= -1 then
        table.insert(capitals, { mark = m, bufnr = bufnr, line = pos[2], col = pos[3] })
      end
    end
  end

  table.sort(capitals, function(a, b)
    return a.bufnr == b.bufnr and a.line < b.line or a.bufnr < b.bufnr
  end)

  return capitals
end

local function jump_to_capital(offset)
  local capitals = collect_capital_marks()
  if #capitals == 0 then
    print("No capital marks found")
    return
  end

  vim.g._capital_mark_index = (vim.g._capital_mark_index or 0) + offset

  -- wrap around
  if vim.g._capital_mark_index > #capitals then
    vim.g._capital_mark_index = 1
  elseif vim.g._capital_mark_index < 1 then
    vim.g._capital_mark_index = #capitals
  end

  local mark = capitals[vim.g._capital_mark_index]
  vim.api.nvim_set_current_buf(mark.bufnr)
  vim.api.nvim_win_set_cursor(0, { mark.line, mark.col })
end

-- Forward
vim.keymap.set("n", "<leader>mm", function()
  jump_to_capital(1)
end, { desc = "Cycle to next capital mark" })

-- Reverse
vim.keymap.set("n", "<leader>nn", function()
  jump_to_capital(-1)
end, { desc = "Cycle to previous capital mark" })
