-- LazyVim LSP configuration with nvim-cmp

-- Define a table of LSP configurations
local lspTable = {
    "lua_ls",
    "clangd"
}
local onatatch = function(client, bufnr)
	local opts = {noremap = true, silent = true}
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
end
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

for _, lsp in ipairs(lspTable) do
    lspconfig[lsp].setup(
        {
            capabilities = capabilities,
            on_attach = onatatch,
            flags = {
                debounce_text_changes = 150
            }
        }
    )
end

