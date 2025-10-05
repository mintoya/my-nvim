local vim = vim

local function read_from_file(filepath)
  local f
  local i, result = pcall(function()
    f = vim.fn.readfile(filepath, "b")
  end)
  if not i then
    return nil
  else
    return table.concat(f)
  end
end

local function write_to_file(filepath, content)
  vim.fn.writefile({ content }, filepath, "b")
end

local function disable_v_text()
  vim.diagnostic.config {
    virtual_lines = false,
  }
end
local function enable_v_text()
  vim.diagnostic.config {
    virtual_lines = true,
  }
end
local M = {
  file = { read = read_from_file, write = write_to_file },
  vtext = { disable = disable_v_text, enable = enable_v_text },
}
vim.api.nvim_create_user_command('VText',
  function(opts)
    local which = opts.args
    M.vtext[which]()
  end,
  {
    nargs    = 1,
    desc     = "toggle virtual text",
    complete = function(_, _, _)
      local res = {}
      for i, _ in pairs(M.vtext) do
        table.insert(res, i)
      end
      return res
    end,
  }
)
return M
