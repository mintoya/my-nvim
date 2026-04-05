-- returns mappings that need a plugin to work

--- @alias KeymapEntry {[1]:string|string[], [2]:string, [3]:string|function, [4]?:vim.keymap.set.Opts}
--- @type KeymapEntry[]
local keymaps = {
  { 'n', ';',     ':',                 { noremap = false, silent = false } },

  { { "n",          "v" },
    'y', '"+y', { noremap = true, silent = true } },
  { 'v', "<<",    "<gv",               { desc = "unindent visual", noremap = false, silent = false } },
  { 'v', ">>",    ">gv",               { desc = "indent visual", noremap = false, silent = false } },

  { "n", "<Esc>", ":nohlsearch<cr>",   { noremap = true, silent = true } },
  { "n", "<Tab>", "<C-w>",             { desc = "buffer actions", noremap = true, silent = true } },

  { "t", "<Esc>", [[<C-\><C-n>]],      { noremap = true } },
  { "t", "<C-w>", [[<C-\><C-n><C-w>]], { noremap = true, silent = true } },

  --cmp
  { 'c', '<C-l>', function()
    return vim.fn.wildmenumode() ~= 0 and '<C-L>' or '<C-l>'
  end, { expr = true, noremap = true } },
  { { 'i',        's' }, '<Tab>', function()
    return
        vim.snippet.active({ direction = 1 }) and
        '<Cmd>lua vim.snippet.jump(1)<CR>' or
        '<Tab>'
  end, { desc = '...', expr = true, silent = true } },
  { { 'i',        's' }, '<S-Tab>', function()
    return
        vim.snippet.active({ direction = -1 }) and
        '<Cmd>lua vim.snippet.jump(-1)<CR>' or
        '<S-Tab>'
  end, { desc = '...', expr = true, silent = true }
  },

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
  { "n", "<leader>s",  "",                                                 { desc = "Snippet" }, },


}
--- @type KeymapEntry[]
local keymap_plugins = {

  { { "n" },      "<leader>db",     "",                                                          { desc = "Dap actions" } },
  { { "n" },      "<leader>dbn",    ":DapNew<cr>",                                               { desc = "Dap actions" } },
  { { "n" },      "<leader>dbb",    ":DapToggleBreakpoint<cr>",                                  { desc = "toggle breakpoint" } },
  { { "n" },      "<leader>dbr",    ":DapToggleRepl<cr>",                                        { desc = "open dap repl" } },





  { { 'n', 'x' }, "<up>",           function() require "multicursor-nvim".lineAddCursor(-1) end },
  { { 'n', 'x' }, "<down>",         function() require "multicursor-nvim".lineAddCursor(1) end },
  { { 'n', 'x' }, "<leader><up>",   function() require "multicursor-nvim".lineSkipCursor(-1) end },
  { { 'n', 'x' }, "<leader><down>", function() require "multicursor-nvim".lineSkipCursor(1) end },


  -- { "n",               "<c-leftmouse>",   require "multicursor-nvim".handleMouse },
  -- { "n",               "<c-leftrelease>", require "multicursor-nvim".handleMouseRelease },

  -- { { "n", "x", "o" }, "<C-f>",          require "flash".jump,                                        { desc = "Flash" } },
  { "n", "<leader>fm",
    function() vim.lsp.buf.format() end,
    { desc = "Format buffer" },
  },
  { "n", "<leader>rn",
    function() vim.lsp.buf.rename() end, { desc = "lsp rename", silent = true },
  },
  { 'n',
    "<leader>se",
    function() require "scissors".editSnippet() end,
    { desc = "Snippet: Edit" }
  },
  { 'n', "<leader>sa",
    function() require "scissors".addNewSnippet() end,
    { desc = "Snippet: Add" }
  },
  { { 'n', 'x', 'o' }, '<C-f>', ':HopPattern<cr>' },
}
local set = vim.keymap.set
local array = require "special".metatables.array
array.new():append(keymaps):append(keymap_plugins):each(function(keymap, _)
  set(keymap[1], keymap[2], keymap[3], keymap[4])
end)

return function()
  local MiniKeymap = _G.MiniKeymap
  MiniKeymap.map_multistep({ 'i', 'c' }, '<C-j>', { 'pmenu_next' })
  MiniKeymap.map_multistep({ 'i', 'c' }, '<C-k>', { 'pmenu_prev' })
  MiniKeymap.map_multistep({ 'i', 'c' }, '<C-l>', { 'pmenu_accept' })

  MiniKeymap.map_combo({ 'n', 'i' }, '<C-w>>', '<C-w>', { delay = 100 })
  MiniKeymap.map_combo({ 'n', 'i' }, '<C-w><', '<C-w>', { delay = 100 })


  local MiniFiles = _G.MiniFiles
  set('n', "<leader>e",
    MiniFiles.open,
    { desc = "edit files", noremap = true, silent = true }
  )

  local MiniPick = _G.MiniPick
  local MiniExtra = _G.MiniExtra
  set("n", "<leader>c",
    MiniExtra.pickers.colorschemes,
    { desc = "change colorscheme", noremap = true, silent = true }
  )
  set("n", "<leader>fb",
    MiniPick.builtin.buffers,
    { desc = "find buffers", noremap = true, silent = true }
  )
  set({ "n" }, "<leader>ff", MiniPick.builtin.files, { desc = "find files" })
  set({ "n" }, "<leader>ft", MiniPick.builtin.grep_live, { desc = "find text in files" })
  set({ "n" }, "<leader>fh", MiniPick.builtin.resume, { desc = "recently opened" })
end
