vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lazy")
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lua")

vim.g.mapleader = " "
vim.o.foldmethod = "indent"
vim.o.number = true
vim.opt.expandtab = true

require("lazy").setup(require("plugins"))
require("mapping") --enables coustom keybinds
require("current-theme") --required to remember theme
require("lsps")
function hello()
	print("hello")
end
