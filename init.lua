local profileStart = os.clock()
math.randomseed(profileStart)

_G.dataPath   = vim.fn.stdpath "data"
_G.configPath = vim.fn.stdpath "config"
_G.colorfile  = configPath .. "/lua/current-theme.lua"
_G.snippetDir = configPath .. "/snippets"
_G.Special    = require "special"


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



  foldtext     = "",
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

vim.cmd.set("foldopen+=insert")


local plugin_maps = require "mapping"
require "mini"
vim.pack.add(
  { "https://github.com/folke/lazy.nvim.git" },
  {
    load = function(plugin)
      vim.cmd.packadd(plugin.spec.name)
      require "lazy".setup(require "plugins.all")
    end
  }
)
plugin_maps()
require "autofolds"
require "dirs"
require "lsp"
require "autocmds"

require "vim._extui".enable {
  enable = true,
  msg = {
    target = 'msg',
    timeout = 5000,
  },
}


if vim.fn.isdirectory(snippetDir) == 0 then
  vim.fn.mkdir(snippetDir, "p")
end

vim.notify("startup: " .. (os.clock() - profileStart) * 1000);
