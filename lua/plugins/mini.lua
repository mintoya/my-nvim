return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.comment").setup({
      mappings = {
        comment = "gc",
        comment_line = "<leader>/",
        comment_visual = "<leader>/",
        textobject = "gc",
      },
    })
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.diff").setup()
    require("mini.misc").setup_termbg_sync()
    require("mini.indentscope").setup({
      symbol = ""
    })
    local picker = require("mini.pick")
    picker.registry.colors = function()
      return picker.start({
        mappings = {
          newStop = {
            char = "<Esc>",
            func = function()
              require("current-theme")
              dofile(vim.fn.stdpath("config") .. "/lua/current-theme.lua")
              picker.stop()
            end,
          },
        },
        source = {
          name = "colors",
          items = vim.fn.getcompletion("", "color"),
          choose = function(item, modifier)
            require("special").file.write(
              vim.fn.stdpath("config") .. "/lua/current-theme.lua",
              [[vim.cmd("colorscheme ]] .. item .. [[")]]
            )

            print("set colorscheme to ", item)
            vim.cmd("colorscheme " .. item)
          end,
          preview = function(bufnr, item)
            vim.cmd("colorscheme " .. item)

            local sometext = {
              [[local function name (arg1,arg2)]],
              [[	for k,v in pairs(arg1) do]],
              [[		print(v==arg2)]],
              [[	end]],

              [[end]],
            }
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, sometext)
            pcall(vim.treesitter.start, bufnr, "lua")
          end,
        },
      })
    end
    picker.setup()
  end,
}
