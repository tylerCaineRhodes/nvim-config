vim.g.mapleader = ","

vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd('nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""')
vim.cmd("set showcmd")
vim.cmd("syntax enable")
vim.cmd("syntax on")
vim.cmd("set undodir=~/.config/nvim/undodir")
vim.cmd("set undofile")
vim.cmd("set nowrap")
vim.cmd("set autoindent")
vim.cmd("set ruler")
vim.cmd("set nowritebackup")
vim.cmd("set noswapfile")
vim.cmd("set nobackup")
vim.cmd("set breakindent")
vim.cmd("set smartindent")
vim.cmd("set smartcase")
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
vim.cmd("set scrolloff=1")

-- attempt to remap easy-motion
vim.keymap.set("n", "<Leader>", "<Plug>(easymotion-prefix)", { silent = true, noremap = false })

-- set relative numbers
vim.keymap.set({ "n", "v" }, "<leader>5", ":set number relativenumber<CR>", {})

-- set absolute numbers
vim.keymap.set({ "n", "v" }, "<leader>6", ":set number norelativenumber<CR>", {})

-- set both absolute and relative numbers
vim.keymap.set({ "n", "v" }, "<leader>7", ":RN<CR>", {})

-- creating spaces
vim.keymap.set("n", "<leader>o", "O<Esc>k", {})
vim.keymap.set("n", "<leader>c", "o<Esc>j", {})

-- line moving
vim.keymap.set("n", "]e", ":m .+1<CR>==", {})
vim.keymap.set("n", "[e", ":m .-2<CR>==", {})
vim.keymap.set("i", "]e", "<ESC>:m .+1<CR>==gi", {})
vim.keymap.set("i", "[e", "<ESC>:m .-2<CR>==gi", {})
vim.keymap.set("v", "]e", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "[e", ":m '<-2<CR>gv=gv", {})

-- Map yanked to clipboard
vim.keymap.set("v", "<C-c>", '"*y', {})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})

-- disable arrow keymappings
vim.keymap.set({ "n", "v", "i", "c" }, "<Up>", "<Nop>", {})
vim.keymap.set({ "n", "v", "i", "c" }, "<Down>", "<Nop>", {})
vim.keymap.set({ "n", "v", "i", "c" }, "<Left>", "<Nop>", {})
vim.keymap.set({ "n", "v", "i", "c" }, "<Right>", "<Nop>", {})
