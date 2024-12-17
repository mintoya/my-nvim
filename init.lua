-- Prepending lazy.nvim to the runtime path
vim.api.nvim_set_keymap('n', ';', ':', { noremap = false, silent = false })
vim.opt.runtimepath:prepend("lazy/lazy.nvim")
vim.g.mapleader = " "
require("lazy").setup({

  { "folke/tokyonight.nvim", opts = { style = "storm" } },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "MunifTanjim/nui.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-neo-tree/neo-tree.nvim", opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Hide files that are ignored by default
      },
    },
  }, },
  { "folke/which-key.nvim",
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

})
vim.api.nvim_set_keymap('n', 'y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 's', ':write<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>b', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree focus<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t',':Neotree close<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree<CR>', { noremap = true, silent = true })
