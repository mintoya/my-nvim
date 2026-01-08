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
    local v = foldTable[key]
    return v or "indent"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    vim.cmd("set foldmethod=" .. fMeta[vim.bo.filetype]);
  end,
})

