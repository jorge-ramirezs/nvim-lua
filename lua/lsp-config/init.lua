-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lspconfig = require("lspconfig")

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

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "pyright", "sumneko_lua", "emmet_ls" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({

		on_attach = function()
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
			vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })

			vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, { buffer = 0 })
			vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, { buffer = 0 })
			vim.keymap.set("n", "<leader>Td", "<cmd>Telescope diagnostics<CR>", { buffer = 0 })
			-- rename variables, functions, etc.
			vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, { buffer = 0 })
		end,

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

-- luasnip setup
local luasnip = require("luasnip")

-- lspkind setup
local lspkind = require("lspkind")

-- nvim-cmp setup
local cmp = require("cmp")
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
			select = true,
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
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
			},
		}),
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})
