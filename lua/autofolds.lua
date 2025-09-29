local foldTable = {
  snacks_dashboard = "manual",
  Fyler            = "manual",
  lua              = "expr" ,
  c                = "indent",
}

local fMeta = setmetatable({},{
  __index = function(_,key)
    local v = foldTable[key]
    if v==nil then
      v = "indent"
    end
    return v
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"*"},
  callback = function()
    vim.cmd("set foldmethod=" .. fMeta[vim.bo.filetype]);
  end,
})


