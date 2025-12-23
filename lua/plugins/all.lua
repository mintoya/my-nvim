local vim = vim

local function contains(table, name)
  for _, x in ipairs(table) do
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
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
    }
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", },
      { "jay-babu/mason-nvim-dap.nvim", },
      { "mfussenegger/nvim-dap", },
      { "neovim/nvim-lspconfig", }
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    event = "LspAttach",
  },

  {
    "chrisgrieser/nvim-scissors",
    opts = { snippetDir = snippetDir },
    event = "LspAttach",
  },


  { "jake-stewart/multicursor.nvim", },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- highlighters
  { "rachartier/tiny-glimmer.nvim",  event = "BufEnter", opts = {}, },
  {
    "chrisgrieser/nvim-origami",
    opts = {
      useLspFoldsWithTreesitterFallback = false,
      foldtext = { gitsignsCount = true, },
    },
    event = "VeryLazy",
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   preview = {
  --     icon_provider = "mini",
  --   }
  -- },
  { "vague-theme/vague.nvim", opts = { transparent = true } },
  { "catppuccin/nvim", },
  { "folke/tokyonight.nvim",  opts = { transparent = true } },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
  },
  { "lambdalisue/vim-suda", cmd = { "SudaRead", "SudaWrite" } },
}

M = dodir(
  vim.fn.stdpath("config") .. "/lua/plugins",
  { "all.lua" },
  M
)


return M
