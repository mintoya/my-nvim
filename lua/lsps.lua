-- LazyVim LSP configuration with nvim-cmp

-- Define a table of LSP configurations
local lspTable = {
	'lua_ls','clangd'
}
local onatatch = function(client, bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        end
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')


for _, lsp in ipairs(lspTable) do
    lspconfig[lsp].setup({
	capabilities = capabilities,
        on_attach = onatatch,
        flags = {
            debounce_text_changes = 150,
        }
    })
end

-- Set up nvim-cmp for autocompletion
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            -- Use your snippet engine here, for example, LuaSnip
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- LSP completion
        { name = 'luasnip' },   -- Snippets (if you use LuaSnip)
    }, {
        { name = 'buffer' },     -- Buffer completion
    }),
})

-- Optionally, configure additional features like lsp diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
})

