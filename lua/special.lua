local vim = vim

local function read_from_file(filepath)
  local f
  local i, result = pcall(function()
    f = vim.fn.readfile(filepath, "b")
  end)
  if not i then
    f = "[]"
  else
    f = table.concat(f)
  end
  return f
end

local function write_to_file(filepath, content)
  vim.fn.writefile({ content }, filepath, "b")
end



return {
  file = { read = read_from_file, write = write_to_file },
}
