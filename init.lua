local vim = vim
vim.g.mapleader = " "

local colorfile = vim.fn.stdpath("config") .. "/lua/current-theme.lua"

--settings
local vimOptions = {
  splitright     = true,
  splitbelow     = true,
  signcolumn     = "yes",
  relativenumber = true,
  number         = true,
  tabstop        = 2,
  expandtab      = true,
  termguicolors  = true,
  wrap           = false,
  shiftwidth     = 2,
  splitkeep      = "screen",
  fillchars      = {
    stl = " ",
    fold = " ",
  },

  complete       = '.,w,b,kspell',
  completeopt    = { "menu", "menuone", "noinsert" },
  pumborder      = "single",

  -- foldtext = "v:lua.CustomFoldText()",
  ignorecase     = true,
  laststatus     = 2,
  winborder      = "rounded",
  cursorline     = true,
  -- cursorcolumn = true,

  shell          = "nu",
  shellcmdflag   = "-c",
  shellquote     = "'",
  shellxquote    = "",
}

for k, v in pairs(vimOptions) do
  vim.opt[k] = v
end

local mappings = require("mapping")
vim.pack.add({
  "https://github.com/folke/lazy.nvim.git",
})

local plugins = {
  defaults = { lazy = true, }
}
for _, v in pairs(require("plugins.all")) do
  table.insert(plugins, v)
end


if vim.g.neovide then
  vim.o.guifont = "Iosevka Nerd Font"
end



require("special")
require("lazy").setup(
  plugins
)

require("nvim-highlight-colors").setup({})
require("autofolds")
require("dirs")
require("lsp")

require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup({ automatic_enable = true })
require("dapui").setup()
require('vim._extui').enable({
  enable = true,
  msg = {
    ---@type 'cmd'|'msg' Where to place regular messages, either in the
    target = 'msg',
    timeout = 4000,
  },
})

local ok, _ = pcall(require, "current-theme")
if not ok then
  vim.cmd("colorscheme catppuccin")
  require("special").file.write(colorfile)
end
local snippetDir = vim.fn.stdpath("data") .. "/snippets"
if vim.fn.isdirectory(snippetDir) == 0 then
  vim.fn.mkdir(snippetDir, "p")
end

mappings()
