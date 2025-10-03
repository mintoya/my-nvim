local vim = vim
local special = require("special")

vim.g.mapleader = " "

--backup directorys
local dirs = {
	vim.fn.expand("~/.vim/backup//"),
	vim.fn.expand("~/.vim/swap//"),
	vim.fn.expand("~/.vim/undo//"),
}
for _, dir in ipairs(dirs) do
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end
end
vim.o.backupdir = vim.fn.expand("~/.vim/backup//")
vim.o.directory = vim.fn.expand("~/.vim/swap//")
vim.o.undodir = vim.fn.expand("~/.vim/undo//")
vim.o.backup = true
vim.o.undofile = true
vim.o.writebackup = true

--settings
local vimOptions = {
	splitright = true,
	splitbelow = true,
	signcolumn = "yes",
	relativenumber = true,
	number = true,
	tabstop = 2,
	expandtab = true,
	termguicolors = true,
	wrap = false,
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

-- returns mappings that need plugin initializations
local mappings = require("mapping")
vim.pack.add({ "https://github.com/folke/lazy.nvim.git" })
require("lazy").setup(require("plugins"))
require("nvim-highlight-colors").setup({})
require("autofolds")

require("lsp")

local _, _ = pcall(require, "current-theme")

mappings()
