local foldTable = {
  help             = "manual",
  snacks_dashboard = "manual",
  dashboard        = "manual",
  Fyler            = "manual",
  fyler            = "manual",
  lazy             = "manual",
  Lazy             = "manual",
  lua              = "expr",
  c                = "indent",
  cpp              = "indent",
  markdown         = "manual",
}

local fMeta = setmetatable({}, {
  __index = function(_, key)
    return foldTable[key] or "indent"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    vim.cmd.set("foldmethod=" .. fMeta[vim.bo.filetype])
  end,
})
_G.fold_special = function()
  local foldstart = vim.v.foldstart
  local foldend = vim.v.foldend
  local count = foldstart - foldend + 1
  local fallback = { "  󱞣  " .. count, "@spell" }
  local line = vim.fn.getline(vim.v.foldstart)
  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  local parser = vim.treesitter.get_parser(0, lang)

  if not parser then return { fallback } end
  local query = vim.treesitter.query.get(parser:lang(), "highlights")
  if not query then return { fallback } end

  local tree = parser:parse({ foldstart - 1, foldstart })[1]

  local result = {}

  local line_pos = 0
  local prev_range = nil

  for id, node, _ in query:iter_captures(tree:root(), 0, foldstart - 1, foldstart) do
    local name = query.captures[id]
    local start_row, start_col, end_row, end_col = node:range()
    if start_row == foldstart - 1 and end_row == foldstart - 1 then
      local range = { start_col, end_col }
      if start_col > line_pos then
        table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
      end
      line_pos = end_col
      local text = vim.treesitter.get_node_text(node, 0)
      if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
        result[#result] = { text, "@" .. name }
      else
        table.insert(result, { text, "@" .. name })
      end
      prev_range = range
    end
  end
  table.insert(result, { " 󱞣  " .. count, "@spell" });
  return result
end
vim.wo.foldtext = "v:lua.fold_special()"
