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

