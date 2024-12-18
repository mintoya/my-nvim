vim.opt.runtimepath:prepend(vim.fn.stdpath('config') .. "/lazy")
vim.opt.runtimepath:prepend(vim.fn.stdpath('config').."/lua")
vim.g.mapleader = " "
vim.o.foldmethod = "indent"

welcomescreen = require('welcome')

require("lazy").setup(
    {
	{ 'rainglow/vim', as = 'rainglow' },
        {"folke/tokyonight.nvim", opts = {style = "storm"}},
        {"neovim/nvim-lspconfig"},
        {"hrsh7th/nvim-cmp"},
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            dependencies = {"nvim-lua/plenary.nvim"},
            config = function()
                require("telescope").setup {
                    defaults = {
			layout_strategy = "flex",
                        vimgrep_arguments = {
                            "rg",
                            "--no-heading", -- No headings in the result
                            "--with-filename", -- Show filenames
                            "--line-number", -- Show line numbers
                            "--column" -- Show column numbers
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
	    dependencies = {"MunifTanjim/nui.nvim",'andrew-george/telescope-themes','nvim-tree/nvim-web-devicons'},
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
                        require("which-key").show({global = false})
                    end,
                    desc = "Buffer Local Keymaps (which-key)"
                }
            }
        },
{
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(welcomescreen.config)
    end
}
    }    
)

require('mapping')
require('current-theme')

