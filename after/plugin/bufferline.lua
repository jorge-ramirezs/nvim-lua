require("bufferline").setup({
	options = {
		numbers = "buffer_id",
		separator_style = "thin",
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
		--- count is an integer representing total count of errors
		--- level is a string "error" | "warning"
		--- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
		--- this should return a string
		--- Don't get too fancy as this function will be executed a lot
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})
