local vim = vim

local readFile
local writeFile
do --fs
  ---@param filepath string
  ---@return nil|string
  readFile = function(filepath)
    local a, b = pcall(vim.fn.readfile, filepath, "b")
    return a and table.concat(b) or nil
  end

  ---@param filepath string
  ---@param content string
  writeFile = function(filepath, content)
    vim.fn.writefile({ content }, filepath, "b")
  end
  -- ---@param dirname string
  -- ---@return table<string>
  -- local function readDir(dirname)
  -- end
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

local str2rgb
local rgb2str
local rgb
local hsv
do --color
  local lshxPath = dataPath .. "/lshx"
  if vim.fn.isdirectory(lshxPath) == 0 then
    vim.cmd(
      "!git clone https://github.com/iskolbin/lhsx "
      .. lshxPath
    )
  end

  local hsx = dofile(lshxPath .. "/hsx.lua")

  ---@class hsv
  ---@field h integer 0 to 359
  ---@field s number  0 to 1
  ---@field v number  0 to 1

  ---@class rgb
  ---@field r integer 0 to 255
  ---@field g integer 0 to 255
  ---@field b integer 0 to 255

  ---@param hex string
  ---@return rgb
  str2rgb   = function(hex)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    return { r = r, g = g, b = b }
  end
  ---@param rgbv rgb
  ---@return string
  rgb2str   = function(rgbv)
    local function toHex(x)
      return string.format("%02X", x)
    end
    return "#" .. toHex(rgbv.r) .. toHex(rgbv.g) .. toHex(rgbv.b)
  end

  ---@param rgbv rgb
  ---@return hsv
  hsv       = function(rgbv)
    local h, s, v = hsx.rgb2hsv(rgbv.r, rgbv.g, rgbv.b)
    return { h = h, s = s, v = v }
  end

  ---@param other hsv
  ---@return rgb
  rgb       = function(other)
    local r, g, b = hsx.hsv2rgb(other.h, other.s, other.v)
    return { r = r, g = g, b = b }
  end
end

local M = {
  file = { read = readFile, write = writeFile },
  vtext = { disable = disable_v_text, enable = enable_v_text },
  color = {
    rgb = rgb,
    hsv = hsv,
    str2rgb = str2rgb,
    rgb2str = rgb2str,
  },
}

do -- autocommands
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
        if ev.event == "VimEnter" then
          vim.cmd("colorscheme " .. colorscheme)
        else
          vim.schedule(function() vim.cmd("colorscheme " .. colorscheme) end)
        end
        vim.notify("reloaded colorscheme " .. colorscheme)
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
end
do -- usercommands
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
end

return M
