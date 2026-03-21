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
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- Using the zpack build function callback
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
              vim.notify("blink.cmp build failed. Check your Rust installation.", vim.log.levels.ERROR)
              print(out.stderr) -- Print the actual cargo error to the message area
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
      -- You can safely prefer rust now that we are building it correctly
      fuzzy = { implementation = "prefer_rust" }
    },
    opts_extend = { "sources.default" }
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
