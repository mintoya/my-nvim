local vim = vim
--[[
  multiline comment
  [x] a
  # title
]]
local function contains(table, name)
  for i, x in ipairs(table) do
    if x == name then return true end
  end
  return false
end
local dodir = function(dirname, exclusions, result)
  if not result then
    result = {}
  end
  for v, t in vim.fs.dir(dirname) do
    if t == 'file' and not contains(exclusions, v) then
      table.insert(result, dofile(dirname .. '/' .. v))
    end
  end
  return result
end

local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      'nvim-treesitter/playground'
    },
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "javascript",
      },

    }
  },
  {
    "mason-org/mason-lspconfig.nvim",
    -- opts = {
    --   automatic_enable = true
    -- },
    dependencies = {
      { "mason-org/mason.nvim", },
      { "jay-babu/mason-nvim-dap.nvim", },
      { "mfussenegger/nvim-dap", },
      { "neovim/nvim-lspconfig", }
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
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
  --  views.finder.win = {
  -- }
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {},
  },
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      views = {
        finder = {
          win = {
            border = "rounded",
            kind = "float",
            kind_presets = {
              float = {
                height = "0.8rel",
                left = "0.0rel",
                top = "0.1rel",
                width = "0.25rel"
              }
            }
          }
        },
        explorer = {
          default_explorer = true,
        }
      }
    }
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


  -- highlighters
  { "rachartier/tiny-glimmer.nvim",       event = "BufEnter",    opts = {}, },
  { "brenoprata10/nvim-highlight-colors", event = "InsertEnter" },
  { "wurli/visimatch.nvim",               event = "InsertEnter", opts = { chars_lower_limit = 4 } },
  {
    "chrisgrieser/nvim-origami",
    opts = {
      useLspFoldsWithTreesitterFallback = false,
      foldtext = { gitsignsCount = false, },
    },
    event = "VeryLazy",
  },

  -- {
  --   "folke/noice.nvim",
  --   opts = {
  --     presets = {
  --       lsp_doc_border = true,
  --     },
  --     cmdline = {
  --       view = "cmdline",
  --     },
  --   },
  --   dependencies = { "MunifTanjim/nui.nvim" },
  -- },
  {
    "nanotee/zoxide.vim"
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   preview = {
  --     icon_provider = "mini",
  --   }
  -- },
  { "lambdalisue/vim-suda",   event = "VeryLazy" },
  { "vague-theme/vague.nvim", opt = { transparent = true } },
  { "catppuccin/nvim", },
  { "folke/tokyonight.nvim", },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}

M = dodir(
  vim.fn.stdpath("config") .. "/lua/plugins",
  { "all.lua" },
  M
)


return M
