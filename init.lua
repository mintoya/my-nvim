local vim = vim
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lazy")
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lua")
-- turn off the thin curor
-- vim.opt.guicursor = "n:block,i:block"
vim.g.mapleader = " "
vim.o.foldmethod = "indent"
vim.o.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Disable virtual_text since it's redundant due to lsp_lines.
require("lazy").setup(require("plugins"))
require("mapping")
require("lsps")


require("current-theme") --required to remember theme

vim.diagnostic.config({
    virtual_text = false,           -- Disable inline virtual text
    signs = true,                   -- Keep error signs in the gutter (optional)
    float = { border = "rounded" }, -- Customize floating window appearance (optional)
})
