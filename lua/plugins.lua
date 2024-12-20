local lspOptions = {
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        css = { "prettier" },
        html = { "prettier" },
    },
    format_on_save = {
        timeout_ms = 200,
        lsp_fallback = true,
    },
}
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
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'NvimTree', 'packer', 'fugitive' }, -- Disable on certain filetypes
        icons_enabled = true,                                      -- Enable file icons
    },
    sections = {
        lualine_a = { 'mode' },                               -- Leftmost section: show mode (insert, normal, etc.)
        lualine_b = { 'branch', 'diff' },                     -- Branch and git diff information
        lualine_c = { 'filename' },                           -- Current filename
        lualine_x = { 'filetype', 'encoding', 'fileformat' }, -- Filetype, encoding, file format
        lualine_y = { 'progress' },                           -- Show progress through file
        lualine_z = { 'location' },                           -- Line and column number
    },
    extensions = { 'fugitive', 'nvim-tree', 'quickfix' }
}
local noiceConfig = {}
local plugins = {
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
    { "neovim/nvim-lspconfig" },
    { "stevearc/conform.nvim", opts = lspOptions },
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
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("welcome").config)
        end,
    },
    { "akinsho/toggleterm.nvim", version = "*", config = true },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('lualine').setup(luaLineConfigOptions);
        end
    },
}

return plugins
