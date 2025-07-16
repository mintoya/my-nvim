local vim = vim

vim.lsp.enable({
	-- "gopls",
	"lua_ls",
	"gdscript",
	"clangd",
	"qmlls",
	-- "glsl_analyzer",
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

require("conform").setup({
	formatting = {
		format = require("nvim-highlight-colors").format,
	},
	log_level = vim.log.levels.DEBUG,
	notify_on_error = true,
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		qml = { "qmlformat" },
		sh = { "shfmt" },
		c = { "clang-format" },
	},

	formatters = {
		qmlformat = {
			command = "qmlformat",
			args = { "-i", "$FILENAME" },
			stdin = false,
			tmpfile_format = ".conform.$RANDOM.$FILENAME",
		},
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
