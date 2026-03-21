vim.lsp.config.nu = {
  cmd = { 'nu', '-n', '--lsp' },
  filetypes = { 'nu' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { '.git' }) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
  end,
}
vim.lsp.config.clangd = {
  -- cmd = { 'clangd' },
  cmd = { 'clangd', '--background-index', '--query-driver=**' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'arduino' },
  initializationOptions = {
    fallbackFlags = { '-std=c2y' },
  },
}
vim.lsp.config.denols = {
  cmd = { "deno", "lsp" },
  filetypes = { 'javascript' },
}
vim.lsp.enable {
  'lua_ls',
  -- 'arduino_language_server',
  'clangd',
  'denols',
  -- 'ccls',
  -- 'zenc',
  'zls',
  'nu',
}

-- local miniCapabilities = MiniCompletion.get_lsp_capabilities()
-- miniCapabilities.textDocument.completion.editsNearCursor = true
-- vim.lsp.config('*', {
--   capabilities = miniCapabilities,
-- })

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN]  = '󰀪 ',
      [vim.diagnostic.severity.INFO]  = '󰋽 ',
      [vim.diagnostic.severity.HINT]  = '󰌶 ',
    },
  },
})

local mason_path      = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason/packages/codelldb/extension/')

local dap             = require('dap')
local codelldb_path   = vim.fs.joinpath(mason_path, 'adapter/codelldb')
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = codelldb_path,
    args = { '--port', '${port}' },
  },
}
if vim.fn.has('windows') then
  dap.adapters.codelldb.executable.detached = false
end

dap.configurations.zig         = {
  {
    name = 'Debug Zig executable',
    type = 'codelldb',
    request = 'launch',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    program = function()
      local executables = require 'special'.metatables.array.new()
      local cmd = 'find . -maxdepth 5 -type f -executable -not -path "*/.*"'
      local handle = io.popen(cmd)

      if handle then
        for line in handle:lines() do
          executables:append(line:gsub('^%./', ""))
        end
        handle:close()
      end

      if #executables > 0 then
        return coroutine.create(function(dap_run_co)
          vim.ui.select(executables, {
            prompt = 'Select executable to debug:',
          }, function(choice)
            coroutine.resume(dap_run_co, choice or vim.fn.input('Manual path: ', "', 'file"))
          end)
        end)
      else
        return vim.fn.input('No executables found. Path: ', vim.loop.cwd() .. '/', 'file')
      end
    end,
  },
}
dap.configurations.c           = dap.configurations.zig
dap.configurations.c[1].name   = 'Debug C executable'
dap.configurations.cpp         = dap.configurations.zig
dap.configurations.cpp[1].name = 'Debug Cpp executable'
require 'mason'.setup()
require 'mason-nvim-dap'.setup()
require 'mason-lspconfig'.setup { automatic_enable = true }
