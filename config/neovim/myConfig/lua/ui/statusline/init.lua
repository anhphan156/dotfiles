local modes = {
	["n"] = " N0RMAL",
	["no"] = " N0RMAL",
	["v"] = " VISUAL",
	["V"] = " VISUAL LINE",
	[""] = " VISUAL BLOCK",
	["s"] = " SELECT",
	["S"] = " SELECT LINE",
	[""] = " SELECT BLOCK",
	["i"] = " INSERT",
	["ic"] = " INSERT",
	["R"] = " REPLACE",
	["Rv"] = " VISUAL REPLACE",
	["c"] = " COMMAND",
	["cv"] = " VIM EX",
	["ce"] = " EX",
	["r"] = " PROMPT",
	["rm"] = " MOAR",
	["r?"] = " CONFIRM",
	["!"] = " SHELL",
	["t"] = " TERMINAL",
}

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format("%s", modes[current_mode]):upper()
end

vim.api.nvim_set_hl(0, "MyStatusLineBackground", { fg = "#eeeeee", bg = "#000000" })

vim.api.nvim_set_hl(0, "MyStatusLineAccent", { fg = "#333333", bg = "#ee6767", bold = true })
vim.api.nvim_set_hl(0, "MyStatusLineBorder", { fg = "#ee6767", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyStatusLineAccentInsert", { fg = "#333333", bg = "#59a949", bold = true })
vim.api.nvim_set_hl(0, "MyStatusLineBorderInsert", { fg = "#59a949", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyStatusLineAccentVisual", { fg = "#eeeeee", bg = "#ff309f", bold = true })
vim.api.nvim_set_hl(0, "MyStatusLineBorderVisual", { fg = "#ff309f", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyStatusLineAccentCmdLine", { fg = "#eeeeee", bg = "#3939af", bold = true })
vim.api.nvim_set_hl(0, "MyStatusLineBorderCmdLine", { fg = "#3939af", bg = "#000000" })

vim.api.nvim_set_hl(0, "MyStatusLineBoxWhite", { fg = "#eeeeee", bg = "#333333" })
vim.api.nvim_set_hl(0, "MyStatusLineBoxWhiteInv", { fg = "#333333", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyStatusLineBoxBlue", { fg = "#ababef", bg = "#333333" })
vim.api.nvim_set_hl(0, "MyStatusLineBoxCyan", { fg = "#13e6f9", bg = "#333333" })
vim.api.nvim_set_hl(0, "MyStatusLineBoxRed", { fg = "#f93613", bg = "#333333" })
vim.api.nvim_set_hl(0, "MyStatusLineBoxBlueBold", { fg = "#ababef", bg = "#333333", bold = true })

vim.api.nvim_set_hl(0, "MyLspDiagnosticsSignError", { fg = "#f93613", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyLspDiagnosticsSignWarning", { fg = "#effe33", bg = "#000000" })

local function update_mode_colors(comp)
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#MyStatusLine" .. comp .. "#"
	if current_mode == "n" then
		mode_color = "%#MyStatusLine" .. comp .. "#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#MyStatusLine" .. comp .. "Insert#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#MyStatusLine" .. comp .. "Visual#"
	elseif current_mode == "R" then
		mode_color = "%#MyStatusLine" .. comp .. "Replace#"
	elseif current_mode == "c" then
		mode_color = "%#MyStatusLine" .. comp .. "CmdLine#"
	elseif current_mode == "t" then
		mode_color = "%#MyStatusLine" .. comp .. "Terminal#"
	end
	return mode_color
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""

	if count["errors"] ~= 0 then
		errors = " %#MyLspDiagnosticsSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#MyLspDiagnosticsSignWarning# " .. count["warnings"]
	end

	return errors .. warnings
end

local function filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = vim.fn.expand "%:t"
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function filetype()
	return "%#MyLspDiagnosticsSignError#" .. string.format(" %s ", vim.bo.filetype)
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return
		"%#MyStatusLineBoxWhiteInv#" ..
		" " ..
		"%#MyStatusLineBoxBlue#" ..
		" %p%% " ..
		"%#MyStatusLineBoxWhiteInv#" ..
		"" ..
		"%#MyStatusLineBoxRed#" ..
		" %l " ..
		"%#MyStatusLineBoxBlueBold#" ..
		"",
		"%#MyStatusLineBoxCyan#" ..
		" %c " ..
		"%#MyStatusLineBoxWhiteInv#" ..
		" "
end

local vcs = function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#MyStatusLineBoxWhite#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#MyStatusLineBoxCyan#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#MyStatusLineBoxRed#-" .. git_info.removed .. " ") or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat {

		"%#MyStatusLineBoxWhiteInv#",
		"",
		"%#MyStatusLineBoxBlue#",
		" ",
		added,
		changed,
		removed,
		"%#MyStatusLineBoxCyan# ",
		git_info.head,
		" ",
		"%#MyStatusLineBoxWhiteInv#",
		"",
	}
end

Statusline = {}

Statusline.active = function()
	return table.concat {
		update_mode_colors('Border'),
		"",
		update_mode_colors('Accent'),
		"󰕷 ",
		update_mode_colors('Border'),
		"",
		update_mode_colors('Accent'),
		mode(),
		update_mode_colors('Border'),
		"",

		" ",

		"%#MyStatusLineBoxWhiteInv#",
		"",
		"%#MyStatusLineBoxCyan#",
		" ",
		vim.loop.cwd():match("[^/\\]+$"),
		" ",
		"%#MyStatusLineBoxWhiteInv#",
		"",
		"%#MyStatusLineBoxWhite#",
		filepath(),
		filename(),
		"%#MyStatusLineBoxWhiteInv#",
		"",
		" ",
		lsp(),
		"%=",
		filetype(),
		vcs(),
		lineinfo(),
	}
end

function Statusline.inactive()
	return " %F"
end

function Statusline.short()
	return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au FileType TelescopePrompt,TelescopeResults setlocal statusline=
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
