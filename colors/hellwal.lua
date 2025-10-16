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
  DiffDelete         = { fg = c.color_1, bg = "NONE", bold = true },
  DiffText           = { bg = c.color_4, bold = true },
  Directory          = { fg = c.color_4 },
  ErrorMsg           = { fg = c.color_1, bg = c.color_0, bold = true },
  FoldColumn         = { fg = c.color_8, bg = c.bg },
  Folded             = { fg = c.color_8, bg = c.color_8, italic = true },
  IncSearch          = { fg = c.color_0, bg = c.color_3, bold = true },
  LineNr             = { fg = c.color_8 },
  MatchParen         = { fg = c.color_6, bold = true },
  MoreMsg            = { fg = c.color_4 },
  NonText            = { fg = c.color_8 },
  Normal             = { fg = c.fg, bg = c.bg },
  Pmenu              = { fg = c.fg, bg = c.color_1 },
  PmenuSel           = { fg = c.color_7, bg = c.color_2, bold = true },
  Question           = { fg = c.color_6 },
  Search             = { fg = c.color_0, bg = c.color_3, bold = true },
  SignColumn         = { fg = c.fg, bg = c.bg },
  StatusLine         = { fg = c.fg, bg = c.border, bold = true },
  StatusLineNC       = { fg = c.color_8, bg = c.border, bold = true },
  Title              = { fg = c.color_4, bold = true },
  Underlined         = { fg = c.color_6, underline = true },
  VertSplit          = { fg = c.color_8, bg = c.bg },
  Visual             = { bg = c.color_4 },
  WarningMsg         = { fg = c.color_11, bold = true },
  WildMenu           = { fg = c.color_7, bg = c.color_3, bold = true },

  -- NERDTree
  NERDTreeUp         = { fg = c.color_4 },
  NERDTreeDir        = { fg = c.color_3 },
  NERDTreeDirSlash   = { fg = c.color_2 },
  NERDTreeFile       = { fg = c.fg },
  NERDTreeCWD        = { fg = c.color_10, bold = true },
  NERDTreeOpenable   = { fg = c.color_7 },
  NERDTreeClosable   = { fg = c.color_6 },

  -- Language syntax
  Boolean            = { fg = c.color_3 },
  Character          = { fg = c.color_7 },
  Comment            = { fg = c.color_2, italic = true },
  Conditional        = { fg = c.color_5 },
  Constant           = { fg = c.color_3, bold = true },
  Define             = { fg = c.color_10 },
  Error              = { fg = c.color_1, bg = c.color_0, bold = true },
  Float              = { fg = c.color_4 },
  Function           = { fg = c.color_4 },
  Identifier         = { fg = c.color_9 },
  Keyword            = { fg = c.color_5, italic = true },
  Label              = { fg = c.color_3 },
  Number             = { fg = c.color_7 },
  Operator           = { fg = c.color_9, bold = true },
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
  Statement          = { fg = c.color_11, bold = true },
  StorageClass       = { fg = c.color_14 },
  String             = { fg = c.color_10, italic = true },
  Structure          = { fg = c.color_7 },
  Tag                = { fg = c.color_3, bold = true },
  Todo               = { fg = c.color_15, bg = c.color_0, bold = true, italic = true },
  Type               = { fg = c.color_6, bold = true },

  -- CSS
  cssAttr            = { fg = c.color_12, bold = true },
  cssClassName       = { fg = c.color_7 },
  cssColor           = { fg = c.color_4 },
  cssFunctionName    = { fg = c.color_3 },
  cssTagName         = { fg = c.color_11 },

  -- JavaScript
  javaScriptBoolean  = { fg = c.color_9 },
  javaScriptFunction = { fg = c.color_4, bold = true },
  javaScriptOperator = { fg = c.color_8 },
  javaScriptStatement= { fg = c.color_7 },

  -- Markdown
  markdownCode               = { fg = c.color_4, italic = true },
  markdownCodeBlock          = { fg = c.color_4, bg = c.color_0 },
  markdownCodeDelimiter      = { fg = c.color_9 },
  markdownHeadingDelimiter   = { fg = c.color_9, bold = true },
  markdownUrl                = { fg = c.color_6, underline = true },
  markdownLinkText           = { fg = c.color_10, underline = true },
  markdownLinkDelimiter      = { fg = c.color_8 },
  markdownLinkTitle          = { fg = c.color_11 },
  markdownBold               = { fg = c.color_3, bold = true },
  markdownItalic             = { fg = c.color_2, italic = true },
  markdownBlockquote         = { fg = c.color_5, italic = true },
  markdownListMarker         = { fg = c.color_7, bold = true },
  markdownRule               = { fg = c.color_12, bold = true },
  markdownIdDeclaration      = { fg = c.color_13, bold = true },
  markdownStrikethrough      = { fg = c.color_14, strikethrough = true },
  markdownTableDelimiter     = { fg = c.color_9 },
  markdownFootnote           = { fg = c.color_6, italic = true },
  markdownFootnoteDefinition = { fg = c.color_8, italic = true },
  markdownTask               = { fg = c.color_4, bold = true },
  markdownMath               = { fg = c.color_12, italic = true },
  markdownH1                 = { fg = c.color_1, bold = true },
  markdownH2                 = { fg = c.color_2, bold = true },
  markdownH3                 = { fg = c.color_3, bold = true },
  markdownH4                 = { fg = c.color_4, bold = true },
  markdownH5                 = { fg = c.color_5, bold = true },
  markdownH6                 = { fg = c.color_6, bold = true },
}

-- Apply highlights
for group, opts in pairs(M.highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "hellwal"


return M

