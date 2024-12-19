local lspOptions = {
   formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      css = { "prettier" },
      html = { "prettier" },
   },
   format_on_save = {
      timeout_ms = 200,
      lsp_fallback = true,
   },
}

local plugins = {
   {
      "williamboman/mason.nvim",
      config = function()
         require("mason").setup()
      end
   },
   { 'L3MON4D3/LuaSnip' },
   { 'hrsh7th/cmp-nvim-lsp' },
   { 'neovim/nvim-lspconfig' },
   {
      'echasnovski/mini.nvim',
      version = false,
      config = function()
         require("mini.statusline").setup({
            section = {
               left = function()
                  return '%f %y' -- Displays the filename and filetype
               end,
               right = function()
                  return '%l:%c %p%%' -- Displays line number, column number, and percentage
               end,
            },
         })
      end
   },
   { 'rainglow/vim',          as = 'rainglow' },
   { "folke/tokyonight.nvim", opts = { style = "storm" } },
   { "neovim/nvim-lspconfig" },
   {
      'numToStr/Comment.nvim',
      config = function()
         require('Comment').setup({
            toggler = {
               line = '<leader>/',
            },
            opleader = { line = '<leader>/' }
         })
      end
   },
   { 'stevearc/conform.nvim', opts = lspOptions },
   { "hrsh7th/nvim-cmp" },
   {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
         require("telescope").setup {
            defaults = {
               layout_strategy = "flex",
               vimgrep_arguments = {
                  "rg",
                  "--no-heading",    -- No headings in the result
                  "--with-filename", -- Show filenames
                  "--line-number",   -- Show line numbers
                  "--column"         -- Show column numbers
               },
               pickers = {
                  colorscheme = {
                     enable_preview = true,
                  },
                  file_files = {
                     enable_preview = true,
                     previewer = require("telescope.previewers").vim_buffer_cat.new
                  }
               }
            }
         }
      end
   },
   {
      "nvim-neo-tree/neo-tree.nvim",
      dependencies = { "MunifTanjim/nui.nvim", 'andrew-george/telescope-themes', 'nvim-tree/nvim-web-devicons' },
      opts = {
         filesystem = {
            filtered_items = {
               visible = true,
            }
         },
         window = {
            width = 20,
         },
      }
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
            desc = "Buffer Local Keymaps (which-key)"
         }
      }
   },
   {
      'goolord/alpha-nvim',
      config = function()
         require 'alpha'.setup(require('welcome').config)
      end
   }
}

return plugins
