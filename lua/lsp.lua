local vim = vim

vim.lsp.enable({
	-- "gopls",
	"lua_ls",
	"gdscript",
	"clangd",
	"qmlls",
  "arduino",
})

vim.diagnostic.config({
	virtual_lines = true,
	virtual_text = false,
	underline = false,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

