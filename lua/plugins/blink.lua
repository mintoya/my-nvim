return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  opts_extend = { "sources.default" },
  opts = {
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
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
        }
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  event = "InsertEnter",
}
