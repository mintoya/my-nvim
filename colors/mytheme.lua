local vim = vim
-- mytheme.lua
vim.cmd("highlight clear")
vim.cmd("set background=dark") -- or "light"
vim.cmd("syntax reset")

vim.g.colors_name = "mytheme"
vim.opt.fillchars:append('eob: ')

local highlights = {
	StatusLine = { fg = "#d0d0d0", bg = "none"},
	Normal =     { fg = "#d0d0d0", bg = "none" },
	Comment =    { fg = "#5f875f", italic = true },
	Constant =   { fg = "#d75f5f" },
	Identifier = { fg = "#d7af87" },
	Statement =  { fg = "#87afaf", italic = true, bold = true },
	PreProc =    { fg = "#d7875f" },
	Type =       { fg = "#87af87" },
	Special =    { fg = "#d7afaf" },
	Underlined = { underline = true },
	Todo =       { fg = "#d75f5f", bold = true },
}

for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end
