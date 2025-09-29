local vim = vim
local special = require("special")

vim.g.mapleader = " "


--backup directorys
local dirs = {
  vim.fn.expand("~/.vim/backup//"),
  vim.fn.expand("~/.vim/swap//"),
  vim.fn.expand("~/.vim/undo//"),
}
for _, dir in ipairs(dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end
vim.o.backupdir = vim.fn.expand("~/.vim/backup//")
vim.o.directory = vim.fn.expand("~/.vim/swap//")
vim.o.undodir = vim.fn.expand("~/.vim/undo//")
vim.o.backup = true
vim.o.undofile = true
vim.o.writebackup = true

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


-- returns mappings that need plugin initializations
local mappings = require("mapping")
vim.pack.add({ "https://github.com/folke/lazy.nvim.git" });
require("lazy").setup(require("plugins"))
require("nvim-highlight-colors").setup({})
require("autofolds")

require("lsp")

local theme = special.file.read(vim.fn.stdpath("config") .. "/lua/current-theme.lua")

if theme then
  load(theme)()
else
  special.file.write(vim.fn.stdpath("config") .. "/lua/current-theme.lua",
    [[ vim.cmd("colorscheme default") ]]
  )
  vim.cmd("colorscheme default")
end

require("current-theme")

vim.api.nvim_create_user_command(
  "VText", -- The name of the command (must start with an uppercase letter)
  function(args)
    special.vtext[args.args]()
  end,
  {
    nargs = 1,                           -- Number of arguments the command expects
    desc = "diable/enable virtual text", -- Description for help
    complete = function(_, _, _)
      local res = {}
      for i, _ in pairs(special.vtext) do
        table.insert(res, i)
      end
      return res
    end,
  }
)
mappings()
