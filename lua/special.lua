local vim     = vim

local str2rgb = nil
local rgb2str = nil
local rgb     = nil
local hsv     = nil
do --color
  local lshxPath = dataPath .. "/lshx"
  if vim.fn.isdirectory(lshxPath) == 0 then
    vim.cmd(
      "!git clone https://github.com/iskolbin/lhsx "
      .. lshxPath
    )
  end
  if vim.fn.isdirectory(lshxPath) == 0 then
    vim.notify("couldnt get lhsx, some colors wont work", 2)
  else
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
end

---@class arrayTable
---@field [integer] any
local arrayTable = {}
do -- arrayTable
  ---@return arrayTable
  ---@param self arrayTable
  ---@param item any | any[]
  function arrayTable:append(item)
    item = type(item) == "table" and item or { item }
    for _, v in ipairs(item) do
      table.insert(self, v)
    end
    return self
  end

  ---@param self arrayTable
  ---@return arrayTable
  function arrayTable:squash()
    local result = arrayTable.new()
    self:each(function(e) result:append(e) end)
    self = result
    return self
  end

  ---@return arrayTable
  ---@param self arrayTable
  ---@param index integer
  ---@param item any | any[]
  function arrayTable:set(index, item)
    item = type(item) == "table" and item or { item }
    for _, v in ipairs(item) do
      self[index] = v
      index = index + 1
    end
    return self
  end

  ---@return arrayTable
  ---@param self arrayTable
  ---@param index integer
  ---@param item any | any[]
  function arrayTable:insert(index, item)
    item = type(item) == "table" and item or { item }
    for _, v in ipairs(item) do
      table.insert(self, index, v)
      index = index + 1
    end
    return self
  end

  ---@return integer
  ---@param self arrayTable
  ---@param item any | any[]
  function arrayTable:push(item)
    self:append(item)
    return #self
  end

  ---@return any
  ---@param self arrayTable
  function arrayTable:pop()
    local res = self[#self]
    self[#self] = nil
    return res
  end

  ---@param self arrayTable
  ---@param fn_v_i fun(item:any,index:integer)
  ---@return arrayTable
  function arrayTable:each(fn_v_i)
    for i, v in pairs(self) do fn_v_i(v, i) end
    return self
  end

  ---@param self arrayTable
  ---@param other arrayTable
  ---@return arrayTable|nil -- array of indexes where arraytable contains other arraytable
  function arrayTable:contains(other)
    -- if not getmetatable(other) == arrayTable then setmetatable(other, arrayTable) end
    local result = arrayTable.new()
    self:each(function(e, i)
      other:each(function(d, _)
        if e == d then result:append(i) end
      end)
    end)
    return #result > 0 and result or nil
  end

  ---@return arrayTable
  arrayTable.new = function()
    return setmetatable({}, {
      __index = arrayTable,
      ---@param a arrayTable
      ---@param b arrayTable
      ---@return arrayTable
      __add = function(a, b)
        local c = arrayTable.new()
        local function fn(e, _) c:append(e) end
        a:each(fn)
        b:each(fn)
        return c
      end,
    })
  end
end

return {
  file = {
    ---@param filepath string
    ---@return nil|string
    read = function(filepath)
      local a, b = pcall(vim.fn.readfile, filepath, "b")
      return a and table.concat(b) or nil
    end,

    ---@param filepath string
    ---@param content string
    write = function(filepath, content)
      vim.fn.writefile({ content }, filepath, "b")
    end,
    -- ---@param dirname string
    -- ---@return table<string>
    -- local function readDir(dirname)
    -- end
  },
  vtext = {
    disable_v_text = function()
      vim.diagnostic.config {
        virtual_lines = false,
      }
    end,
    enable_v_text = function()
      vim.diagnostic.config {
        virtual_lines = true,
      }
    end,
  },
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
  end,
  metatables = {
    array = arrayTable,
  },
}
