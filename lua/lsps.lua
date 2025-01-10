local lsbTable = { "clangd", "lua_ls" }
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = lspTable,
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})
