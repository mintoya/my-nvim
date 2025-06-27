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
vim.o.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.fillchars = {
	stl = " ",
}

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
require("lsp")
require("alpha").setup(require("welcome").config)
require("current-theme")

_G.CustomFoldText = function()
	local fs = vim.v.foldstart
	local count = vim.v.foldend - fs + 1
	local suffix = { string.format("  %d %s", count, count == 1 and "line" or "lines"), "Folded" }
	local line = vim.api.nvim_buf_get_lines(0, fs - 1, fs, false)[1]
	return line .. suffix[1]
end

vim.wo.foldlevel = 1
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.CustomFoldText()"
vim.opt.fillchars = vim.opt.fillchars:get()
vim.opt.fillchars:append({ fold = " " })
