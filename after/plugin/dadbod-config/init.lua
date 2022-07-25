local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map("n", "<leader>du", ":DBUIToggle<CR>", opts)
map("n", "<leader>df", ":DBUIFindBuffer<CR>", opts)
map("n", "<leader>dr", ":DBUIRenameBuffer<CR>", opts)
map("n", "<leader>dl", ":DBUILastQueryInfo<CR>", opts)

-- let g:db_ui_save_location = '~/.config/db_ui'
vim.g.db_ui_save_location = "~/.config/db_ui"
