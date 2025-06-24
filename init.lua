local vim = vim
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lazy")

vim.cmd("set number relativenumber")

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

vim.g.mapleader = " "
vim.o.foldmethod = "indent"
vim.o.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

require("lazy").setup(require("plugins"))
require("mapping")

vim.diagnostic.config({
	-- Disable virtual_text since it's redundant due to lsp_lines.
	virtual_text = false,
	signs = true,
	float = { border = "rounded" },
})
vim.opt.termguicolors = true
require("nvim-highlight-colors").setup({})
require("current-theme")
require("lsp")
