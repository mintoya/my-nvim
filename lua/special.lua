local vim = vim

local function read_from_file(filepath)
  local f
  local i, result = pcall(function()
    f = vim.fn.readfile(filepath, "b")
  end)
  if not i then
    return nil
  else
    return table.concat(f)
  end
end

local function write_to_file(filepath, content)
  vim.fn.writefile({ content }, filepath, "b")
end

local function disable_v_text()
  vim.diagnostic.config {
    virtual_lines = false,
  }
end
local function enable_v_text()
  vim.diagnostic.config {
    virtual_lines = true,
  }
end

return {
  file = { read = read_from_file, write = write_to_file },
  vtext = { disable = disable_v_text, enable = enable_v_text },
}
