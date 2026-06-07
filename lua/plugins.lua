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
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  },

  {
    "chrisgrieser/nvim-scissors",
    opts = { snippetDir = snippetDir },
  },


  {
    "jake-stewart/multicursor.nvim",
    main = "multicursor-nvim",
    config = function()
      local mc = require "multicursor-nvim"
      mc.setup {}
      mc.addKeymapLayer(function(layerSet)
        layerSet("n", "<esc>", function()
          require "multicursor-nvim".clearCursors()
        end)
      end)
    end
  },
  -- { "rachartier/tiny-inline-diagnostic.nvim", opts = {}, },
  -- colorshcemes
  { "nitinbhat972/cwal.nvim", },
  { "vague-theme/vague.nvim", opts = { transparent = true } },
  { "catppuccin/nvim", },
  { "folke/tokyonight.nvim", },
  { "smlx/nocte" },

  {
    "folke/trouble.nvim",
    opts = {},
  },
  {
    "lambdalisue/vim-suda",
    cmd = { "SudaRead", "SudaWrite" }
  },
  { "smoka7/hop.nvim",  opts = {} },
  { "ii14/neorepl.nvim" },
  -- { "OXY2DEV/markview.nvim", opts = { preview = { icon_provider = "mini", } } },
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
