local profileStart = os.clock()
math.randomseed(profileStart) -- for some random colorshcemes

_G.dataPath   = vim.fn.stdpath "data"
_G.configPath = vim.fn.stdpath "config"
_G.colorfile  = vim.fs.joinpath(configPath, "current-theme.txt")
_G.snippetDir = vim.fs.joinpath(configPath, "snippets")


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
  showbreak      = "  ",
  linebreak      = true,

  complete       = '.,w,b,kspell',
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


local plugin_maps = require "mapping" -- sets up mappings then returns the ones that require a plugin
require "mini"

vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' }, {
  load = function(plug_data)
    vim.cmd.packadd(plug_data.spec.name)
    require "zpack".setup(require "plugins")
    plugin_maps()
  end
})

require "autofolds"
require "dirs"
require "lsp"
require "autocmds"

require "vim._core.ui2".enable {}

if vim.fn.isdirectory(snippetDir) == 0 then
  vim.fn.mkdir(snippetDir, "p")
end

vim.notify("startup: " .. (os.clock() - profileStart) * 1000);

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.MultiFoldMarker(v:lnum)"


function _G.MultiFoldMarker(lnum)
  local line = vim.fn.getline(lnum)

  -- Count { and }
  local opens = select(2, line:gsub("{", ""))
  local closes = select(2, line:gsub("}", ""))

  -- %( escapes the parenthesis, %s*$ ignores trailing spaces before the newline
  if line:match("%($") then
    opens = opens + 1
  end

  -- Subtract a fold if the line starts with )
  -- ^%s* ignores leading spaces after the newline, %) escapes the parenthesis
  if line:match("^%)") then
    closes = closes + 1
  end

  if opens > closes then
    return "a" .. (opens - closes)
  end
  if closes > opens then
    return "s" .. (closes - opens)
  end

  return "="
end
