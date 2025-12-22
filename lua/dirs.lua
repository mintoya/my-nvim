local vim = vim
local expand = vim.fn.expand
--backup directorys
local dirs = {
  backup = expand "~/.vim/backup//",
  swap = expand "~/.vim/swap//",
  undo = expand "~/.vim/undo//",
}
for _, dir in ipairs(dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

vim.o.backupdir = dirs.backup
vim.o.directory = dirs.swap
vim.o.undodir = dirs.undok

vim.o.backup = true
vim.o.undofile = true
vim.o.writebackup = true
