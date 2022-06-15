local opts = { noremap=true, silent=true }
local map = vim.api.nvim_set_keymap

-- Leader Key
vim.g.mapleader = ' '

-- Nvim-Tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', opts)

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)
