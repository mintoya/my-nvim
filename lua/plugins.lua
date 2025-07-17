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

local plugins = {
	{ "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },

	{ "williamboman/mason.nvim", opts = {} },
	{ "michaeljsmith/vim-indent-object" },
	{ "folke/snacks.nvim", opts = snacksConfig },
	{ "folke/noice.nvim", opts = {}, dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{ "hrsh7th/cmp-nvim-lsp" },

	{ "hrsh7th/nvim-cmp" },
	{ "stevearc/conform.nvim" },
	{ "neovim/nvim-lspconfig" },

	{ "echasnovski/mini.nvim", version = false, config = miniConfig },

	-- color schemes
	{ "dgox16/oldworld.nvim", opts = {} },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "folke/tokyonight.nvim", opts = { style = "storm" } },
	{ "vague2k/vague.nvim", opts = { transparent = false } },
	{ "ellisonleao/gruvbox.nvim", config = true },
	{ "Tsuzat/NeoSolarized.nvim", lazy = false },

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "brenoprata10/nvim-highlight-colors" },
	{ "tpope/vim-sleuth" },

	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = blinkOpts,
		opts_extend = { "sources.default" },
	},

	{
		"nvim-telescope/telescope.nvim",
		opts = telescopeConfig,
		dependencies = { "andrew-george/telescope-themes" },
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("themes")
		end,
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
	-- used in windos
	{ "rachartier/tiny-glimmer.nvim", opts = {} },

	{ "wurli/visimatch.nvim", opts = { chars_lower_limit = 3 } },
	{
		"chrisgrieser/nvim-scissors",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = { snippetDir = vim.fn.stdpath("config") .. "/snippets" },
	},

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
		opts = { style = "bg", disabled_filetypes = {} },
	},
	{ "lommix/godot.nvim" },
	{
		"kyazdani42/nvim-tree.lua",
		opts = {
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				-- Important: When you supply an `on_attach` function, nvim-tree won't
				-- automatically set up the default keymaps. To set up the default keymaps,
				-- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
				api.config.mappings.default_on_attach(bufnr)

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				local preview = require("nvim-tree-preview")

				vim.keymap.set("n", "P", preview.watch, opts("Preview (Watch)"))
				vim.keymap.set("n", "<Esc>", preview.unwatch, opts("Close Preview/Unwatch"))
				vim.keymap.set("n", "<C-f>", function()
					return preview.scroll(4)
				end, opts("Scroll Down"))
				vim.keymap.set("n", "<C-b>", function()
					return preview.scroll(-4)
				end, opts("Scroll Up"))

				-- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
				vim.keymap.set("n", "<Tab>", function()
					local ok, node = pcall(api.tree.get_node_under_cursor)
					if ok and node then
						if node.type == "directory" then
							api.node.open.edit()
						else
							preview.node(node, { toggle_focus = true })
						end
					end
				end, opts("Preview"))

				-- Option B: Simple tab behavior: Always preview
				-- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
			end,
		},
		dependencies = {
			{
				"b0o/nvim-tree-preview.lua",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"3rd/image.nvim", -- Optional, for previewing images
				},
			},
		},
	},
}

return plugins
