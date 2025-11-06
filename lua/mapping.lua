local vim = vim
local keymaps = {
  { "n", ";",     ":",                 { noremap = false, silent = false } },

  { "v", "<<",    "<gv",               { desc = "unindent visual", noremap = false, silent = false } },
  { "v", ">>",    ">gv",               { desc = "indent visual", noremap = false, silent = false } },

  { "n", "y",     '"+y',               { noremap = true, silent = true } },
  { "v", "y",     '"+y',               { noremap = true, silent = true } },

  { "n", "<Esc>", ":nohlsearch<cr>",   { noremap = false, silent = true } },
  { "n", "<Tab>", "<C-w>",             { desc = "buffer actions", noremap = true, silent = true } },

  { "t", "<Esc>", [[<C-\><C-n>]],      { noremap = true } },
  { "t", "<C-w>", [[<C-\><C-n><C-w>]], { noremap = true, silent = true } },

  { "v", "<C-j>", "10j",               { desc = "down 10", noremap = true, silent = true } },
  { "v", "<C-k>", "10k",               { desc = "up 10", noremap = true, silent = true } },
  { "n", "<C-j>", "10j",               { desc = "down 10", noremap = true, silent = true } },
  { "n", "<C-k>", "10k",               { desc = "up 10", noremap = true, silent = true } },

  { "n", "<leader>z",
    "",
    { desc = "set foldmethod", silent = true },
  },
  { "n", "<leader>zi",
    ":set foldmethod=indent<cr>",
    { desc = "indent foldmethod", silent = true },
  },
  { "n", "<leader>za",
    ":set foldmethod=expr<cr>",
    { desc = "expression foldmethod", silent = true },
  },
  { "n", "<leader>zm",
    ":set foldmethod=marker<cr>",
    { desc = "marker foldmethod", silent = true },
  },
  --open terminal
  { "n", "<leader>t",  "",                                                 { desc = "open terminal", silent = true } },
  { "n", "<leader>tl", ":vsplit|terminal<cr>:startinsert<cr>",             { desc = "open terminal right", silent = true } },
  { "n", "<leader>tk", ":above split | terminal<cr>:startinsert<cr>",      { desc = "open terminal up", silent = true } },
  { "n", "<leader>tj", ":belowright split | terminal<cr>:startinsert<cr>", { desc = "open terminal down", silent = true } },
  { "n", "<leader>th", ":leftabove vsplit|terminal<cr>:startinsert<cr>",   { desc = "open terminal left", silent = true } },

  { "n", "<leader>b",  "",                                                 { desc = "open pane", silent = true } },
  { "n", "<leader>bl", ":vsplit<cr>:Pick files<CR>",                       { desc = "open pane right", silent = true } },
  { "n", "<leader>bk", ":above split<cr>:Pick files<CR>",                  { desc = "open pane up", silent = true } },
  { "n", "<leader>bj", ":belowright split<cr>:Pick files<CR>",             { desc = "open pane down", silent = true } },
  { "n", "<leader>bh", ":leftabove vsplit<cr>:Pick files<CR>",             { desc = "open pane left", silent = true } },

  { "n", "<leader>c",
    ":Pick colors<CR>",
    { desc = "change colorscheme", noremap = true, silent = true },
  },
  { "n", "<leader>f", "",     { desc = "find/format" } },
  {
    "n",
    "<leader>ff",
    ":Pick files<CR>",
    { desc = "find files", noremap = true, silent = true },
  },
  { "n", "<leader>ft",
    ":Pick grep_live<CR>",
    { desc = "find text in files", noremap = true, silent = true },
  },
  { "n", "<leader>e",
    [[:lua require("fyler").open()<cr>]],
    { desc = "edit files", noremap = true, silent = true },
  },
  { "v", "<C-j>",     "10j",  { desc = "down 10", noremap = true, silent = true } },
  { "v", "<C-k>",     "10k",  { desc = "up 10", noremap = true, silent = true } },
  { "n", "<C-j>",     "10j",  { desc = "down 10", noremap = true, silent = true } },
  { "n", "<C-k>",     "10k",  { desc = "up 10", noremap = true, silent = true } },
  { "n", "yaa",       "ggyG", { desc = "yank all", noremap = true, silent = true } },
  {
    "n",
    "<leader>fh",
    ":Pick resume<CR>",
    { desc = "recently opened", noremap = true, silent = true },
  },

  { "n", "<leader>g",
    ":lua require('snacks').lazygit.open()<cr>",
    { desc = "open local git repo(lazygit)", noremap = true, silent = true },
  },

  { "n", "<leader>s", "", { desc = "Snippet" }, },
  { "n",
    "<leader>se",
    [[:lua require("scissors").editSnippet()<cr>]],
    { desc = "Snippet: Edit" },
  },
  { "n", "<leader>sa",
    [[:lua require("scissors").addNewSnippet()<cr>]],
    { desc = "Snippet: Add" },
  },

  { "n", "<leader>fm",
    ":lua vim.lsp.buf.format()<cr>",
    { desc = "Format buffer" },
  },
  { "n", "<leader>rn",
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
  -- set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
  -- set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
  -- set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
  -- set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

  -- Add and remove cursors with control + left click.
  set("n", "<c-leftmouse>", mc.handleMouse)
  set("n", "<c-leftdrag>", mc.handleMouseDrag)
  set("n", "<c-leftrelease>", mc.handleMouseRelease)

  -- Disable and enable cursors.
  -- set({ "n", "x" }, "<c-q>", mc.toggleCursor)

  -- Mappings defined in a keymap layer only apply when there are
  -- multiple cursors. This lets you have overlapping mappings.
  mc.addKeymapLayer(function(layerSet)
    -- Select a different cursor as the main one.
    -- layerSet({ "n", "x" }, "<left>", mc.prevCursor)
    -- layerSet({ "n", "x" }, "<right>", mc.nextCursor)

    -- Delete the main cursor.
    -- layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

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
