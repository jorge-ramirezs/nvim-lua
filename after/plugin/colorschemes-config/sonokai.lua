-- The configuration options should be placed before `colorscheme sonokai`.
-- let g:sonokai_style = 'andromeda'
-- let g:sonokai_better_performance = 1
vim.g.sonokai_style = "maia"
vim.g.sonokai_better_performance = 1
vim.cmd("colorscheme sonokai")

require("lualine").setup({
	options = {
		theme = "sonokai",
		style = "espresso",
	},
})

vim.cmd([[ 
  highlight Normal guibg=none
  highlight NonText guibg=none
]])
