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
local snacksConfig = {
   styles = {
      position = "float",
      backdrop = 60,
      height = 0.9,
      width = 0.9,
      zindex = 50,
   },
   lazygit = {},
   notifier = {},
   win = {
      position = "float",
      backdrop = 60,
      height = 0.9,
      width = 0.9,
      zindex = 50,
   },
} -- doesnt work >:(
local miniConfig = function()
   require('mini.completion').setup({
   })
   require('mini.comment').setup({
      -- mappings = {
      --    comment = '<leader>/'
      --    }
      mappings = {
         -- Toggle comment (like `gcip` - comment inner paragraph) for both
         -- Normal and Visual modes
         comment = 'gc',

         -- Toggle comment on current line
         comment_line = '<leader>/',

         -- Toggle comment on visual selection
         comment_visual = '<leader>/',

         -- Define 'comment' textobject (like `dgc` - delete whole comment block)
         -- Works also in Visual mode if mapping differs from `comment_visual`
         textobject = 'gc',
      },
   })
   require("mini.statusline").setup({
      section = {
         left = function()
            return '%f %y' -- Displays the filename and filetype
         end,
         right = function()
            return '%l:%c %p%%'
         end,
      },
   })
end
local plugins = {
   { 'folke/snacks.nvim',    opts = snacksConfig },
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
      config = miniConfig
   },
   { 'rainglow/vim',          as = 'rainglow' },
   { "folke/tokyonight.nvim", opts = { style = "storm" } },
   { "neovim/nvim-lspconfig" },
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
