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
    require "mini.animate".setup {}
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
  end,
}
