local vim = vim
local conform = require("conform")
local snacks = require("snacks")
local keymaps = {
	{ "v", "<<", "<gv", { noremap = false, silent = false } },
	{ "v", ">>", ">gv", { noremap = false, silent = false } },
	{ "n", ";", ":", { noremap = false, silent = false } },
	{ "n", "y", '"+y', { noremap = true, silent = true } },
	{ "v", "y", '"+y', { noremap = true, silent = true } },
	{ "t", "<Esc>", [[<C-\><C-n>]], { noremap = true } },
	{ "t", "<C-w>", [[<C-\><C-n><C-w>]], { noremap = true, silent = true } },
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
	{ "n", "<leader>e", ":Oil<CR><C-p>", { desc = "Open yazi at the current file", noremap = true, silent = true } },
	{ "n", "<leader>x", ":bd<CR>", { desc = "close buffer", noremap = true, silent = true } },
	{ "n", "<C-j>", "10j", { desc = "down 10", noremap = true, silent = true } },
	{ "n", "<C-k>", "10k", { desc = "up 10", noremap = true, silent = true } },
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
vim.keymap.set("n", "<leader>r", require("special").rename, {
	noremap = true,
	silent = true,
	desc = "Lsp Rename",
})
vim.keymap.set("n", "<leader>p", require("special").snipe, {
	noremap = true,
	silent = true,
	desc = "snipe pinned files",
})
vim.keymap.set("n", "<Esc>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch")
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fm", function()
	conform.format()
end, { noremap = true, silent = true })
