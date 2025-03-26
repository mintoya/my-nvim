local snacks = require("snacks")
local keymaps = {
  { "v", "<<",         "<gv",                        { noremap = false, silent = false } },
  { "v", ">>",         ">gv",                        { noremap = false, silent = false } },
  { "n", ";",          ":",                          { noremap = false, silent = false } },
  { "n", "y",          '"+y',                        { noremap = true, silent = true } },
  { "v", "y",          '"+y',                        { noremap = true, silent = true } },
  { "n", "s",          ":write<CR>",                 { noremap = true, silent = true } },
  -- todone
  { "n", "<leader>nt", "<cmd>TodoneToday<cr>",       { desc = "Open today's notes" } },
  { "n", "<leader>nf", "<cmd>TodoneToggleFloat<cr>", { desc = "Toggle priority float" } },
  { "n", "<leader>nl", "<cmd>TodoneList<cr>",        { desc = "List all notes" } },
  { "n", "<leader>ng", "<cmd>TodoneGrep<cr>",        { desc = "Search inside all notes" } },
  { "n", "<leader>np", "<cmd>TodonePending<cr>",     { desc = "List notes with pending tasks" } },
  {
    "n",
    "<leader>c",
    ":Telescope themes<CR>",
    { desc = "telescope themes", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>ff",
    ":Telescope find_files<CR>",
    { desc = "find files", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>ft",
    ":Telescope live_grep<CR>",
    { desc = "find text in files", noremap = true, silent = true },
  },
  { "n", "<leader>b", ":tabnew<CR>", { noremap = true, silent = true } },
  { "n", "<leader>e", ":Yazi<CR>", { desc = "Open yazi at the current file", noremap = true, silent = true },
  },
  { "n", "<leader>x", ":bd<CR>",     { desc = "close buffer", noremap = true, silent = true } },
  {
    "n",
    "<leader>fh",
    ":Telescope oldfiles<CR>",
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
    ":ToggleTerm direction=horizontal<cr>",
    { desc = "Toggle horizontal terminal", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>t",
    ":ToggleTerm direction=float name=cmd<cr>",
    { desc = "Toggle floating terminal", noremap = true, silent = true },
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
    { desc = "Snippet: Add" }
  },
  {
    "n",
    "<leader>m",
    ":MCunderCursor<cr>",
    { desc = "add Multicursor Cursor" }
  },
  {
    "n",
    "<leader>S",
    ":Symbols<cr>",
    { desc = "show Lsp symbols" }
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
vim.keymap.set('n', '<leader>r', require('special').rename, {
  noremap = true,
  silent = true,
  desc = "Lsp Rename"
})
