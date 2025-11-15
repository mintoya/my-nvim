local vim = vim

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
  -- language support
  {
    "nvim-treesitter/nvim-treesitter",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = true
    },
    dependencies = {
      { "mason-org/mason.nvim",  opts = {} },
      { "neovim/nvim-lspconfig", }
    },
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

  -- color schemes
  { "catppuccin/nvim",                    name = "catppuccin" },
  { "folke/tokyonight.nvim",              opts = { style = "night" } },

  -- highlighters
  { "rachartier/tiny-glimmer.nvim",       event = "BufEnter",        opts = {}, },
  { "brenoprata10/nvim-highlight-colors", event = "InsertEnter" },
  { "wurli/visimatch.nvim",               event = "InsertEnter",     opts = { chars_lower_limit = 4 } },
  {
    "chrisgrieser/nvim-origami",
    opts = {
      useLspFoldsWithTreesitterFallback = false,
      foldtext = { gitsignsCount = false, },
    },
    event = "VeryLazy",
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
    "nanotee/zoxide.vim"
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    preview = {
      icon_provider = "mini",
    }
  },
  { "lambdalisue/vim-suda", event = "VeryLazy" },

}

M = dodir(
  vim.fn.stdpath("config") .. "/lua/plugins",
  { "all.lua" },
  M
)

return M
