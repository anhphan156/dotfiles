local bufferline = require('bufferline')
bufferline.setup {
	options = {
		mode                  = "buffers",

		style_preset          = bufferline.style_preset.default,
		indicator             = {
			style = 'underline'
		},

		diagnostic            = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end
	}
}
