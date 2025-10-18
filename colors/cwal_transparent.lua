local vim = vim
-- adapted from hellwal.vim by chatgpt

local M = {}

local colorpath = vim.fn.expand("~/.cache/cwal/colors.json");

local configJson = require("special").file.read(colorpath)

if configJson == nil then
  vim.notify("cwal josn colors not in cache")
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
  CursorColumn   = { bg = c.color8 },
  CursorLine     = { bg = c.color0 },
  CursorLineNr   = { fg = c.color8 },
  DiffAdd        = { bg = c.color2, bold = true },
  DiffChange     = { bg = c.color3, italic = true },
  DiffDelete     = { fg = c.color1, bg = "none", bold = true },
  DiffText       = { bg = c.color4, bold = true },
  Directory      = { fg = c.color4 },
  ErrorMsg       = { fg = c.color1, bg = c.color0, bold = true },
  FoldColumn     = { fg = c.color8, bg = c.bg },
  Folded         = { fg = c.color8, bg = c.color8, italic = true },
  IncSearch      = { fg = c.color0, bg = c.color3, bold = true },
  LineNr         = { fg = c.color8 },
  MatchParen     = { fg = c.color6, bold = true },
  MoreMsg        = { fg = c.color4 },
  NonText        = { fg = c.color8 },
  Normal         = { fg = c.fg, bg = c.bg },
  NormalNC       = { fg = c.fg, bg = c.bg },
  Pmenu          = { fg = c.fg, bg = c.color1 },
  PmenuSel       = { fg = c.color7, bg = c.color2, bold = true },
  Question       = { fg = c.color6 },
  Search         = { fg = c.color0, bg = c.color3, bold = true },
  SignColumn     = { fg = c.fg, bg = c.bg },
  StatusLine     = { fg = c.fg, bg = "none" },
  StatusLineNC   = { fg = c.color8, bg = "none" },
  Title          = { fg = c.color4, bold = true },
  Underlined     = { fg = c.color6, underline = true },
  VertSplit      = { fg = c.color8, bg = c.bg },
  Visual         = { bg = c.color3 },
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
  Float          = { fg = c.color4 },
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
  --Plugin Specific
  MiniPickNormal = { fg = c.color1, bg = c.bg },
  FloatBorder    = { fg = c.border, bg = "none" },
  Pick           = { fg = c.color1, bg = "none" },
  PmenuSbar      = { bg = c.cursor },
  PmenuThumb     = { bg = c.cursor },
}

vim.cmd("highlight clear")
vim.cmd("set background=dark")
vim.cmd("syntax reset")

for group, opts in pairs(M.highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "cwal"


return M
