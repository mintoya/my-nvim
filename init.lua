vim.opt.runtimepath:prepend(vim.fn.stdpath('config') .. "/lazy")
vim.opt.runtimepath:prepend(vim.fn.stdpath('config') .. "/lua")

vim.g.mapleader = " "
vim.o.foldmethod = "indent"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 3
-- 2 makes telescope collapse all the files
--
vim.opt.expandtab = true


require("lazy").setup(require('plugins'))

require("mini.statusline").setup({
   section = {
      left = function()
         return '%f %y' -- Displays the filename and filetype
      end,
      right = function()
         return '%l:%c %p%%' -- Displays line number, column number, and percentage
      end,
   },
})

require('mapping')       --enables coustom keybinds
require('current-theme') --required to remember theme
require('lsps')

