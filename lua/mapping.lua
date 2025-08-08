local vim = vim
-- local conform = require("conform")
local keymaps = {
  { "v", "<<",    "<gv",               { noremap = false, silent = false } },
  { "v", ">>",    ">gv",               { noremap = false, silent = false } },

  { "n", ";",     ":",                 { noremap = false, silent = false } },
  { "n", "y",     '"+y',               { noremap = true, silent = true } },
  { "v", "y",     '"+y',               { noremap = true, silent = true } },
  { "t", "<Esc>", [[<C-\><C-n>]],      { noremap = true } },
  { "n", "<Tab>", "<C-w>",             { noremap = true, silent = true } },
  { "t", "<C-w>", [[<C-\><C-n><C-w>]], { noremap = true, silent = true } },
  {
    "n",
    "<leader>c",
    ":Pick colors<CR>",
    { desc = "change colorscheme", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>ff",
    ":Pick files<CR>",
    { desc = "find files", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>ft",
    ":Pick grep_live<CR>",
    { desc = "find text in files", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>e",
    [[:lua require("fyler").open()<CR>]],
    { desc = "edit files", noremap = true, silent = true },
  },
  { "v", "<C-j>", "10j", { desc = "down 10", noremap = true, silent = true } },
  { "v", "<C-k>", "10k", { desc = "up 10", noremap = true, silent = true } },
  { "n", "<C-j>", "10j", { desc = "down 10", noremap = true, silent = true } },
  { "n", "<C-k>", "10k", { desc = "up 10", noremap = true, silent = true } },
  {
    "n",
    "<leader>fh",
    ":Pick resume<CR>",
    { desc = "recently opened", noremap = true, silent = true },
  },

  {
    "n",
    "<leader>gs",
    ":lua require('snacks').lazygit.open()<cr>",
    { desc = "local git repo", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>h",
    ":horizontal terminal<cr>:startinsert<cr>",
    { desc = "Toggle horizontal terminal", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>se",
    ":ScissorsEditSnippet<cr>",
    { desc = "Snippet: Edit" },
  },
  {
    "n",
    "<leader>sa",
    ":ScissorsAddNewSnippet<cr>",
    { desc = "Snippet: Add" },
  },
  {
    "n",
    "<leader>m",
    ":MCunderCursor<cr>",
    { desc = "add Multicursor Cursor" },
  },
  {
    "n",
    "<leader>fm",
    ":lua vim.lsp.buf.format()<cr>",
    { desc = "Format buffer" },
  },
  {
    "n",
    "<leader>rn",
    [[:lua require("special").rename()<cr>]],
    { desc = "lsp rename", silent = true },
  },

}
for _, keymap in ipairs(keymaps) do
  -- apply keymaps
  local mode = keymap[1]
  local lhs = keymap[2]
  local rhs = keymap[3]
  local opts = keymap[4]
  -- vim.api.nvim_set_keymap(tabel.unpack(keymap));

  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end
