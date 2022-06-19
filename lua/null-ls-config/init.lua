local null_ls = require("null-ls")

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local sources = {
	null_ls.builtins.code_actions.eslint,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.autopep8,
	null_ls.builtins.formatting.djlint,
	null_ls.builtins.diagnostics.cfn_lint,
}

null_ls.setup({
	sources = sources,

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
