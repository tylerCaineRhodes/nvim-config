vim.g.mapleader = ","
vim.g.maplocalleader = ";"

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
vim.cmd("set cursorline")
vim.cmd("set hidden")
vim.cmd("set updatetime=250")
vim.cmd("set history=1024")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set autoread")
vim.cmd("set splitright")
vim.cmd("set splitbelow")
vim.cmd("set scrolloff=3")
vim.cmd("nmap <leader>= gg=G``")
vim.cmd("nmap <leader>y ggyG``")

-- go to next/prev lines with direction keys
-- vim.opt.whichwrap:append("<>[]hl")

-- to enable backup and swap files
-- vim.cmd("set swapfile")
-- vim.cmd("set backup")
-- vim.cmd("set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp")
-- vim.cmd("set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp")

-- attempt to remap easy-motion
vim.keymap.set("n", "<Leader>", "<Plug>(easymotion-prefix)", { silent = true, noremap = false })

-- set relative numbers
vim.keymap.set({ "n", "v" }, "<leader>5", ":set number relativenumber<CR>", {})

-- set absolute numbers
vim.keymap.set({ "n", "v" }, "<leader>6", ":set number norelativenumber<CR>", {})

-- set both absolute and relative numbers
vim.keymap.set({ "n", "v" }, "<leader>7", ":RN<CR>", {})

-- Map yanked to clipboard
vim.keymap.set("v", "<C-c>", '"*y', {})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})

