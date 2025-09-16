local vim = vim
local keymaps = {
  { "n", ";",     ":",                 { noremap = false, silent = false } },

  { "v", "<<",    "<gv",               { noremap = false, silent = false } },
  { "v", ">>",    ">gv",               { noremap = false, silent = false } },

  { "n", "y",     '"+y',               { noremap = true, silent = true } },
  { "v", "y",     '"+y',               { noremap = true, silent = true } },

  { "n", "<Esc>", ":nohlsearch<cr>",   { noremap = false, silent = true } },
  { "n", "<Tab>", "<C-w>",             { noremap = true, silent = true } },

  { "t", "<Esc>", [[<C-\><C-n>]],      { noremap = true } },
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
    [[:Fyler<cr>]],
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
    "<leader>z",
    "",
    { desc = "set foldmethod", silent = true },
  },
  {
    "n",
    "<leader>zi",
    ":set foldmethod=indent<cr>",
    { desc = "indent foldmethod", silent = true },
  },
  {
    "n",
    "<leader>za",
    ":set foldmethod=expr<cr>",
    { desc = "expression foldmethod", silent = true },
  },
  {
    "n",
    "<leader>zm",
    ":set foldmethod=marker<cr>",
    { desc = "marker foldmethod", silent = true },
  },
  -- {
  --   "n",
  --   "<leader>m",
  --   ":MultipleCursorsAddDown<cr>",
  --   { desc = "add Multicursor Cursor" },
  -- },
  {
    "n",
    "<leader>fm",
    ":lua vim.lsp.buf.format()<cr>",
    { desc = "Format buffer" },
  },
  {
    "n",
    "<leader>rn",
    ":lua vim.lsp.buf.rename()<cr>", { desc = "lsp rename", silent = true },
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

return function()
  local mc = require("multicursor-nvim")
  mc.setup()

  local set = vim.keymap.set

  -- Add or skip cursor above/below the main cursor.
  set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
  set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
  set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
  set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

  -- Add or skip adding a new cursor by matching word/selection
  set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
  set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
  set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
  set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

  -- Add and remove cursors with control + left click.
  set("n", "<c-leftmouse>", mc.handleMouse)
  set("n", "<c-leftdrag>", mc.handleMouseDrag)
  set("n", "<c-leftrelease>", mc.handleMouseRelease)

  -- Disable and enable cursors.
  set({ "n", "x" }, "<c-q>", mc.toggleCursor)

  -- Mappings defined in a keymap layer only apply when there are
  -- multiple cursors. This lets you have overlapping mappings.
  mc.addKeymapLayer(function(layerSet)
    -- Select a different cursor as the main one.
    layerSet({ "n", "x" }, "<left>", mc.prevCursor)
    layerSet({ "n", "x" }, "<right>", mc.nextCursor)

    -- Delete the main cursor.
    layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

    -- Enable and clear cursors using escape.
    layerSet("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      else
        mc.clearCursors()
      end
    end)
  end)

  -- Customize how cursors look.
  local hl = vim.api.nvim_set_hl
  hl(0, "MultiCursorCursor", { reverse = true })
  hl(0, "MultiCursorVisual", { link = "Visual" })
  hl(0, "MultiCursorSign", { link = "SignColumn" })
  hl(0, "MultiCursorMatchPreview", { link = "Search" })
  hl(0, "MultiCursorDisabledCursor", { reverse = true })
  hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
  hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
end
