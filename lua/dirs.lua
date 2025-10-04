local vim = vim
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
