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

return {
  file = { read = readFile, write = writeFile },
  vtext = { disable = disable_v_text, enable = enable_v_text },
  color = {
    rgb = rgb,
    hsv = hsv,
    str2rgb = str2rgb,
    rgb2str = rgb2str,
  },
  ---@param exclusions table<string>|nil
  ---@param dirname string
  ---@param result table
  ---@return table
  dodir = function(dirname, result, exclusions)
    exclusions = exclusions or {};
    setmetatable(result, { __index = table });
    ---@param table table<string>
    ---@param name string
    ---@return boolean
    local function contains(table, name)
      for _, x in ipairs(table) do
        if x == name then return true end
      end
      return false
    end
    for v, t in vim.fs.dir(dirname) do
      if t == 'file' and not contains(exclusions, v) then
        result:insert(dofile(dirname .. '/' .. v));
      end
    end
    return result
  end
}
