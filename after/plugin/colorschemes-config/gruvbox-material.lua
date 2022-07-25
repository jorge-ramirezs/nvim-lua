-- " For dark version.
-- set background=dark
--
-- " For light version.
-- set background=light
--
-- " Set contrast.
-- " This configuration option should be placed before `colorscheme gruvbox-material`.
-- " Available values: 'hard', 'medium'(default), 'soft'
-- let g:gruvbox_material_background = 'soft'
--
-- " For better performance
-- let g:gruvbox_material_better_performance = 1

vim.opt.background = "dark"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme gruvbox-material")

require("lualine").setup({
	options = {
		theme = "gruvbox-material",
	},
})

vim.cmd([[ 
  highlight Normal guibg=none
  highlight NonText guibg=none
]])
