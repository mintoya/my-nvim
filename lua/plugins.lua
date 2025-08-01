local vim = vim
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
			"--column",     -- Show column numbers
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
	require("mini.pairs").setup()
	require("mini.surround").setup()
	-- require("mini.tabline").setup()
	require("mini.notify").setup()
	require("mini.misc").setup_termbg_sync()
	local picker = require("mini.pick")
	picker.registry.colors = function()
		return picker.start({
			mappings = {
				newStop = {
					char = "<Esc>",
					func = function()
						require("current-theme")
						vim.cmd(
							[[lua ]]
							.. (require("special").file.read(vim.fn.stdpath("config") .. "/lua/current-theme.lua"))
						)
						picker.stop()
					end,
				},
			},
			source = {
				name = "colors",
				items = vim.fn.getcompletion("", "color"),
				choose = function(item, modifier)
					require("special").file.write(
						vim.fn.stdpath("config") .. "/lua/current-theme.lua",
						[[vim.cmd("colorscheme ]] .. item .. [[")]]
					)

					print("set colorscheme to ", item)
					vim.cmd("colorscheme " .. item)
				end,
				preview = function(bufnr, item)
					vim.cmd("colorscheme " .. item)

					local sometext = {
						[[local function name (arg1,arg2)]],
						[[	for k,v in pairs(arg1) do]],
						[[		print(v==arg2)]],
						[[	end]],

						[[end]],
					}
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, sometext)
					pcall(vim.treesitter.start, bufnr, "lua")
				end,
			},
		})
	end
	picker.setup()
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

local plugins = {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
	},

	{ "williamboman/mason.nvim",        opts = {} },
	{ "michaeljsmith/vim-indent-object" },
	{ "folke/snacks.nvim",              opts = snacksConfig },
	{
		"folke/noice.nvim",
		opts = {},
		dependencies = {"ibhagwan/fzf-lua", "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{ "hrsh7th/cmp-nvim-lsp" },

	{ "hrsh7th/nvim-cmp" },
	{ "neovim/nvim-lspconfig" },

	{ "echasnovski/mini.nvim",    version = false,               config = miniConfig },

	-- color schemes
	{ "dgox16/oldworld.nvim",     opts = {} },
	{ "catppuccin/nvim",          name = "catppuccin" },
	{ "folke/tokyonight.nvim",    opts = { style = "storm" } },
	{ "vague2k/vague.nvim",       opts = { transparent = false } },
	{ "ellisonleao/gruvbox.nvim", config = true },
	{ "Tsuzat/NeoSolarized.nvim", lazy = false },

	{
		"nvimdev/dashboard-nvim",
		lazy = false,
		opts = require("welcome"),
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "brenoprata10/nvim-highlight-colors" },
	{ "tpope/vim-sleuth" },

	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = {
			keymap = blinkMap,
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
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

	-- { "sphamba/smear-cursor.nvim", opts = {} },
	-- used in windos
	{ "rachartier/tiny-glimmer.nvim", opts = {} },

	{ "wurli/visimatch.nvim",         opts = { chars_lower_limit = 3 } },
	{
		"chrisgrieser/nvim-scissors",
		-- dependencies = { "nvim-telescope/telescope.nvim" },
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
		-- dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"sschleemilch/slimline.nvim",
		opts = { style = "bg", disabled_filetypes = {} },
	},
	-- { "lommix/godot.nvim" },
	{
		"mintoya/Otree.nvim",
		lazy = false,
		dependencies = {
			"stevearc/oil.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			keymaps = {
				["<CR>"] = "actions.select_then_close",
			},
		},
	},
}

return plugins
