vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lazy")
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lua")

vim.g.mapleader = " "
vim.o.foldmethod = "indent"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 4
-- 2 makes telescope collapse all the files
vim.o.number = true
vim.opt.expandtab = true
-- Remove tildes on unwritten lines
vim.o.fillchars = "eob: " -- Replace tildes with blank space on empty lines

require("lazy").setup(require("plugins"))
require("mapping")       --enables coustom keybinds
require("current-theme") --required to remember theme
require("lsps")
