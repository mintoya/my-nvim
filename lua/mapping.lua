local vim = vim

local snipJumpNext = function()
  if vim.snippet.active({ direction = 1 }) then
    vim.schedule(function()
      vim.snippet.jump(1)
    end)
    return ""
  else
    return "<Tab>"
  end
end
local snipJumpPrev = function()
  if vim.snippet.active({ direction = -1 }) then
    vim.schedule(function()
      vim.snippet.jump(-1)
    end)
    return ""
  else
    return "<S-Tab>"
  end
end


local keymaps = {
  { "n", ";",     ":",                                               { noremap = false, silent = false } },

  { "v", "<<",    "<gv",                                             { desc = "unindent visual", noremap = false, silent = false } },
  { "v", ">>",    ">gv",                                             { desc = "indent visual", noremap = false, silent = false } },

  { "n", "y",     '"+y',                                             { noremap = true, silent = true } },
  { "v", "y",     '"+y',                                             { noremap = true, silent = true } },

  { "n", "<Esc>", ":nohlsearch<cr>",                                 { noremap = false, silent = true } },
  { "n", "<Tab>", "<C-w>",                                           { desc = "buffer actions", noremap = true, silent = true } },

  { "t", "<Esc>", [[<C-\><C-n>]],                                    { noremap = true } },
  { "t", "<C-w>", [[<C-\><C-n><C-w>]],                               { noremap = true, silent = true } },

  { "t", "<C-l>", [[<C-l><C-\><C-n>:TermClear<cr>:startinsert<cr>]], { noremap = true, silent = true } },

  { "n", "<C-j>", "10jzzz",                                          { desc = "down 10", noremap = true, silent = true } },
  { "n", "<C-k>", "10kzzz",                                          { desc = "up 10", noremap = true, silent = true } },

  { { "i",            "c" },
    "<C-j>", "<C-n>", { desc = "down 10", noremap = true, silent = true } },
  { { "i",          "c" },
    "<C-k>", "<C-p>", { desc = "up 10", noremap = true, silent = true } },
  { "i",  "<C-l>",      "<C-x><C-y>",                                       { desc = "up 10", noremap = true, silent = true } },

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
  { "n",  "<leader>t",  "",                                                 { desc = "open terminal", silent = true } },
  { "n",  "<leader>tl", ":vsplit|terminal<cr>:startinsert<cr>",             { desc = "open terminal right", silent = true } },
  { "n",  "<leader>tk", ":above split | terminal<cr>:startinsert<cr>",      { desc = "open terminal up", silent = true } },
  { "n",  "<leader>tj", ":belowright split | terminal<cr>:startinsert<cr>", { desc = "open terminal down", silent = true } },
  { "n",  "<leader>th", ":leftabove vsplit|terminal<cr>:startinsert<cr>",   { desc = "open terminal left", silent = true } },

  { "n",  "<leader>b",  "",                                                 { desc = "open pane", silent = true } },
  { "n",  "<leader>bl", ":vsplit<cr>:Fyler kind=replace<CR>",               { desc = "open pane right", silent = true } },
  { "n",  "<leader>bk", ":above split<cr>:Fyler kind=replace<CR>",          { desc = "open pane up", silent = true } },
  { "n",  "<leader>bj", ":belowright split<cr>:Fyler kind=replace<CR>",     { desc = "open pane down", silent = true } },
  { "n",  "<leader>bh", ":leftabove vsplit<cr>:Fyler kind=replace<CR>",     { desc = "open pane left", silent = true } },

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

  { "n",          "<leader>s", "",           { desc = "Snippet" }, },
  { "n",
    "<leader>se",
    function() require("scissors").editSnippet() end,
    { desc = "Snippet: Edit" },
  },
  { "n", "<leader>sa",
    function() require("scissors").addNewSnippet() end,
    { desc = "Snippet: Add" },
  },

  { "n", "<leader>fm",
    ":lua vim.lsp.buf.format()<cr>",
    { desc = "Format buffer" },
  },
  { "n", "<leader>rn",
    ":lua vim.lsp.buf.rename()<cr>", { desc = "lsp rename", silent = true },
  },
  { { "i", "s" }, "<Tab>",     snipJumpNext, { expr = true, noremap = true } },
  { { "i", "s" }, "<S-Tab>",   snipJumpPrev, { expr = true, noremap = true } },

}
for _, keymap in ipairs(keymaps) do
  local mode = keymap[1]
  local lhs = keymap[2]
  local rhs = keymap[3]
  local opts = keymap[4]
  vim.keymap.set(mode, lhs, rhs, opts)
end


return function()
  local mc = require("multicursor-nvim")
  mc.setup()

  local set = vim.keymap.set

  set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
  set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
  set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
  set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

  -- set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
  -- set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
  -- set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
  -- set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

  -- Add and remove cursors with control + left click.
  set("n", "<c-leftmouse>", mc.handleMouse)
  set("n", "<c-leftrelease>", mc.handleMouseRelease)

  mc.addKeymapLayer(function(layerSet)
    layerSet("n", "<esc>", function()
      mc.clearCursors()
    end)
  end)
end
