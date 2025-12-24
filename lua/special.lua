local vim = vim

---@param filepath string
---@return nil|string
local function read_from_file(filepath)
  local a, b = pcall(vim.fn.readfile, filepath, "b")
  return a and table.concat(b) or nil
end

---@param filepath string
---@param content string
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
    complete = function(_, _)
      local res = {}
      for i, _ in pairs(M.vtext) do
        table.insert(res, i)
      end
      return res
    end,
  }
)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(afile, _)
    M.file.write(colorfile, afile.match)
  end
})
vim.api.nvim_create_autocmd({ "Signal", "VimEnter" }, {
  pattern = { "*" },
  callback = function(ev)
    if (ev.event == "VimEnter" or ev.match == "SIGUSR1") then
      local colorscheme = M.file.read(colorfile)
      vim.schedule(function() vim.cmd("colorscheme " .. colorscheme) end)
      vim.notify("reloaded colorscheme")
      -- vim.notify("reloaded colorscheme on" .. vim.inspect(ev))
    end
  end
})
-- vim.api.nvim_create_autocmd("Signal", {
--   pattern = "SIGWINCH",
--   callback = function()
--     local layout = vim.fn.winlayout;
--     vim.notify(vim.inspect(layout))
--   end
-- })
vim.api.nvim_create_user_command('TermClear',
  function(opts)
    vim.fn.feedkeys("", 'n')
    local sb = vim.bo.scrollback
    vim.bo.scrollback = 1
    vim.bo.scrollback = sb
  end,
  {
    nargs = 0,
    desc  = "clear terminal",
  }
)
vim.api.nvim_create_user_command('Z',
  function(opts)
    local folder = opts.args
    folder = vim.fn.system("zoxide query " .. folder)
    vim.notify(folder)
    vim.cmd("cd " .. folder);
  end,
  {
    nargs = 1,
    desc  = "cd with zoxide",
  }
)
return M
