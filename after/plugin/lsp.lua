-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("nvim-lsp-installer").setup({
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

local lspconfig = require("lspconfig")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "pyright", "sumneko_lua", "emmet_ls", "rust_analyzer" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({

		on_attach = on_attach,

		capabilities = capabilities,

		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

require("lspconfig").astro.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").golangci_lint_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Emmet (Expand HTML)
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "htmldjango", "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

require("lspconfig").yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
			customTags = {
				"!Cidr",
				"!Cidr sequence",
				"!And",
				"!And sequence",
				"!If",
				"!If sequence",
				"!Not",
				"!Not sequence",
				"!Equals",
				"!Equals sequence",
				"!Or",
				"!Or sequence",
				"!FindInMap",
				"!FindInMap sequence",
				"!Base64",
				"!Join",
				"!Join sequence",
				"!Ref",
				"!Sub",
				"!Sub sequence",
				"!GetAtt",
				"!GetAZs",
				"!ImportValue",
				"!ImportValue sequence",
				"!Select",
				"!Select sequence",
				"!Split",
				"!Split sequence",
			},
		},
	},
})
-- luasnip setup
local luasnip = require("luasnip")

-- load local lua snippets
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/lua_snippets" })
vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])

-- VSCode Snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/vscode_sinppets" } })

-- Virtual Text{{{
local types = require("luasnip.util.types")
luasnip.config.set_config({
	history = true, --keep around last snippet local to jump back
	updateevents = "TextChanged,TextChangedI", --update changes as you type
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
		-- [types.insertNode] = {
		-- 	active = {
		-- 		virt_text = { { "●", "GruvboxBlue" } },
		-- 	},
		-- },
	},
}) --}}}

-- nvim-cmp setup
local cmp = require("cmp")
-- lspkind setup
local lspkind = require("lspkind")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "vim-dadbod-completion" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	},
	{
		{ name = "buffer" },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			-- with_text = true,
			menu = {
				nvim_lua = "[api]",
				nvim_lsp = "[LSP]",
				luasnip = "[snip]",
				["vim-dadbod-completion"] = "[DB]",
				path = "[path]",
				buffer = "[Buffer]",
			},
		}),
	},
	-- experimental = {
	-- 	native_menu = false,
	-- 	ghost_text = false,
	-- },
})
