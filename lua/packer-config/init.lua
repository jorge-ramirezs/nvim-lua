local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup(function(use)
	-- My plugins here
	use({
		"wbthomason/packer.nvim", -- Packer can manage itself
		"kyazdani42/nvim-web-devicons",
		"kyazdani42/nvim-tree.lua",

		-- Telescope
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",

		-- Fugitive
		"tpope/vim-fugitive",

		-- Is Like Gitlens
		"f-person/git-blame.nvim",

		-- LSP Config, Installer and AutoCompletion
		-- https://github.com/neovim/nvim-lspconfig/wiki/Installing-language-servers#automatically
		-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
		"williamboman/nvim-lsp-installer",
		"neovim/nvim-lspconfig",

		-- AutoCompletion
		"hrsh7th/nvim-cmp", -- Autocompletion plugin
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
		"L3MON4D3/LuaSnip", -- Snippets plugin
		"onsails/lspkind-nvim",
		"b0o/schemastore.nvim", -- Schema Store

		-- AutoFormatting
		"jose-elias-alvarez/null-ls.nvim",
		-- using local for dev
		-- "~/projects/nvim_plugins/DeanGaffney/null-ls.nvim",
		-- "~/projects/nvim_plugins/null-ls.nvim",

		-- NerdComment.nvim
		"numToStr/Comment.nvim",

		-- bufferline, show buffer names in tabs
		{ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" },

		-- Pretty Status line
		{
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		},

		-- SQL plugin
		{
			"kristijanhusak/vim-dadbod-ui",
			requires = "tpope/vim-dadbod",
		},
		"kristijanhusak/vim-dadbod-completion",

		-- Themes
		"folke/tokyonight.nvim",
		"sainnhe/gruvbox-material",
		"EdenEast/nightfox.nvim",
		"sainnhe/sonokai",
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if Packer_bootstrap then
		require("packer").sync()
	end
end)
