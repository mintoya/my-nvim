local vim = vim
local colorfile = vim.fn.stdpath("config") .. "/lua/current-theme.lua"

return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.misc").setup_termbg_sync {}
    require("mini.pairs").setup {}
    require("mini.surround").setup {}
    require("mini.diff").setup {}

    require("mini.indentscope").setup { symbol = "" }
    require("mini.jump").setup {
      mappings = {
        forward = 'f',
        backward = 'F',
        forward_till = 't',
        backward_till = 'T',
        repeat_jump = '<C-n>',
      },
      delay = {
        highlight = 50,
        idle_stop = 1000,
      },
    }
    require("mini.comment").setup {
      mappings = {
        comment_line   = "<leader>/",
        comment_visual = "<leader>/",
      },
    }

    local picker = require("mini.pick")
    picker.registry.colors = function()
      return picker.start({
        mappings = {
          newStop = {
            char = "<Esc>",
            func = function()
              dofile(colorfile)
              picker.stop()
            end,
          },
        },
        source = {
          name = "colors",
          items = vim.fn.getcompletion("", "color"),
          choose = function(item, _)
            require("special").file.write(
              colorfile,
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
