local vim = vim

local header = [[
╭─────────────────────────────────────────────────╮
│⣿⣿⣿⣿⣿⣾⡾⣷⣂⠤⠀⠠⢀⣢⠻⢴⣠⢠⠁⢶⣿⠟⠡⠀⢠⢔⡘⡻⡽⡣⠷⡳⠀⠪⠀⠠⢢⣬⢩⣮⣿⠟⣻⣿⣿⣿⣿⣿⣿│
│⣿⡻⣿⣿⣿⢿⡫⣼⣋⠀⠀⠀⣹⣯⢐⢇⣒⡆⠌⣔⠋⢴⣞⡻⣊⡬⢾⣽⠻⡘⡁⠀⠀⢢⣿⣁⢣⣿⠟⢛⠛⣿⣿⠿⡻⣿⣿⢿⣿│
│⠉⠀⠑⠉⠈⢼⣨⣿⣿⠆⠐⢐⢟⣿⣟⣴⣇⣍⣷⣂⢨⣾⣷⡶⡌⠀⠂⣻⠋⠀⠀⢀⢴⣺⣿⣿⣿⠞⠾⣀⣄⣀⡀⠱⠉⢈⠀⠆⠿│
│⠀⠀⢠⣾⡟⠉⠛⠛⣹⣧⡀⠈⡼⡿⡡⢾⣷⡂⢍⡁⣾⠑⣉⣿⣓⣔⠪⣕⠃⠀⠀⡒⣽⠛⠛⠂⠀⠀⠀⠀⠈⠻⣿⣶⡀⠀⠀⠀⢀│
│⠀⠀⣾⣟⠀⠀⠀⠀⣨⣧⠀⠀⠰⠉⣾⣟⠯⢪⢿⢂⣉⠎⣚⣝⡇⠁⠀⠀⠀⠀⢰⣶⣿⣶⣄⣄⠀⠀⠀⠀⠀⠀⠘⢿⣿⣧⠀⠀⠈│
│⠀⢠⣿⡇⠀⠀⣤⣾⡟⠛⣷⣆⡀⠀⠒⠻⣕⡒⠙⠻⢃⣹⠫⢿⠓⠀⠀⣠⣴⣾⣿⣿⣿⣷⠀⢹⣷⠆⠀⠀⠀⠀⠀⢻⣿⣿⣤⠀⠀│
│⠀⢸⣿⡅⠀⠀⠀⠘⡇⠀⢿⣿⣿⣷⠄⠀⠑⠡⠁⢀⠀⠙⠈⠀⢀⣴⣾⣇⠀⠻⣿⣿⣿⠏⠀⢠⠇⠀⠀⠀⠀⠀⠀⢺⣿⣿⠃⠀⠀│
│⠀⢸⣿⡇⠀⠀⠀⠀⠹⣄⠀⠉⠛⠉⣼⣷⣄⠀⢠⣾⣆⠀⢠⣴⣿⢿⢿⣿⢦⣄⣀⠀⣀⣠⠴⠋⠀⠀⠀⠀⠀⠀⠀⣬⣿⣿⠆⠀⠀│
│⠀⠘⣿⣧⠄⠀⠀⠀⠀⢈⠛⣲⢶⢻⣿⣿⠿⢿⡟⠻⣷⣷⣿⣛⣛⠂⠂⢉⢑⠀⢙⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⠇⠁⠀⠀│
│⠀⠀⢻⣿⣇⠀⠀⠀⠀⠀⢀⠈⡵⢫⡿⠎⡈⣿⣩⣶⣥⣿⣯⠅⠁⠐⠐⠠⠁⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠸⣿⡿⣻⠇⡀⠀⠀│
│⠀⠀⠈⣿⣿⡄⠀⠀⠈⠀⠃⠑⠀⠂⠔⠐⢐⣿⣿⣿⣿⣿⣿⣃⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⠟⢰⣷⣷⢶⡄⡀│
│⠀⠀⣼⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⢺⣿⣿⣿⣿⣿⣿⣶⠰⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣾⣷⣿│
│⠀⣼⣿⣿⣧⡈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠿⣿⣿⣿⣿⣿⣿⠫⠁⠀⠀⠀⢀⡀⢐⣌⠉⡀⢤⡤⠀⠀⠀⣠⣤⣽⣿⣿⣿⡿⠟⠛│
│⠀⠌⣿⣿⣿⡿⠀⢀⠀⠐⡚⡳⠥⣀⡄⠀⠀⠀⢿⣿⣿⣿⣿⠁⠀⠀⡀⣢⣤⣫⣞⣁⣡⢈⡠⠀⠀⠀⠀⠈⠰⠟⠻⠿⠟⠉⠀⠀⠀│
│⠀⠀⠙⠿⠛⠃⠀⠀⠀⠠⠥⡀⢴⣆⡏⠕⡢⡀⠸⣿⣿⠏⢠⠄⡀⢐⣯⢫⣥⣽⡿⢽⡼⣾⡿⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
╰─────────────────────────────────────────────────╯]]

return {
  "nvim-mini/mini.nvim",
  config = function()
    _G.MiniKeymap = require 'mini.keymap'

    require "mini.pairs".setup {}
    require "mini.cursorword".setup {}
    require "mini.surround".setup {}
    require "mini.cmdline".setup {}
    require "mini.files".setup {}
    require "mini.diff".setup {}

    require "mini.misc".setup_termbg_sync {}
    require "mini.indentscope".setup { symbol = "|" }
    require "mini.starter".setup {
      header         = header,
      footer         = "",
      query_updaters = "",
    }
    require "mini.comment".setup {
      mappings = {
        comment_line   = "<leader>/",
        comment_visual = "<leader>/",
      },
    }
    require "mini.jump".setup {
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
    require "mini.completion".setup {
      delay = { completion = 100, info = 100, signature = 100 },
      window = {
        info = { height = 25, width = 80 },
        signature = { height = 25, width = 80 },
      },

      lsp_completion = {
        source_func = "omnifunc",
        auto_setup = true,
      },
      fallback_action = "",
    }

    do -- mini.snippets
      _G.MiniSnippets = require 'mini.snippets'
      local snippets  = {
        MiniSnippets.gen_loader.from_lang(),
      }
      for v, t in vim.fs.dir(snippetDir) do
        if t == 'file' and v ~= "package.json" then
          local snippetfile = snippetDir .. "/" .. v
          table.insert(
            snippets,
            MiniSnippets.gen_loader.from_file(snippetfile)
          )
        end
      end
      MiniSnippets.setup({
        snippets = snippets,
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
              end
            end
            if type(snippet) ~= "string" then
              vim.notify("cant expand snippet " .. vim.inspect(snippet))
            end
            vim.snippet.expand(snippet)
          end,
        },
      })
      _G.expand_or_jump = function()
        local can_expand = #MiniSnippets.expand({ insert = false }) > 0
        if can_expand then
          vim.schedule(MiniSnippets.expand); return ''
        end
        local is_active = MiniSnippets.session.get() ~= nil
        if is_active then
          MiniSnippets.session.jump('next'); return ''
        end
        return '\t'
      end
      _G.jump_prev = function() MiniSnippets.session.jump('prev') end

      MiniSnippets.start_lsp_server();
    end
    do -- mini.clue
      local MiniClue = require "mini.clue"
      MiniClue.setup {
        window = {
          delay = 200,
          scroll_up = '<C-u>',
          scroll_down = '<C-d',
        },
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          MiniClue.gen_clues.builtin_completion(),
          MiniClue.gen_clues.g(),
          MiniClue.gen_clues.marks(),
          MiniClue.gen_clues.registers(),
          MiniClue.gen_clues.windows(),
          MiniClue.gen_clues.z(),
        },
      }
    end
    do -- mini.picker
      local MiniPicker = require "mini.pick"
      MiniPicker.registry.colors = function()
        return MiniPicker.start({
          mappings = {
            newStop = {
              char = "<Esc>",
              func = function()
                dofile(colorfile)
                MiniPicker.stop()
              end,
            },
          },
          source = {
            name = "colors",
            items = vim.fn.getcompletion("", "color"),
            choose = function(item, _)
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
      MiniPicker.setup()
    end
  end,
}
