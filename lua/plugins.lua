return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", },
      { "jay-babu/mason-nvim-dap.nvim", },
      { "mfussenegger/nvim-dap", },
      { "neovim/nvim-lspconfig", }
    },
    lazy = false,
  },

  {
    "chrisgrieser/nvim-scissors",
    opts = { snippetDir = snippetDir },
    lazy = false,
  },


  {
    "jake-stewart/multicursor.nvim",
    lazy = false,
    opts = {},
    main = "multicursor-nvim"
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    opts = {},
  },
  { "vague-theme/vague.nvim", },
  { "catppuccin/nvim", },
  { "folke/tokyonight.nvim", },

  {
    "folke/trouble.nvim",
    opts = {},
  },
  {
    "lambdalisue/vim-suda",
    cmd = { "SudaRead", "SudaWrite" }
  },
  {
    "folke/flash.nvim",
    opts = {},
  },
  { "ii14/neorepl.nvim" },
  { "OXY2DEV/markview.nvim", opts = { preview = { icon_provider = "mini", } } },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "sschleemilch/slimline.nvim",
    opts = {
      style = "fg",
      -- disabled_filetypes = {},
      components = {
        left = {
          'mode',
          'path',
          'git',
        },
        right = {
          'diagnostics',
          'filetype_lsp',
          'progress',
        },
      },
      configs = {
        mode = {
          style = "bg"
        },
        progress = {
          style = "bg",
          follow = "mode",
          column = true,
          hl = {
            primary = "Function",
            secondary = "Function",
          }
        },


      },
    },
  }
}
