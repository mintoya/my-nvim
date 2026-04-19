local foldTable = {
  help             = { method = "manual" },
  snacks_dashboard = { method = "manual" },
  dashboard        = { method = "manual" },
  Fyler            = { method = "manual" },
  fyler            = { method = "manual" },
  lazy             = { method = "manual" },
  Lazy             = { method = "manual" },
  lua              = { method = "expr" },
  c                = { method = "expr", expr = "v:lua.cfold()" },
  cpp              = { method = "syntax" },
  markdown         = { method = "manual" },
}

local fMeta = setmetatable({}, {
  __index = function(_, key)
    return foldTable[key] or { method = "indent" }
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local fmt = fMeta[ft]

    vim.opt_local.foldmethod = fmt.method

    if fmt[fmt.method] then
      vim.opt_local["fold" .. fmt.method] = fmt[fmt.method]
    end
  end,
})
_G.cfold = function()
  -- Cache the line number so we don't query Vim's C-API repeatedly
  local lnum = vim.v.lnum
  local line = vim.fn.getline(lnum)

  local _, brackets_a = line:find("{")
  local _, brackets_b = line:find("}")


  -- Escape the parentheses with % so Lua looks for the literal characters
  local _, parens_a = line:find("%(")
  local _, parens_b = line:find("%)")

  local nextindent = function()
    return vim.fn.indent(lnum) < vim.fn.indent(lnum + 1)
  end

  local previndent = function()
    return vim.fn.indent(lnum - 1) > vim.fn.indent(lnum)
  end

  if (brackets_a and not brackets_b) or (parens_a and not parens_b) then
    if nextindent() then
      return "a1"
    end
  end
  if (brackets_b and not brackets_a) or (parens_b and not parens_a) then
    if previndent() then
      return "s1"
    end
  end
  return "="
end
vim.wo.foldtext = ""

