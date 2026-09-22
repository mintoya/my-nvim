local foldTable = {
  help             = { method = "manual" },
  snacks_dashboard = { method = "manual" },
  dashboard        = { method = "manual" },
  Fyler            = { method = "manual" },
  fyler            = { method = "manual" },
  lazy             = { method = "manual" },
  c                = { method = "indent" },
  cpp              = { method = "indent" },
  Lazy             = { method = "manual" },
  markdown         = { method = "manual" },
}

local fMeta = setmetatable(foldTable, {
  __index = function(tbl, key)
    if pcall(vim.treesitter.get_parser, 0) then
      return { method = "expr", expr = "v:lua.vim.treesitter.foldexpr()" }
    end
    return tbl[key] or { method = "indent" }
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
  pattern = { "*" },
  callback = function(args)
    pcall(vim.treesitter.start)
    local ft = vim.bo[args.buf].filetype
    local fmt = fMeta[ft]

    vim.opt_local.foldmethod = fmt.method

    if fmt[fmt.method] then
      vim.opt_local["fold" .. fmt.method] = fmt[fmt.method]
    end
  end,
})
