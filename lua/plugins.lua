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
local luaLineConfigOptions = {
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
    theme = 'auto',
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '  ' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {
      '%=', --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '  ' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
local blinkMap = {
  ['<C-e>'] = { 'hide' },
  ['<C-l>'] = { 'select_and_accept' },

  ['<C-k>'] = { 'select_prev', 'fallback' },
  ['<C-j>'] = { 'select_next', 'fallback' },

  ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

  ['<Tab>'] = { 'snippet_forward', 'fallback' },
  ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
}

local blinkOpts = {
  keymap = blinkMap,
  appearance = {
    use_nvim_cmp_as_default = false,
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
      markdown = formatters.prettierd,
      sh = formatters.shfmt,
      vhdl = formatters.vsg,
      typescript = formatters.prettierd,
      typescriptreact = formatters.prettierd,
      yaml = formatters.lsp,
      js = formatters.prettier,
      javascript = formatters.prettier,
      html = formatters.prettier,
    },

    fallback_formatter = {
      formatters.remove_trailing_whitespace,
      formatters.remove_trailing_newlines,
    },
    run_with_sh = false,
  })
end
local tinyInlineDiagnostics =

{
  options = {
    enable_on_insert = true,
    multilines = {
      enabled = true,
    }
  }
}
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
  { "dgox16/oldworld.nvim", opts = {} },
  { "mintoya/rainglow-vim",              as = "rainglow" },
  { "catppuccin/nvim",                   name = "catppuccin" },
  { "folke/tokyonight.nvim",             opts = { style = "storm" } },
  { "vague2k/vague.nvim",                opts = { transparent = true } },

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
    dependencies = { "nvim-lua/plenary.nvim", "andrew-george/telescope-themes" },
    opts = telescopeConfig,
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = 'H',
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
    dependencies = { "kyazdani42/nvim-web-devicons", },

    config = function()
      local auto_theme_custom = require('lualine.themes.auto')
      auto_theme_custom.normal.c.bg = 'none'
      auto_theme_custom.visual.c.bg = 'none'
      auto_theme_custom.insert.c.bg = 'none'
      auto_theme_custom.command.c.bg = 'none'
      auto_theme_custom.terminal.c.bg = 'none'
      luaLineConfigOptions.options.theme = auto_theme_custom
      require('lualine').setup(luaLineConfigOptions)
    end,
  },

  { "sphamba/smear-cursor.nvim",    opts = {}, },
  { "rachartier/tiny-glimmer.nvim", opts = {}, },
  { -- the screen that pops up at the beginning
    "goolord/alpha-nvim",
    config = function() require("alpha").setup(require("welcome").config) end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "WinEnter",
    priority = 1000, -- needs to be loaded in first
    opts = tinyInlineDiagnostics,
  },
  { "wurli/visimatch.nvim",                opts = {} },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function() require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath("config") .. "/snippets" }, } end,
    build = "make install_jsregexp",
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "nvim-telescope/telescope.nvim", },
    opts = { snippetDir = vim.fn.stdpath("config") .. "/snippets", }
  },

  -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = { 'nvimtools/hydra.nvim', },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
  },
  { "leath-dub/snipe.nvim", opts = {} },
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
  },
  {
      'brianhuster/live-preview.nvim',
      dependencies = {
          -- You can choose one of the following pickers
          'nvim-telescope/telescope.nvim',
          'ibhagwan/fzf-lua',
          'echasnovski/mini.pick',
      },
  },
}

return plugins
