local vim = vim
local matugenColors = require("colors.matugen-colors")

-- mytheme.lua
vim.cmd("highlight clear")
vim.cmd("set background=dark") -- or "light"
vim.cmd("syntax reset")

vim.g.colors_name = "mytheme"
vim.opt.fillchars:append('eob: ')

local highlights = {
	StatusLine = { fg = matugenColors.source_color, bg = "none"},
	Normal =     { fg = matugenColors.primary_fixed_dim, bg = "none" },
	Comment =    { fg = matugenColors.on_background, italic = true },
	Constant =   { fg = "#d75f5f" },
	Identifier = { fg = "#d7af87" },
	Statement =  { fg = "#87afaf", italic = true, bold = true },
	PreProc =    { fg = "#d7875f" },
	Type =       { fg = matugenColors.primary_fixed},
	Special =    { fg = "#d7afaf" },
	Underlined = { underline = true },
	Todo =       { fg = "#d75f5f", bold = true },
}

for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end
