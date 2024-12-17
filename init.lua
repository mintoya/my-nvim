vim.o.foldmethod = "indent"
vim.api.nvim_set_keymap("n", ";", ":", {noremap = false, silent = false})
vim.opt.runtimepath:prepend("lazy/lazy.nvim")
vim.g.mapleader = " "
require("lazy").setup(
    {
        {"folke/tokyonight.nvim", opts = {style = "storm"}},
        {"neovim/nvim-lspconfig"},
        {"hrsh7th/nvim-cmp"},
        {"MunifTanjim/nui.nvim"},
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
                                enable_preview = true
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
            opts = {
                filesystem = {
                    filtered_items = {
                        visible = true -- Hide files that are ignored by default
                    }
                }
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
        }
    }
)

vim.api.nvim_set_keymap("n", "y", '"+y', {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "y", '"+y', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "s", ":write<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap(
    "n",
    "<leader>c",
    ":Telescope colorscheme<CR>",
    {desc = "telescope colorschemes", noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>ff",
    ":Telescope find_files<CR>",
    {desc = "find files", noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>ft",
    ":Telescope live_grep<CR>",
    {desc = "find text in files", noremap = true, silent = true}
)
vim.api.nvim_set_keymap("n", "<leader>b", ":tabnew<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree focus<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>t", ":Neotree close<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>x", ":bd<CR>", {desc = "close buffer", noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-n>", ":Neotree<CR>", {noremap = true, silent = true})

