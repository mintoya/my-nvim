local vim = vim

vim.lsp.config.nu = {
  cmd = { 'nu', '-n', '--lsp' },
  filetypes = { 'nu' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { '.git' }) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
  end,
}
vim.lsp.config.clangd = {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    '.git',
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
}
vim.lsp.enable {
  "lua_ls",
  "clangd",
  "zls",
  "nu"
}

local miniCapabilities = MiniCompletion.get_lsp_capabilities()
miniCapabilities.textDocument.completion.editsNearCursor = true
vim.lsp.config('*', {
  capabilities = miniCapabilities,
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
  },
})

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"


--[[
local dap             = require("dap")
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
require "dapui".setup()
]]
require "mason".setup()
require "mason-nvim-dap".setup()
require "mason-lspconfig".setup { automatic_enable = true }
