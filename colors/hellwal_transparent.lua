-- hellwal.lua
-- Lua version of your Vimscript colorscheme

local M = {}
-- Try loading the generated colors from ~/.cache/hellwal/colors.vim
local colors_path = vim.fn.expand("~/.cache/hellwal/colors.vim")

if vim.fn.filereadable(colors_path) == 0 then
  vim.notify("[HELLWAL]: 'colors.vim' not found in '~/.cache/hellwal/'. Run 'hellwal' to generate it.", vim.log.levels.ERROR)
  return
else
  vim.cmd("source " .. colors_path)
end

-- Verify required color variables exist
if vim.g.hellwal_0 == nil then
  vim.notify("[HELLWAL]: Missing color variables. Run 'hellwal' to generate colors.", vim.log.levels.ERROR)
  return
end

vim.o.background = "dark"
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

-- Define color variables
local c = {
  bg       = vim.g.hellwal_background,
  fg       = vim.g.hellwal_foreground,
  border   = vim.g.hellwal_border,
  cursor   = vim.g.hellwal_cursor,
}

for i = 0, 15 do
  c["color_" .. i] = vim.g["hellwal_" .. i]
end

-- Define highlights
M.highlights = {
  ColorColumn        = { bg = c.color_0 },
  Cursor             = { fg = c.bg, bg = c.cursor },
  CursorColumn       = { bg = c.color_8 },
  CursorLine         = { bg = c.color_0 },
  CursorLineNr       = { fg = c.color_8 },
  DiffAdd            = { bg = c.color_2, bold = true },
  DiffChange         = { bg = c.color_3, italic = true },
  DiffDelete         = { fg = c.color_1, bg = "none", bold = true },
  DiffText           = { bg = c.color_4, bold = true },
  Directory          = { fg = c.color_4 },
  ErrorMsg           = { fg = c.color_1, bg = c.color_0, bold = true },
  FoldColumn         = { fg = c.color_8, bg = c.bg },
  Folded             = { fg = c.color_8, bg = c.color_8, italic = true },
  IncSearch          = { fg = c.color_0, bg = c.color_3, bold = true },
  LineNr             = { fg = c.foreground },
  MatchParen         = { fg = c.color_6, bold = true },
  MoreMsg            = { fg = c.color_4 },
  NonText            = { fg = c.color_8 },
  Normal             = { fg = c.fg, bg = "none" },
  Pmenu              = { fg = c.fg, bg = c.color_1 },
  PmenuSel           = { fg = c.color_7, bg = c.color_2, bold = true },
  Question           = { fg = c.color_6 },
  Search             = { fg = c.color_0, bg = c.color_3, bold = true },
  SignColumn         = { fg = c.fg, bg = "none" },
  StatusLine         = { fg = c.fg, bg = "none", bold = true },
  StatusLineNC       = { fg = c.color_8, bg = "none", bold = true },
  Title              = { fg = c.color_4, bold = true },
  Underlined         = { fg = c.color_6, underline = true },
  VertSplit          = { fg = c.color_8, bg = c.bg },
  Visual             = { bg = c.color_9 },
  WarningMsg         = { fg = c.color_11, bold = true },
  WildMenu           = { fg = c.color_7, bg = c.color_3, bold = true },


  -- Language syntax
  Boolean            = { fg = c.border },
  Character          = { fg = c.color_7 },
  Comment            = { fg = c.color_2, italic = true },
  Conditional        = { fg = c.color_5 },
  Constant           = { fg = c.color_1, bold = true },
  Define             = { fg = c.color_10 },
  Error              = { fg = c.color_1, bg = c.color_0, bold = true },
  Float              = { fg = c.color_4 },
  Function           = { fg = c.color_4 },
  Identifier         = { fg = c.color_1 },
  Keyword            = { fg = c.color_5, italic = true },
  Label              = { fg = c.color_3 },
  Number             = { fg = c.color_7 },
  Operator           = { fg = c.color_12, bold = true },
  PreCondit          = { fg = c.color_6 },
  PreProc            = { fg = c.color_12, italic = true },
  Repeat             = { fg = c.color_4 },
  Special            = { fg = c.color_14, bold = true },
  SpecialComment     = { fg = c.color_13, italic = true },
  SpecialKey         = { fg = c.color_6 },
  SpellBad           = { fg = c.color_1, underline = true },
  SpellCap           = { fg = c.color_11 },
  SpellRare          = { fg = c.color_8 },
  SpellLocal         = { fg = c.color_12 },
  Statement          = { fg = c.color_1, bold = true },
  StorageClass       = { fg = c.color_14 },
  String             = { fg = c.color_13, italic = true },
  Structure          = { fg = c.color_7 },
  Tag                = { fg = c.color_3, bold = true },
  Todo               = { fg = c.color_15, bg = c.color_0, bold = true, italic = true },
  Type               = { fg = c.color_6, bold = true },

}

-- Apply highlights
for group, opts in pairs(M.highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "hellwal"


return M

