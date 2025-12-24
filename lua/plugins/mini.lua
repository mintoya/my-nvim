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

    require "mini.pick".setup {}
    require "mini.pairs".setup {}
    require "mini.cursorword".setup {}
    require "mini.surround".setup {}
    require "mini.cmdline".setup {}
    require "mini.files".setup {}
    require "mini.diff".setup {}

    require "mini.misc".setup_termbg_sync {}
    require "mini.indentscope".setup { symbol = "⡂" }
    require "mini.tabline".setup {
      show_icons = true
    }
    do -- mini.starter
      _G.MiniStarter = require "mini.starter"
      MiniStarter.setup {
        header         = header,
        footer         = "",
        query_updaters = "",
        content_hooks  = {
          -- MiniStarter.gen_hook.adding_bullet(' '),
          MiniStarter.gen_hook.adding_bullet('- '),
          MiniStarter.gen_hook.aligning('center', 'center'),
        },

      }
    end
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

    do -- mini.hipatterns
      _G.MiniHipatterns = require "mini.hipatterns"
      MiniHipatterns.setup {
        highlighters = {
          hex_color = MiniHipatterns.gen_highlighter.hex_color(),
        }
      }
    end
    do -- mini.completion
      _G.MiniCompletion = require "mini.completion"
      MiniCompletion.setup {
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
    end
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
      local match_strict = function(snips)
        return MiniSnippets.default_match(snips, { pattern_fuzzy = '%S+' })
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
          match = match_strict,
          -- use nvim default
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

      MiniSnippets.start_lsp_server();
    end
    do -- mini.clue
      local MiniClue = require "mini.clue"
      local function multiply_mode_keys(triggers)
        local res = {}
        for _, trigger in pairs(triggers) do
          local keys = type(trigger.keys) == "table" and trigger.keys or { trigger.keys }
          local modes = type(trigger.mode) == "table" and trigger.mode or { trigger.mode }
          for _, k in pairs(keys) do
            for _, m in pairs(modes) do
              table.insert(res, { mode = m, keys = k })
            end
          end
        end
        return res;
      end
      MiniClue.setup {
        window = {
          delay = 200,
          scroll_up = '<C-u>',
          scroll_down = '<C-d',
        },
        triggers = multiply_mode_keys {
          {
            mode = { 'n', 'x' },
            keys = {
              '<Leader>', 'g', "'", '`', '"', 'z'
            }
          },

          { mode = 'i',          keys = '<C-x>' },
          { mode = { 'i', 'c' }, keys = '<C-r>' },
          { mode = 'n',          keys = '<C-w>' },
        },

        clues = {
          MiniClue.gen_clues.builtin_completion(),
          MiniClue.gen_clues.g(),
          MiniClue.gen_clues.marks(),
          MiniClue.gen_clues.registers(),
          MiniClue.gen_clues.windows(),
          MiniClue.gen_clues.z(),
        },
      }
    end
  end,
}
