vim.opt.runtimepath:prepend(vim.fn.stdpath('config') .. "/lazy")
vim.opt.runtimepath:prepend(vim.fn.stdpath('config') .. "/lua")
vim.g.mapleader = " "
vim.o.foldmethod = "indent"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 3
-- 2 makes telescope collapse all the files
vim.opt.expandtab = true

welcomescreen = require('welcome')


local options = {
   formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      -- css = { "prettier" },
      -- html = { "prettier" },
   },

   format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 200,
      lsp_fallback = true,
   },
}

require("lazy").setup(
   {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'neovim/nvim-lspconfig' },
      { 'echasnovski/mini.nvim', version = false },
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
      { 'stevearc/conform.nvim', opts = options },
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
            require 'alpha'.setup(welcomescreen.config)
         end
      }
   })

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

require('mapping')       --enables coustom keybinds
require('current-theme') --required to remember theme
require('lsps')
