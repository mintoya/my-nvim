local snacksConfig = {
	styles = {
		position = "float",
		backdrop = 60,
		height = 0.9,
		width = 0.9,
		zindex = 50,
	},
	lazygit = {},
	notifier = {},
	win = {
		position = "float",
		backdrop = 60,
		height = 0.9,
		width = 0.9,
		zindex = 50,
	},
}

local telescopeConfig = {
	defaults = {
		layout_strategy = "flex",
		vimgrep_arguments = {
			"rg",
			"--no-heading", -- No headings in the result
			"--with-filename", -- Show filenames
			"--line-number", -- Show line numbers
			"--column", -- Show column numbers
		},
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
			file_files = {
				enable_preview = true,
			},
		},
	},
}
local miniConfig = function()
	require("mini.comment").setup({
		mappings = {
			comment = "gc",
			comment_line = "<leader>/",
			comment_visual = "<leader>/",
			textobject = "gc",
		},
	})
	require("mini.misc").setup_termbg_sync()
end

local blinkMap = {
	["<C-e>"] = { "hide" },
	["<C-l>"] = { "select_and_accept" },

	["<C-k>"] = { "select_prev", "fallback" },
	["<C-j>"] = { "select_next", "fallback" },

	["<C-b>"] = { "scroll_documentation_up", "fallback" },
	["<C-f>"] = { "scroll_documentation_down", "fallback" },

	["<Tab>"] = { "snippet_forward", "fallback" },
	["<S-Tab>"] = { "snippet_backward", "fallback" },
}

local blinkOpts = {
	keymap = blinkMap,
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
}

-- local tinyInlineDiagnostics = {
-- 	options = {
-- 		enable_on_insert = true,
-- 		multilines = { enabled = true },
-- 	},
-- }
local plugins = {
	{ "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },

	{ "williamboman/mason.nvim", opts = {} },
	{ "folke/snacks.nvim", opts = snacksConfig },
	{ "michaeljsmith/vim-indent-object" },
	{ "folke/noice.nvim", opts = {}, dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{ "hrsh7th/cmp-nvim-lsp" },

	{ "hrsh7th/nvim-cmp" },
	{ "stevearc/conform.nvim" },
	{ "neovim/nvim-lspconfig" },

	{ "echasnovski/mini.nvim", version = false, config = miniConfig },

	-- color schemes
	{ "dgox16/oldworld.nvim", opts = {} },
	-- { "mintoya/rainglow-vim", as = "rainglow" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "folke/tokyonight.nvim", opts = { style = "storm" } },
	{ "vague2k/vague.nvim", opts = { transparent = false } },
	{ "ellisonleao/gruvbox.nvim", config = true },
	{ "Tsuzat/NeoSolarized.nvim", lazy = false },

	{ "goolord/alpha-nvim" },
	{ "brenoprata10/nvim-highlight-colors" },
	{ "tpope/vim-sleuth" },
	-- { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },

	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = blinkOpts,
		opts_extend = { "sources.default" },
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "andrew-george/telescope-themes" },
		opts = telescopeConfig,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },

	-- { "sphamba/smear-cursor.nvim", opts = {} },
	{ "rachartier/tiny-glimmer.nvim", opts = {} },
	-- {
	-- 	"rachartier/tiny-inline-diagnostic.nvim",
	-- 	event = "WinEnter",
	-- 	priority = 1000, -- needs to be loaded in first
	-- 	opts = tinyInlineDiagnostics,
	-- },

	{ "wurli/visimatch.nvim", opts = { chars_lower_limit = 3 } },
	{
		"chrisgrieser/nvim-scissors",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = { snippetDir = vim.fn.stdpath("config") .. "/snippets" },
	},

	-- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, },
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = { "nvimtools/hydra.nvim" },
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
	},
	{ "leath-dub/snipe.nvim", opts = {} },
	{
		"brianhuster/live-preview.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"sschleemilch/slimline.nvim",
		opts = { style = "bg" },
	},
	{ "lommix/godot.nvim" },
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}

return plugins
