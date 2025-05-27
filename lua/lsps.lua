local lspTable = { "clangd", "lua_ls" }
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = lspTable,
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})
require('lspconfig').basics_ls.setup({
    settings = {
        snippet = {
            enable = true,
            sources = { vim.fn.stdpath("config") .. "/snippets",
            }
        },
    }
})
require('lspconfig').arduino_language_server.setup({
  cmd = {
    "arduino-language-server",
    "-cli-config", "C:/Users/paa/.config/arduino-cli.yaml",
    "-cli", "arduino-cli",
    "-fqbn", "esp32:esp32:esp32",
    "-clangd", "clangd"
  }
})
