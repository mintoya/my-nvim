local vim = vim

_G.configPath = vim.fn.stdpath("config")
_G.colorfile = configPath .. "/lua/current-theme.lua"
_G.snippetDir = configPath .. "/snippets"

vim.g.mapleader = " "

--settings
local vimOptions = {
  splitright     = true,
  splitbelow     = true,
  signcolumn     = "yes",
  relativenumber = true,
  number         = true,
  tabstop        = 2,
  shiftwidth     = 2,
  expandtab      = true,
  termguicolors  = true,
  wrap           = false,
  splitkeep      = "screen",
  fillchars      = {
    stl = " ",
    fold = " ",
  },

  -- complete       = '.,w,b,kspell',
  completeopt    = { "menuone", "noinsert", "noselect" },



  -- foldtext = "v:lua.CustomFoldText()",
  ignorecase   = true,
  laststatus   = 3,
  pumborder    = "rounded",
  winborder    = "rounded",
  pummaxwidth  = 30,
  cursorline   = true,

  shell        = "nu",
  shellcmdflag = "-c",
  shellquote   = "",
  shellxquote  = "",
  -- neovide
  guifont      = "Iosevka Nerd Font",
  shada        = "'100,<50,s10,:1000,/100,@100,h"

}

for k, v in pairs(vimOptions) do
  vim.opt[k] = v
end

vim.cmd("set foldopen+=insert")

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

local special = require "special"
require("lazy").setup(
  plugins
)

require "autofolds"
require "dirs"
require "lsp"

require 'vim._extui'.enable {
  enable = true,
  msg = {
    target = 'msg',
    timeout = 5000,
  },
}


if vim.fn.isdirectory(snippetDir) == 0 then
  vim.fn.mkdir(snippetDir, "p")
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(afile, _)
    special.file.write(colorfile, ' vim.cmd("colorscheme ' .. afile.match .. '") ')
  end
})


pcall(require, "current-theme")
mappings()
