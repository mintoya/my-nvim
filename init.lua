local dkjson_path = vim.fn.stdpath('config') .. "/dkjson"
package.path = package.path .. ";" .. dkjson_path .. "/?.lua"
vim.opt.runtimepath:prepend(vim.fn.stdpath('config') .. "/lazy")
vim.opt.runtimepath:prepend(vim.fn.stdpath('config') .. "/lua")
vim.g.mapleader = " "
vim.o.foldmethod = "indent"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 3
-- 2 makes telescope collapse all the files
vim.opt.expandtab = true

welcomescreen = require('welcome')

local options = {
   formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      -- css = { "prettier" },
      -- html = { "prettier" },
   },

   format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 200,
      lsp_fallback = true,
   },
}

require("lazy").setup(
require('plugins')
   )

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
local json = require('dkjson')
-- Function to read a JSON file
function read_json_file(filename)
    local file = io.open(filename, "r") -- open the file in read mode
    if not file then
        return nil, "File not found"
    end
    
    local content = file:read("*a") -- read the entire file content
    file:close() -- close the file after reading
    
    local data, pos, err = json.decode(content, 1, nil) -- decode the JSON
    if err then
        return nil, "Error decoding JSON: " .. err
    end
    
    return data
end
-- Function to write to a JSON file
function write_json_file(filename, data)
    local json_text = json.encode(data, { indent = true }) -- encode the data to JSON string
    
    local file = io.open(filename, "w") -- open the file in write mode
    if not file then
        return false, "Error opening file for writing"
    end
    
    file:write(json_text) -- write the JSON text to the file
    file:close() -- close the file after writing
    
    return true
end

local table = vim.fn.stdpath('config')..'/lua/table.json'


write_json_file(table,{hello = 'world'})

vim.api.nvim_create_user_command('AddData', function(opts)
  local args = opts.args
  write_json_file(table, args)
end, {nargs = 1})
