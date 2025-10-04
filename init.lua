local vim = vim
vim.g.mapleader = " "

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

local mappings = require("mapping")
vim.pack.add({ "https://github.com/folke/lazy.nvim.git" })

local plugins = {
  defaults = { lazy = true, }
}
for _, v in pairs(require("plugins.all")) do
  table.insert(plugins, v)
end
require("lazy").setup(
  plugins
)

require("nvim-highlight-colors").setup({})
require("autofolds")
require("dirs")
require("lsp")

local _, _ = pcall(require, "current-theme")
local snippetDir = vim.fn.stdpath("data") .. "/snippets"
if vim.fn.isdirectory(snippetDir) == 0 then
  vim.fn.mkdir(snippetDir, "p")
end

mappings()
