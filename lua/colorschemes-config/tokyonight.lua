vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_hide_inactive_statusline = true

vim.cmd("colorscheme tokyonight")

require("lualine").setup({
	options = {
		theme = "tokyonight",
	},
})
