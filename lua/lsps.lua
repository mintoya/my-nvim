local lspTable = {
    "lua_ls", "clangd"
}
local onatatch = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
end
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

-- for _, lsp in ipairs(lspTable) do
--     lspconfig[lsp].setup(
--         {
--             capabilities = capabilities,
--             on_attach = onatatch,
--             -- flags = {
--             --     debounce_text_changes = 150
--             -- }
--         }
--     )
-- end
require('mason-lspconfig').setup({
    handlers = {
        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        -- this is the "custom handler" for `biome`
        biome = function()
            require('lspconfig').biome.setup({
                single_file_support = false,
                on_attach = function(client, bufnr)
                    print('hello biome')
                end
            })
        end,
    }
})
