-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	git = {
		ignore = false,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	diagnostics = {
		enable = true,
	},
})
