local vim = vim
-- adapted from hellwal.vim

-- Convert hex color (#RRGGBB) to HSL


---@class hsl
---@field h number hue
---@field s number saturation
---@field l number lightness


---@param hex string
---@return hsl
local function toHSL(hex)
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255

  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local h, s, l
  l = (max + min) / 2

  if max == min then
    h, s = 0, 0 -- achromatic
  else
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)
    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h / 6
  end

  return { h = h, s = s, l = l }
end


local function hue2rgb(p, q, t)
  if t < 0 then t = t + 1 end
  if t > 1 then t = t - 1 end
  if t < 1 / 6 then return p + (q - p) * 6 * t end
  if t < 1 / 2 then return q end
  if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
  return p
end

---@param hsl hsl
---@return string
local function fromHSL(hsl)
  local r, g, b
  if hsl.s == 0 then
    r, g, b = hsl.l, hsl.l, hsl.l -- achromatic
  else
    local q = hsl.l < 0.5 and hsl.l * (1 + hsl.s) or hsl.l + hsl.s - hsl.l * hsl.s
    local p = 2 * hsl.l - q
    r = hue2rgb(p, q, hsl.h + 1 / 3)
    g = hue2rgb(p, q, hsl.h)
    b = hue2rgb(p, q, hsl.h - 1 / 3)
  end

  local function toHex(x)
    return string.format("%02X", math.floor(x * 255 + 0.5))
  end

  return "#" .. toHex(r) .. toHex(g) .. toHex(b)
end

---@param hex string hex color
---@param percent number less than 1
---@return string hex color
local function darkenHex(hex, percent)
  percent = percent or 10
  local hsl = toHSL(hex)
  hsl.l = math.max(0, hsl.l * (1 - percent))
  return fromHSL(hsl)
end

local M = {}

local colorpath = vim.fn.expand("~/.cache/cwal/colors.json");

local configJson = require("special").file.read(colorpath)

if configJson == nil then
  vim.notify("cwal json colors not in cache")
  return
end

local config = vim.json.decode(configJson)

local c = config.colors
c.bg = "none"
c.fg = config.special.foreground
c.cursor = config.special.cursor
c.border = c.cursor

-- vim.notify(vim.inspect(c))

M.highlights = {
  ColorColumn    = { bg = c.color0 },
  Cursor         = { fg = c.bg, bg = c.cursor },
  CursorColumn   = { bg = darkenHex(c.color1, .5) },
  CursorLine     = { bg = darkenHex(c.color1, .5) },
  CursorLineNr   = { fg = c.color8 },
  DiffAdd        = { bg = c.color2, bold = true },
  DiffChange     = { bg = c.color3, italic = true },
  DiffDelete     = { fg = c.color1, bg = "none", bold = true },
  DiffText       = { bg = c.color4, bold = true },
  Directory      = { fg = c.color15 },
  ErrorMsg       = { fg = c.color1, bg = c.color0, bold = true },
  FoldColumn     = { fg = c.color8, bg = c.bg },
  Folded         = { bg = darkenHex(c.color12, .8), italic = true },
  IncSearch      = { fg = c.color0, bg = c.color3, bold = true },
  LineNr         = { fg = c.color8 },
  MatchParen     = { fg = c.color6, bold = true },
  MoreMsg        = { fg = c.color4 },
  NonText        = { fg = c.color8 },
  Normal         = { fg = c.fg, bg = c.bg },
  NormalNC       = { fg = c.fg, bg = c.bg },
  Float          = { fg = c.color13, bg = "none" },
  FloatBorder    = { fg = c.color13, bg = "none" },
  NormalFloat    = { fg = c.color13, bg = "none" },
  Pmenu          = { fg = c.color13, bg = "none" },
  PmenuSel       = { fg = c.color12, bg = c.color0, bold = true },
  PmenuSbar      = { bg = c.cursor },
  PmenuThumb     = { bg = c.cursor },
  Question       = { fg = c.color6 },
  Search         = { fg = c.color0, bg = c.color3, bold = true },
  SignColumn     = { fg = c.fg, bg = c.bg },
  StatusLine     = { fg = c.fg, bg = "none" },
  StatusLineNC   = { fg = c.color8, bg = "none" },
  Title          = { fg = c.color4, bold = true },
  Underlined     = { underline = true },
  VertSplit      = { fg = c.color8, bg = c.bg },
  Visual         = { bg = c.color14, fg = "black" },
  WarningMsg     = { fg = c.color11, bold = true },
  WildMenu       = { fg = c.color7, bg = c.color3, bold = true },
  -- Language syntax
  Boolean        = { fg = c.color3 },
  Character      = { fg = c.color7 },
  Comment        = { fg = c.color2, italic = true },
  Conditional    = { fg = c.color5 },
  Constant       = { fg = c.color3, bold = true },
  Define         = { fg = c.color10 },
  Error          = { fg = c.color1, bg = c.color0, bold = true },
  Function       = { fg = c.color4 },
  Identifier     = { fg = c.color9 },
  Keyword        = { fg = c.color5, italic = true },
  Label          = { fg = c.color3 },
  Number         = { fg = c.color7 },
  Operator       = { fg = c.color9, bold = true },
  PreCondit      = { fg = c.color6 },
  PreProc        = { fg = c.color12, italic = true },
  Repeat         = { fg = c.color4 },
  Special        = { fg = c.color14, bold = true },
  SpecialComment = { fg = c.color13, italic = true },
  SpecialKey     = { fg = c.color6 },
  SpellBad       = { fg = c.color1, underline = true },
  SpellCap       = { fg = c.color11 },
  SpellRare      = { fg = c.color8 },
  SpellLocal     = { fg = c.color12 },
  Statement      = { fg = c.color11, bold = true },
  StorageClass   = { fg = c.color14 },
  String         = { fg = c.color10, italic = true },
  Structure      = { fg = c.color7 },
  Tag            = { fg = c.color3, bold = true },
  Todo           = { fg = c.color15, bg = c.color0, bold = true, italic = true },
  Type           = { fg = c.color6, bold = true },
  MiniJump       = { undercurl = true },

  -- Pick           = { fg = c.color1, bg = "none" },
}

vim.g.colors_name = "cwal"
vim.cmd("highlight clear")
vim.cmd("set background=dark")
vim.cmd("syntax reset")

for group, opts in pairs(M.highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

return M
