local snacks = require('snacks')
keymaps = {
   { "n", ";", ":",          { noremap = false, silent = false } },
   { "n", "y", '"+y',        { noremap = true, silent = true } },
   { "v", "y", '"+y',        { noremap = true, silent = true } },
   { "n", "s", ":write<CR>", { noremap = true, silent = true } },
   {
      "n",
      "<leader>c",
      ":Telescope themes<CR>",
      { desc = "telescope colorschemes", noremap = true, silent = true }
   },
   {
      "n",
      "<leader>ff",
      ":Telescope find_files<CR>",
      { desc = "find files", noremap = true, silent = true }
   },
   {
      "n",
      "<leader>ft",
      ":Telescope live_grep<CR>",
      { desc = "find text in files", noremap = true, silent = true }
   },
   { "n", "<leader>b",  ":tabnew<CR>",                               { noremap = true, silent = true } },
   { "n", "<leader>e",  ":Neotree focus<CR>",                        { noremap = true, silent = true } },
   { "n", "<leader>x",  ":bd<CR>",                                   { desc = "close buffer", noremap = true, silent = true } },
   { "n", "<leader>fh", ":Telescope oldfiles<CR>",                   { desc = "recently opened", noremap = true, silent = true } },

   { "n", "<leader>gs", ":lua require('snacks').lazygit.open()<CR>", { desc = "local Git repo" , noremap = true, silent = true } },
}
for _, keymap in ipairs(keymaps) do
   local mode = keymap[1]
   local lhs = keymap[2]
   local rhs = keymap[3]
   local opts = keymap[4]
   vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local cmp = require('cmp')

cmp.setup({
   snippet = {
      expand = function(args)
         -- Use your snippet engine here, for example, LuaSnip
         require('luasnip').lsp_expand(args.body)
      end,
   },
   mapping = {
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
   },
   sources = cmp.config.sources({
      { name = 'nvim_lsp' }, -- LSP completion
      { name = 'luasnip' },  -- Snippets (if you use LuaSnip)
   }, {
      { name = 'buffer' },   -- Buffer completion
   }),
})

vim.diagnostic.config({
   virtual_text = true,
   signs = true,
   underline = true,
   update_in_insert = true,
})
