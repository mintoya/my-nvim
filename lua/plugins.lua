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
  -- require("mini.completion").setup({})
  require("mini.comment").setup({
    mappings = {
      comment = "gc",
      comment_line = "<leader>/",
      comment_visual = "<leader>/",
      textobject = "gc",
    },
  })
  require("mini.map").setup({})
end
local luaLineConfigOptions = {
  options = {
    component_separators = "",
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "Outline" },
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = " ", right = "" }, icon = "" },
    },
    lualine_b = {
      {
        "filetype",
        icon_only = true,
        padding = { left = 1, right = 0 },
      },
      "filename",
    },
    lualine_c = {
      {
        "branch",
        icon = "",
      },
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        colored = false,
      },
    },
    lualine_x = {
      {
        "diagnostics",
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        update_in_insert = true,
      },
    },
    lualine_y = { clients_lsp },
    lualine_z = {
      { "location", separator = { left = "", right = " " }, icon = "" },
    },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  extensions = { "toggleterm", "trouble" },
}
local blinkMap = {
  ['<C-e>'] = { 'hide' },
  ['<C-l>'] = { 'select_and_accept' },

  ['<C-j>'] = { 'select_prev', 'fallback' },
  ['<C-k>'] = { 'select_next', 'fallback' },

  ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

  ['<Tab>'] = { 'snippet_forward', 'fallback' },
  ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
}

local blinkOpts = {
  keymap = blinkMap,
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}
local formatConfig = function()
  local format_on_save = require("format-on-save")
  local formatters = require("format-on-save.formatters")
  format_on_save.setup({
    exclude_path_patterns = {
      "/node_modules/",
      ".local/share/nvim/lazy",
    },
    formatter_by_ft = {
      css = formatters.lsp,
      c = formatters.lsp,
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
    },

    fallback_formatter = {
      formatters.remove_trailing_whitespace,
      formatters.remove_trailing_newlines,
    },
    run_with_sh = false,
  })
end

local noiceConfig = {}
local plugins = {
  { "williamboman/mason.nvim",           opts = {}, },
  { "williamboman/mason-lspconfig.nvim", opts = {}, },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    opts = {},
  },
  { "folke/snacks.nvim",     opts = snacksConfig },
  {
    "folke/noice.nvim",
    opts = noiceConfig,
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", },
  },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "hrsh7th/cmp-nvim-lsp" },
  { "neovim/nvim-lspconfig" },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = miniConfig,
  },

  -- color schemes
  {
    "dgox16/oldworld.nvim", opts = {}
  },
  { "mintoya/rainglow-vim",  as = "rainglow" },
  { "catppuccin/nvim",       name = "catppuccin" },
  { "folke/tokyonight.nvim", opts = { style = "storm" } },
  { "vague2k/vague.nvim",    opts = { transparent = true } },
  {
    "rjshkhr/shadow.nvim",
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("shadow")
    end,
  },
  { "elentok/format-on-save.nvim",       config = formatConfig },
  { "hrsh7th/nvim-cmp" },
  { "brenoprata10/nvim-highlight-colors" },
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = blinkOpts,
    opts_extend = { "sources.default" }
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim", "andrew-george/telescope-themes" },
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
  -- {
  --     "nvim-neo-tree/neo-tree.nvim",
  --     dependencies = { "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
  --     opts = {
  --         filesystem = {
  --             filtered_items = {
  --                 visible = true,
  --             },
  --         },
  --         window = {
  --             width = 20,
  --         },
  --     },
  -- },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
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
  { "akinsho/toggleterm.nvim",      version = "*", config = true },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup(luaLineConfigOptions)
    end,
  },
  { "sphamba/smear-cursor.nvim",    opts = {}, },
  { "rachartier/tiny-glimmer.nvim", opts = {}, },
  { -- the screen that pops up at the beginning
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("welcome").config)
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "WinEnter",
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup(
        {
          options = {
            enable_on_insert = true,
            multilines = {
              enabled = true,
            }
          }
        }
      )
    end
  },
  -- {
  --     "ErichDonGubler/lsp_lines.nvim",
  --     config = function()
  --         require("lsp_lines").setup()
  --     end
  -- },
  {
    "wurli/visimatch.nvim",
    opts = {}
  },
  --snippets
  --vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lazy")

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      }
    end,
    build = "make install_jsregexp",
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
    }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
}

return plugins
