local dodir = require "special".dodir
return dodir(configPath .. "/lua/plugins",
  {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "markdown",
          "markdown_inline",
        },
      },
      event = { "BufReadPost", "BufNewFile" },
    },

    {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
        { "mason-org/mason.nvim", },
        { "jay-babu/mason-nvim-dap.nvim", },
        { "mfussenegger/nvim-dap", },
        { "neovim/nvim-lspconfig", }
      },
      event = "VeryLazy",
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      event = "LspAttach",
    },

    {
      "chrisgrieser/nvim-scissors",
      opts = { snippetDir = snippetDir },
      event = "LspAttach",
    },


    { "jake-stewart/multicursor.nvim", event = "InsertEnter" },
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "LspAttach",
      opts = {},
    },
    { "vague-theme/vague.nvim", },
    { "catppuccin/nvim", },
    { "folke/tokyonight.nvim", },

    {
      "folke/trouble.nvim",
      cmd = "Trouble",
      opts = {},
      event = "LspAttach",
    },
    {
      "lambdalisue/vim-suda",
      cmd = { "SudaRead", "SudaWrite" }
    },

  }, { "all.lua" }
)
