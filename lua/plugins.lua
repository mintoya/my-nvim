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
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    build = function(plugin)
      vim.notify("Building blink.cmp with Cargo... This might take a minute.", vim.log.levels.INFO)
      vim.system(
        { "cargo", "build", "--release" },
        { cwd = plugin.path },
        function(out)
          if out.code == 0 then
            vim.schedule(function()
              vim.notify("blink.cmp built successfully!", vim.log.levels.INFO)
            end)
          else
            vim.schedule(function()
              vim.notify("blink.cmp build failed ", vim.log.levels.ERROR)
              vim.print(out.stderr)
            end)
          end
        end
      )
    end,

    opts = {
      keymap = {
        preset = 'none',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-l>'] = { 'select_and_accept', 'fallback' },
      },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust" }
    },
    opts_extend = { "sources.default" }
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
  { "rachartier/tiny-inline-diagnostic.nvim", opts = {}, },
  -- colorshcemes
  { "nitinbhat972/cwal.nvim", },
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
    url = "https://codeberg.org/andyg/leap.nvim",
    main = "leap",
    opts = {
      keys = {
        next_target = "<C-n>",
        prev_target = "<C-N>",
        next_group = "<space>",
        prev_group = "<tab>",
      },
    },
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
