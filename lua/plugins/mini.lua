local vim = vim
local colorfile = vim.fn.stdpath("config") .. "/lua/current-theme.lua"

return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.misc").setup_termbg_sync {}
    require("mini.pairs").setup {}
    require("mini.surround").setup {}
    require("mini.cmdline").setup {}

    local gen_loader = require('mini.snippets').gen_loader
    require("mini.snippets").setup({
      snippets = {
        gen_loader.from_lang(),
        gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/global.json"),
      },

      mappings = {
        stop = '',
        expand = '',
        jump_next = '',
        jump_prev = '',
      },
      expand = {
        insert = function(snippet)
          if type(snippet) == "table" then
            if snippet.body then
              snippet = snippet.body
            elseif snippet.text then
              snippet = snippet.text
            end
          end
          if type(snippet) ~= "string" then
            vim.notify("cant expand snippet " .. vim.inspect(snippet))
          end
          vim.snippet.expand(snippet)
        end,
      },
    })
    require("mini.completion").setup({
      delay = { completion = 100, info = 100, signature = 50 },

      window = {
        info = { border = "rounded" },
        signature = { border = "rounded" },
      },

      lsp_completion = {
        source_func = "omnifunc",
        auto_setup = true,
      },

      -- fallback_action = "<C-n>",
    })
    require("mini.diff").setup {}

    require("mini.indentscope").setup { symbol = "|" }
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
