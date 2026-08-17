local c = {
  bg = "#111318",
  fg = "#f0f0f7",
  cursor = "#a8c8ff",
  border = "#a8c8ff",
  -- selection-background = #677083,
  -- selection-foreground = #ffffff,
  color0 = "#2c2f34",
  color1 = "#ffb4ab",
  color2 = "#a8c8ff",
  color3 = "#dcbce1",
  color4 = "#bdc7dc",
  color5 = "#d6e3ff",
  color6 = "#d9e3f8",
  color7 = "#c4c6cf",
  color8 = "#9a9da5",
  color9 = "#d32f2a",
  color10 = "#5170a3",
  color11 = "#816787",
  color12 = "#677083",
  color13 = "#345484",
  color14 = "#6d7078",
  color15 = "#f0f0f7",
}
local colorfn = require "special".color

---@param hex string hex color
---@param percent number less than 1
---@return string hex color
local function darkenHex(hex, percent)
  percent   = percent or 10
  local hsv = colorfn.hsv(colorfn.str2rgb(hex))
  hsv.v     = hsv.v * (1 - percent)
  -- hsv.s     = math.min(1, hsv.s * (1.1))
  return colorfn.rgb2str(colorfn.rgb(hsv))
end
c.bg = "none"

local M = {}

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
  Type           = { fg = c.color10, bold = true },
  MiniJump       = { undercurl = true },

  -- Tree-sitter 
  ["@punctuation.bracket"]   = { fg = c.color8 },
  ["@punctuation.delimiter"] = { fg = c.color14 },
  ["@variable"]              = { fg = c.fg },
}

vim.g.colors_name = "cwal"
vim.cmd("highlight clear")
vim.cmd("set background=dark")
vim.cmd("syntax reset")

for group, opts in pairs(M.highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

return M
