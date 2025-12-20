return {
  "sschleemilch/slimline.nvim",
  opts = {
    style = "fg",
    -- disabled_filetypes = {},
    components = {
      left = {
        'mode',
        'path',
        'git',
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
        follow = "mode",
        column = true,
        hl = {
          primary = "Function",
          secondary = "Function",
        }
      },


    },
    lazy = false,
  },
}
