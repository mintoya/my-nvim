local vim = vim

local keymaps = {
  { 'n', ';',  ':',   { noremap = false, silent = false } },

  { 'v', "<<", "<gv", { desc = "unindent visual", noremap = false, silent = false } },
  { 'v', ">>", ">gv", { desc = "indent visual", noremap = false, silent = false } },

  { { "n",          "v" },
    'y', '"+y', { noremap = true, silent = true } },

  { "n", "<Esc>", ":nohlsearch<cr>",   { noremap = true, silent = true } },
  { "n", "<Tab>", "<C-w>",             { desc = "buffer actions", noremap = true, silent = true } },

  { "t", "<Esc>", [[<C-\><C-n>]],      { noremap = true } },
  { "t", "<C-w>", [[<C-\><C-n><C-w>]], { noremap = true, silent = true } },

  --cmp
  { 'c', '<C-l>', function()
    return vim.fn.wildmenumode() ~= 0 and '<C-L>' or '<C-l>'
  end, { expr = true, noremap = true } },

  -- folds
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


  -- open terminal
  { "n", "<leader>t",  "",                                                 { desc = "open terminal", silent = true } },
  { "n", "<leader>tl", ":vsplit|terminal<cr>:startinsert<cr>",             { desc = "open terminal right", silent = true } },
  { "n", "<leader>tk", ":above split | terminal<cr>:startinsert<cr>",      { desc = "open terminal up", silent = true } },
  { "n", "<leader>tj", ":belowright split | terminal<cr>:startinsert<cr>", { desc = "open terminal down", silent = true } },
  { "n", "<leader>th", ":leftabove vsplit|terminal<cr>:startinsert<cr>",   { desc = "open terminal left", silent = true } },

  { "n", "<leader>b",  "",                                                 { desc = "open pane", silent = true } },
  { "n", "<leader>bl", ":vsplit<cr>",                                      { desc = "open pane right", silent = true } },
  { "n", "<leader>bk", ":above split<cr>",                                 { desc = "open pane up", silent = true } },
  { "n", "<leader>bj", ":belowright split<cr>",                            { desc = "open pane down", silent = true } },
  { "n", "<leader>bh", ":leftabove vsplit<cr>",                            { desc = "open pane left", silent = true } },

  { "n", "<leader>f",  "",                                                 { desc = "find/format" } },
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
  { "n", "yaa",       "ggyG", { desc = "yank all", noremap = true, silent = true } },
  {
    "n",
    "<leader>fh",
    ":Pick resume<CR>",
    { desc = "recently opened", noremap = true, silent = true },
  },


  { "n", "<leader>s", "",     { desc = "Snippet" }, },

  { "n", "<leader>fm",
    function() vim.lsp.buf.format() end,
    { desc = "Format buffer" },
  },
  { "n", "<leader>rn",
    function() vim.lsp.buf.rename() end, { desc = "lsp rename", silent = true },
  },

}
for _, keymap in ipairs(keymaps) do
  local mode = keymap[1]
  local lhs = keymap[2]
  local rhs = keymap[3]
  local opts = keymap[4]
  vim.keymap.set(mode, lhs, rhs, opts)
end

return function()
  local mc = require "multicursor-nvim"
  mc.setup()

  local set = vim.keymap.set


vim.keymap.set({ 'i', 's' }, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
      return '<Cmd>lua vim.snippet.jump(1)<CR>'
    else
      return '<Tab>'
    end
  end, { desc = '...', expr = true, silent = true })
  vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
    if vim.snippet.active({ direction = -1 }) then
      return '<Cmd>lua vim.snippet.jump(-1)<CR>'
    else
      return '<S-Tab>'
    end
  end, { desc = '...', expr = true, silent = true })

  -- local jump_next = function()
  --   local session = MiniSnippets.session.get()
  --   if session ~= nil then
  --     MiniSnippets.session.jump('next'); return ''
  --   end
  --   return '\t'
  -- end
  -- local jump_prev = function() MiniSnippets.session.jump('prev') end
  -- vim.keymap.set('i', '<Tab>', jump_next, { expr = true })
  -- vim.keymap.set('i', '<S-Tab>', jump_prev)

  local MiniKeymap = _G.MiniKeymap;
  MiniKeymap.map_multistep({ 'i', 'c' }, '<C-j>', { 'pmenu_next' })
  MiniKeymap.map_multistep({ 'i', 'c' }, '<C-k>', { 'pmenu_prev' })
  MiniKeymap.map_multistep({ 'i', 'c' }, '<C-l>', { 'pmenu_accept' })

  MiniKeymap.map_combo({ 'n', 'i' }, '<C-w>>', '<C-w>', { delay = 100 })
  MiniKeymap.map_combo({ 'n', 'i' }, '<C-w><', '<C-w>', { delay = 100 })

  set('n', "<leader>e",
    function() _G.MiniFiles.open() end,
    { desc = "edit files", noremap = true, silent = true }
  )
  set('n',
    "<leader>se",
    function() require("scissors").editSnippet() end,
    { desc = "Snippet: Edit" }
  )
  set('n', "<leader>sa",
    function() require("scissors").addNewSnippet() end,
    { desc = "Snippet: Add" }
  )

  set('n', "<leader>g",
    function() require 'snacks'.lazygit.open() end,
    { desc = "open local git repo(lazygit)", noremap = true, silent = true }
  )
  set("n", "<leader>c",
    function()
      require "mini.extra".pickers.colorschemes()
    end,
    { desc = "change colorscheme", noremap = true, silent = true }
  )

  set({ 'n', 'x' }, "<up>", function() mc.lineAddCursor(-1) end)
  set({ 'n', 'x' }, "<down>", function() mc.lineAddCursor(1) end)
  set({ 'n', 'x' }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
  set({ 'n', 'x' }, "<leader><down>", function() mc.lineSkipCursor(1) end)






  set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
  set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
  set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
  set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

  -- Add and remove cursors with control + left click.
  set("n", "<c-leftmouse>", mc.handleMouse)
  set("n", "<c-leftrelease>", mc.handleMouseRelease)

  mc.addKeymapLayer(function(layerSet)
    layerSet("n", "<esc>", function()
      mc.clearCursors()
    end)
  end)
end
