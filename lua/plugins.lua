local vim = vim

local blinkOpts = {
  cmdline = {
    keymap = { preset = 'inherit' },
    completion = { menu = { auto_show = true } },
  },
  keymap =
  {
    ["<C-e>"] = { "hide" },
    ["<C-l>"] = { "select_and_accept" },

    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = true,
      window = {
        border = "rounded",
      }
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
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
  require("mini.pairs").setup()
  require("mini.surround").setup()
  require("mini.diff").setup()
  -- require("mini.notify").setup()

  require("mini.misc").setup_termbg_sync()
  require("mini.indentscope").setup({
    symbol = ""
  })
  local picker = require("mini.pick")
  picker.registry.colors = function()
    return picker.start({
      mappings = {
        newStop = {
          char = "<Esc>",
          func = function()
            require("current-theme")
            dofile(vim.fn.stdpath("config") .. "/lua/current-theme.lua")
            picker.stop()
          end,
        },
      },
      source = {
        name = "colors",
        items = vim.fn.getcompletion("", "color"),
        choose = function(item, modifier)
          require("special").file.write(
            vim.fn.stdpath("config") .. "/lua/current-theme.lua",
            [[vim.cmd("colorscheme ]] .. item .. [[")]]
          )

          print("set colorscheme to ", item)
          vim.cmd("colorscheme " .. item)
        end,
        preview = function(bufnr, item)
          vim.cmd("colorscheme " .. item)

          local sometext = {
            [[local function name (arg1,arg2)]],
            [[	for k,v in pairs(arg1) do]],
            [[		print(v==arg2)]],
            [[	end]],

            [[end]],
          }
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, sometext)
          pcall(vim.treesitter.start, bufnr, "lua")
        end,
      },
    })
  end
  picker.setup()
end

local plugins = {
  defaults = {
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "InsertEnter",
  },

  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {},
      notifier = {},
      words = {},
      indent = {},
      dashboard = require("welcome"),
    },
    lazy = false
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

  { "nvim-mini/mini.nvim",   config = miniConfig, },


  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    opts_extend = { "sources.default" },
    opts = blinkOpts,
    event = "InsertEnter",
  },


  {
    "folke/which-key.nvim",
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
    opts = { snippetDir = vim.fn.stdpath("config") .. "/snippets" },
    event = "InsertEnter",
  },
  -- {
  --   "brenton-leighton/multiple-cursors.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "InsertEnter",
  },
  {
    "sschleemilch/slimline.nvim",
    opts = {
      style = "fg",
      disabled_filetypes = {},
      components = {
        left = {
          'mode',
          'path',
          'git',
        },
        --   center = {
        --     function(active)
        --       local ts_utils = require 'nvim-treesitter.ts_utils'
        --       local function getCurrentNodePath()
        --         local node = ts_utils.get_node_at_cursor()
        --         if not node then return "N/a" end
        --
        --         local path = ""
        --         node = node:parent()
        --         local max = 3
        --         while node and max > 0 do
        --           path = node:type() .. " -> " .. path
        --           node = node:parent()
        --           max = max - 1;
        --         end
        --         return path
        --       end
        --       local function getCurrentNode()
        --         local node = ts_utils.get_node_at_cursor()
        --         if not node then return "N/a" end
        --         return node:type();
        --       end
        --
        --       local Slimline = require("slimline")
        --       return Slimline.highlights.hl_component(
        --         { primary = getCurrentNodePath(), secondary = getCurrentNode() },
        --         -- Slimline.highlights.hls.components['path'],
        --         Slimline.get_sep('path'),
        --         'right', -- flow direction (on which side the secondary part will be rendered)
        --         active,  -- whether the component is active or not
        --         'fg'     -- style to use
        --       )
        --     end,
        --   },
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
      event = "BufEnter"
    },
  },
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      views = {
        explorer = {
          default_explorer = true,
          indentscope = {
            enabled = false,
          },
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
          }
        }
      }
    }
  },

  -- color schemes
  { "catppuccin/nvim",       name = "catppuccin" },
  { "folke/tokyonight.nvim", opts = { style = "night" } },
  { "vague2k/vague.nvim",    opts = { transparent = true } },
  { "kamwitsta/vinyl.nvim" },
  { "NvChad/base46", },
  -- {
    --   'R1PeR/bounce.nvim',
    --   opts = {
      --       delay_time = 500,
      --       highlight_group_name = '@text.todo',
      --       more_jumps = false,
      --       display_mode = "virtual_line",
      --   },
      --   event = "BufEnter",
      -- },
      { "adlrwbr/keep-split-ratio.nvim", opts = {} , lazy=false },
      { "brenoprata10/nvim-highlight-colors", event = "InsertEnter" },
      { "rachartier/tiny-glimmer.nvim",       opts = {},             event = "InsertEnter" },
      { "wurli/visimatch.nvim",               event = "InsertEnter", opts = { chars_lower_limit = 3 } },
      -- used in windos
      -- { "sphamba/smear-cursor.nvim", opts = {} },
      -- lazy.nvim
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

    return plugins
