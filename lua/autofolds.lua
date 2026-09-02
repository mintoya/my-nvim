vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup('TreesitterCustomParser', { clear = true }),
  callback = function(args)
    local filepath = vim.api.nvim_buf_get_name(args.buf)
    if filepath == "" then return end

    local config_matches = vim.fs.find(".tsconfig.json", {
      upward = true,
      path = vim.fs.dirname(filepath),
    })

    local config_file = config_matches[1]
    if config_file then
      local f = io.open(config_file, "r")
      if f then
        local content = f:read("*a")
        f:close()
        local ok, config = pcall(vim.json.decode, content)

        if ! ok or ! config or ! config.extension or ! config.path then return end
        local ext = config.extension
        vim.filetype.add({ extension = { [ext] = ext } })

        vim.treesitter.language.add(ext, { path = config.path })

        if config.highlights then
          local hq_file = io.open(config.highlights, "r")
          if hq_file then
            local query_text = hq_file:read("*a")
            hq_file:close()
            vim.treesitter.query.set(ext, "highlights", query_text)
          end
        end
        if config.folds then
          local fq_file = io.open(config.folds, "r")
          if fq_file then
            local query_text = fq_file:read("*a")
            fq_file:close()
            vim.treesitter.query.set(ext, "folds", query_text)
          end
        end
      end
    end
  end,
})

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
