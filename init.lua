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
vim.opt.backup = true
vim.opt.undofile = true
vim.opt.writebackup = true
vim.opt.backupdir = fn.expand("~/.vim/backup//")
vim.opt.directory = fn.expand("~/.vim/swap//")
vim.opt.undodir = fn.expand("~/.vim/undo//")

--settings
vim.g.mapleader = " "
vim.o.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.shiftwidth = 2
vim.opt.fillchars = {
	stl = " ",
}
vim.opt.foldtext = "v:lua.CustomFoldText()"
vim.opt.fillchars = vim.opt.fillchars:get()
vim.opt.fillchars:append({ fold = " " })
vim.opt.ignorecase = true
vim.opt.laststatus = 3

require("lazy").setup(require("plugins"))
require("mapping")
require("nvim-highlight-colors").setup({})
require("lsp")
require("dashboard").setup(require("welcome"))
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
