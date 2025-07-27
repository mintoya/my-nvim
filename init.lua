local vim = vim
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lazy")

vim.cmd("set number relativenumber")


--backu directorys
local fn = vim.fn
local dirs = {
	fn.expand("~/.vim/backup//"),
	fn.expand("~/.vim/swap//"),
	fn.expand("~/.vim/undo//"),
}
for _, dir in ipairs(dirs) do
	if fn.isdirectory(dir) == 0 then
		fn.mkdir(dir, "p")
	end
end
vim.o.backup = true
vim.o.undofile = true
vim.o.writebackup = true
vim.o.backupdir = fn.expand("~/.vim/backup//")
vim.o.directory = fn.expand("~/.vim/swap//")
vim.o.undodir = fn.expand("~/.vim/undo//")

--settings
local vimOptions = {
	splitright = true,
	splitbelow = true,
	signcolumn = "yes",
	number = true,
	tabstop = 2,
	expandtab = true,
	termguicolors = true,
	shiftwidth = 2,
	fillchars = {
		stl = " ",
		fold = " ",
	},
	foldtext = "v:lua.CustomFoldText()",
	ignorecase = true,
	laststatus = 3,
	winborder = "rounded",
}
for k, v in pairs(vimOptions) do
	vim.opt[k] = v
end

vim.g.mapleader = " "

require("lazy").setup(require("plugins"))
require("mapping")
require("nvim-highlight-colors").setup({})
require("lsp")
require("current-theme")

_G.CustomFoldText = function()
	local fs = vim.v.foldstart
	local count = vim.v.foldend - fs + 1
	local suffix = string.format("~ %d %s", count, "lines")
	if vim.opt.foldmethod._value == "indent" then
		return "" .. suffix
	else
		local line = vim.api.nvim_buf_get_lines(0, fs - 1, fs, false)[1]
		return line .. " " .. suffix
	end
end

-- local function set_foldmethod()
-- 	local has_ts = false
-- local ok, parsers = pcall(require, "nvim-treesitter.parsers")
-- if ok then
-- 	local lang = parsers.get_buf_lang(0)
-- 	has_ts = lang and parsers.has_parser(lang)
-- end
-- 	if has_ts then
-- 		vim.wo.foldmethod = "expr"
-- 		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- 	else
-- 		if vim.opt.buftype._value == "" or vim.opt.buftype._value == "nofile" then
-- 			vim.wo.foldmethod = "manual"
-- 		else
-- 			vim.wo.foldmethod = "indent"
-- 		end
-- 	end
-- end

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
