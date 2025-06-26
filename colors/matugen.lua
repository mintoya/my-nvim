local vim = vim
local matugenColors = require("colors.matugen-colors")

vim.cmd("highlight clear")
vim.cmd("set background=dark") -- or "light"
vim.cmd("syntax reset")

vim.g.colors_name = "mytheme"
vim.opt.fillchars:append('eob: ')

local highlights = {
    Normal       = { fg = matugenColors.on_background, bg = "none" },
    NormalNC     = { fg = matugenColors.on_background, bg = "none" },
    CursorLine   = { bg = matugenColors.surface_container_low },
    CursorColumn = { bg = matugenColors.surface_container_low },
    ColorColumn  = { bg = matugenColors.surface_container_low },
    StatusLine   = { fg = matugenColors.source_color,       bg = "none" },
    StatusLineNC = { fg = matugenColors.on_surface_variant, bg = "none" },
    VertSplit    = { fg = matugenColors.surface_container_high },
    LineNr       = { fg = matugenColors.surface_container_high, bg = matugenColors.background },
    CursorLineNr = { fg = matugenColors.primary_fixed, bold = true },
    Comment      = { fg = matugenColors.surface_bright, italic = true },
    Constant     = { fg = "#d75f5f" },
    Identifier   = { fg = "#d7af87" },
    Statement    = { fg = "#87afaf", italic = true, bold = true },
    PreProc      = { fg = "#d7875f" },
    Type         = { fg = matugenColors.primary_fixed },
    Special      = { fg = "#d7afaf" },
    Underlined   = { underline = true },
    Todo         = { fg = "#d75f5f", bold = true },
    Error        = { fg = matugenColors.on_error, bg = matugenColors.error_container, bold = true },
    WarningMsg   = { fg = matugenColors.error_container },
    Search       = { fg = matugenColors.inverse_on_surface, bg = matugenColors.surface_container_high },
    IncSearch    = { fg = matugenColors.inverse_on_surface, bg = matugenColors.secondary_fixed_dim },
    Visual       = { bg = matugenColors.surface_container_high },
    Pmenu        = { fg = matugenColors.on_surface, bg = matugenColors.surface_container },
    PmenuSel     = { fg = matugenColors.inverse_on_surface, bg = matugenColors.secondary_fixed_dim },
    PmenuSbar    = { bg = matugenColors.surface_container_low },
    PmenuThumb   = { bg = matugenColors.surface_container_high },
    Folded       = { fg = matugenColors.on_surface_variant, bg = matugenColors.surface_container_low },
    FoldColumn   = { fg = matugenColors.on_surface_variant, bg = matugenColors.background },
    DiffAdd      = { bg = "#335533" },
    DiffChange   = { bg = "#555533" },
    DiffDelete   = { bg = "#553333" },
    DiffText     = { bg = "#777733" },
    SpellBad     = { undercurl = true, sp = matugenColors.error_container },
    SpellCap     = { undercurl = true, sp = matugenColors.primary_fixed_dim },
    SpellRare    = { undercurl = true, sp = matugenColors.tertiary_fixed_dim },
    SpellLocal   = { undercurl = true, sp = matugenColors.secondary_fixed_dim },
}

for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end
