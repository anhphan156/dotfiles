local telescope = require("telescope")
local fb_actions = require("telescope._extensions.file_browser.actions")

telescope.setup {
	defaults = {
		cwd = vim.fn.getcwd(), -- Set the current directory to the root of your project
		mappings = {
			i = {
				["<Esc>"] = require('telescope.actions').close,
			},
		},
		file_ignore_patterns = {
			"node_modules"
		}
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			hidden = { file_browser = false, folder_browser = false },
			use_fd = true,
			git_status = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					["c"] = fb_actions.create,
					["r"] = fb_actions.rename,
					["m"] = fb_actions.move,
					["y"] = fb_actions.copy,
					["d"] = fb_actions.remove,
					["h"] = fb_actions.goto_parent_dir,
					["l"] = fb_actions.open_dir,
					["o"] = fb_actions.open,
					["w"] = fb_actions.goto_cwd,
					["t"] = fb_actions.change_cwd,
				},
			},
		},
	},
}

telescope.load_extension("file_browser")
telescope.load_extension("project")
