return {
  {
    "folke/lazydev.nvim",
    -- filetypes
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
