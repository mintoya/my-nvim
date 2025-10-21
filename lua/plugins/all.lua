local vim = vim
local path = vim.fn.stdpath("config") .. "/lua/plugins"

return {
  dofile(path .. "/blink.lua"),
  dofile(path .. "/mini.lua"),
  dofile(path .. "/slimline.lua"),
  dofile(path .. "/snacks.lua"),

  {
    "nvim-treesitter/nvim-treesitter",
    event = "InsertEnter",
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      cmdline = {
        view = "cmdline",
      },
    },
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix"
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    event = "VeryLazy"
  },
  {
    "chrisgrieser/nvim-scissors",
    opts = { snippetDir = vim.fn.stdpath("data") .. "/snippets" },
    lazy = true,
  },
  {
    "jake-stewart/multicursor.nvim",
    event = "InsertEnter",
  },
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      win = {
        border = "rounded",
        kind = "float",
        kind_presets = {
          float = {
            left = "0.0rel",
            width = "0.25rel",
            top = "0.1rel",
            height = "0.8rel",

          }
        }
      },
      views = {
        explorer = {
          default_explorer = true,
        }
      }
    }
  },

  -- color schemes
  { "catppuccin/nvim",                    name = "catppuccin" },
  { "folke/tokyonight.nvim",              opts = { style = "night" } },

  { "adlrwbr/keep-split-ratio.nvim",      opts = {},                 lazy = false },
  { "brenoprata10/nvim-highlight-colors", event = "InsertEnter" },
  { "rachartier/tiny-glimmer.nvim",       event = "BufEnter",        opts = {}, },
  { "wurli/visimatch.nvim",               event = "InsertEnter",     opts = { chars_lower_limit = 4 } },
  { "lambdalisue/vim-suda" },
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
      useLspFoldsWithTreesitterFallback = false,
      foldtext = {
        gitsignsCount = false,
      },
    },
  },
}
