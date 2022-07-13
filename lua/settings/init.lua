local set = vim.opt

set.termguicolors = true
set.cursorline = true
set.laststatus = 3

set.hidden = true
-- set.path += '**'
set.wrap = false
set.encoding = "UTF-8"

set.number = true
set.relativenumber = true

set.splitbelow = true
set.splitright = true
set.smartindent = true
set.smarttab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartcase = true
set.scrolloff = 8
set.incsearch = true
set.hlsearch = false
set.signcolumn = "yes"
set.colorcolumn = "80"
-- vim.highlight.create("ColorColumn", { ctermbg = 0, guibg = "lightgrey" }, false)
-- vim.highlight.create is deprecated, use vim.api.nvim_set_hl instead. See :h deprecated
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = "lightgrey" })

set.swapfile = false
set.backup = false
set.undofile = true
set.undodir = vim.fn.stdpath("data") .. "/undodir"
-- execute 'set undodir=' . g:nvim_data_root . '/undodir'
--
-- Python virtual environment detection in linux
-- -- let g:loaded_python_provider = 0
-- -- let g:loaded_python3_provider = 0
-- let g:python3_host_prog = '/usr/bin/python3'
vim.g.python3_host_prog = "/home/jorge/.local/share/virtualenvs/nvim-86YW0UDp/bin/python"
