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

local lchartable = {
  ["{"] = 1,
  ["}"] = -1,
  ["("] = 1,
  [")"] = -1,
  ["["] = 1,
  ["]"] = -1,
}
_G.cfold = function()
  local lnum = vim.v.lnum
  local line = vim.fn.getline(lnum)


  local diff = 0
  for c in line:gmatch(".") do
    diff = diff + (lchartable[c] or 0)
  end

  if diff > 0 then
    return "a" .. diff
  else
    if diff < 0 then
      return "s" .. -diff
    else
      return "="
    end
  end
end

vim.wo.foldtext = ""
