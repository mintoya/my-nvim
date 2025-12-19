local vim = vim
vim.lsp.enable({
  "lua_ls",
  "clangd",
  "zls",
})

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN]  = "󰀪 ",
      [vim.diagnostic.severity.INFO]  = "󰋽 ",
      [vim.diagnostic.severity.HINT]  = "󰌶 ",
    },
    -- numhl = {
    --   [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    --   [vim.diagnostic.severity.WARN]  = "WarningMsg",
    -- },
  },
})

local dap             = require("dap")

local mason_path      = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path   = mason_path .. "adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}
if vim.fn.has("windows") then
  dap.adapters.codelldb.executable.detached = false
end

dap.configurations.zig      = {
  {
    name = "Debug Zig executable",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.loop.cwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c        = dap.configurations.zig
dap.configurations.c.name   = "Debug C executable"
dap.configurations.cpp      = dap.configurations.zig
dap.configurations.cpp.name = "Debug Cpp executable"
