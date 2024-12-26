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
local miniConfig = function()
    require("mini.completion").setup({})
    -- require("mini.animate").setup()
    require("mini.comment").setup({
        mappings = {
            comment = "gc",
            comment_line = "<leader>/",
            comment_visual = "<leader>/",
            textobject = "gc",
        },
    })
end
local luaLineConfigOptions = {
    options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "NvimTree", "packer", "fugitive" }, -- Disable on certain filetypes
        icons_enabled = true,                                      -- Enable file icons
    },
    sections = {
        lualine_a = { "mode" },                               -- Leftmost section: show mode (insert, normal, etc.)
        lualine_b = { "branch", "diff" },                     -- Branch and git diff information
        lualine_c = { "filename" },                           -- Current filename
        lualine_x = { "filetype", "encoding", "fileformat" }, -- Filetype, encoding, file format
        lualine_y = { "progress" },                           -- Show progress through file
        lualine_z = { "location" },                           -- Line and column number
    },
    extensions = { "fugitive", "nvim-tree", "quickfix" },
}
local noiceConfig = {}
local plugins = {
    {
        "mintoya/example.nvim",
        dir = vim.fn.stdpath("config") .. "/nvPlug/example.nvim",
        opts = { a = "hello", b = "world" },
        dependencies = { "MunifTanjim/nui.nvim" },
    },
    -- { "catppuccin/nvim",   name = "catppuccin" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            term_colors = true,
            transparent_background = false,
            color_overrides = {
                mocha = {
                    base = "#000000",
                    mantle = "#000000",
                    crust = "#000000",
                },
            },
            integrations = {
                -- telescope = {
                --     enabled = true,
                --     style = "nvchad",
                -- },
                dropbar = {
                    enabled = true,
                    color_mode = true,
                },
            },
        },
    },
    { "folke/snacks.nvim",    opts = snacksConfig },
    {
        "folke/noice.nvim",
        opts = noiceConfig,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    { "L3MON4D3/LuaSnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "neovim/nvim-lspconfig" },
    {
        "echasnovski/mini.nvim",
        version = false,
        config = miniConfig,
    },
    { "rainglow/vim",          as = "rainglow" },
    { "folke/tokyonight.nvim", opts = { style = "storm" } },
    { "vague2k/vague.nvim",    opts = { transparent = true } },
    -- { "stevearc/conform.nvim", opts = lspOptions },
    {
        -- aint no way it needs to be this long
        "elentok/format-on-save.nvim",
        config = function()
            local format_on_save = require("format-on-save")
            local formatters = require("format-on-save.formatters")
            format_on_save.setup({
                exclude_path_patterns = {
                    "/node_modules/",
                    ".local/share/nvim/lazy",
                },
                formatter_by_ft = {
                    css = formatters.lsp,
                    html = formatters.lsp,
                    java = formatters.lsp,
                    javascript = formatters.lsp,
                    json = formatters.lsp,
                    lua = formatters.lsp,
                    markdown = formatters.prettierd,
                    openscad = formatters.lsp,
                    rust = formatters.lsp,
                    scad = formatters.lsp,
                    scss = formatters.lsp,
                    sh = formatters.shfmt,
                    terraform = formatters.lsp,
                    typescript = formatters.prettierd,
                    typescriptreact = formatters.prettierd,
                    yaml = formatters.lsp,

                    -- Add your own shell formatters:
                    myfiletype = formatters.shell({ cmd = { "myformatter", "%" } }),

                    -- Add lazy formatter that will only run when formatting:
                    -- my_custom_formatter = function()
                    --     if vim.api.nvim_buf_get_name(0):match("/README.md$") then
                    --         return formatters.prettierd
                    --     else
                    --         return formatters.lsp()
                    --     end
                    -- end,
                    -- Add custom formatter
                    -- filetype1 = formatters.remove_trailing_whitespace,
                    -- filetype2 = formatters.custom({
                    --     format = function(lines)
                    --         return vim.tbl_map(function(line)
                    --             return line:gsub("true", "false")
                    --         end, lines)
                    --     end,
                    -- }),
                    python = {
                        formatters.remove_trailing_whitespace,
                        formatters.shell({ cmd = "tidy-imports" }),
                        formatters.black,
                        formatters.ruff,
                    },

                    go = {
                        formatters.shell({
                            cmd = { "goimports-reviser", "-rm-unused", "-set-alias", "-format", "%" },
                            tempfile = function()
                                return vim.fn.expand("%") .. ".formatter-temp"
                            end,
                        }),
                        formatters.shell({ cmd = { "gofmt" } }),
                    },
                },

                fallback_formatter = {
                    formatters.remove_trailing_whitespace,
                    formatters.remove_trailing_newlines,
                    formatters.prettierd,
                },
                run_with_sh = false,
            })
        end
    },
    { "hrsh7th/nvim-cmp" },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_strategy = "flex",
                    vimgrep_arguments = {
                        "rg",
                        "--no-heading",    -- No headings in the result
                        "--with-filename", -- Show filenames
                        "--line-number",   -- Show line numbers
                        "--column",        -- Show column numbers
                    },
                    pickers = {
                        colorscheme = {
                            enable_preview = true,
                        },
                        file_files = {
                            enable_preview = true,
                            previewer = require("telescope.previewers").vim_buffer_cat.new,
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "andrew-george/telescope-themes", "nvim-tree/nvim-web-devicons" },
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                },
            },
            window = {
                width = 20,
            },
        },
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
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup(luaLineConfigOptions)
        end,
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    },
}

return plugins
