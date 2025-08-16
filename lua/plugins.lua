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
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
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

  require("mini.misc").setup_termbg_sync()
  require("mini.indentscope").setup({
    symbol = ""
  })
  -- require("mini.snippets").setup()
  -- require("mini.completion").setup(
  --   {
  --     window = {
  --       info = { border = "rounded" },
  --       signature = { border = "rounded" },
  --     },
  --   }
  -- )
  local picker = require("mini.pick")
  picker.registry.colors = function()
    return picker.start({
      mappings = {
        newStop = {
          char = "<Esc>",
          func = function()
            require("current-theme")
            vim.cmd(
              [[lua ]]
              .. (require("special").file.read(vim.fn.stdpath("config") .. "/lua/current-theme.lua"))
            )
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
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
  },

  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {},
      notifier = {},
      indent = {},
      dashboard = require("welcome"),
    }
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  { "neovim/nvim-lspconfig" },

  { "echasnovski/mini.nvim", config = miniConfig, },


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
    event = "VeryLazy",
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

  -- { "sphamba/smear-cursor.nvim", opts = {} },
  -- used in windos
  { "rachartier/tiny-glimmer.nvim", opts = {} },

  { "wurli/visimatch.nvim",         event = "VeryLazy", opts = { chars_lower_limit = 3 } },
  {
    "chrisgrieser/nvim-scissors",
    opts = { snippetDir = vim.fn.stdpath("config") .. "/snippets" },
    event = "VeryLazy",
  },
  {
    "brenton-leighton/multiple-cursors.nvim",
    event = "VeryLazy",
    opts = {},
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
        center = {
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
          follow = false,
          column = true,
          hl = {
            primary = "Function",
            secondary = "Function",
          }
        },


      }
    },
  },
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      views = {
        explorer = {
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
  { "catppuccin/nvim",                   name = "catppuccin" },
  { "folke/tokyonight.nvim",             opts = { style = "night" } },
  { "vague2k/vague.nvim",                opts = { transparent = true } },

  { "brenoprata10/nvim-highlight-colors" },
}

return plugins
