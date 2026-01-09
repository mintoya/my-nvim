local header =
[[
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
╰─────────────────────────────────────────────────╯
]]

vim.pack.add(
  { "https://github.com/nvim-mini/mini.nvim" },
  {
    load =
        function(plugin)
          vim.cmd.packadd(plugin.spec.name)

          require "mini.diff".setup {}
          require "mini.pairs".setup {}
          require "mini.notify".setup {}
          require "mini.cmdline".setup {}
          require "mini.cursorword".setup {}

          -- require "mini.misc".setup_termbg_sync {}
          -- require "mini.animate".setup {}
          require "mini.tabline".setup { show_icons = true }
          require "mini.indentscope".setup { symbol = "⡂" }
          require "mini.comment".setup {
            mappings = {
              comment_line   = "<leader>/",
              comment_visual = "<leader>/",
            },
          }
          require "mini.surround".setup {
            mappings = {
              add = "sa",
              delete = "sd",
              find = "",
              find_left = "",
              highlight = "",
              replace = "",
              suffix_last = "",
              suffix_next = "",
            }
          }

          do -- mini.keymap
            _G.MiniKeymap = require 'mini.keymap'
            MiniKeymap.setup {}
          end
          do -- mini.extra
            _G.MiniExtra = require "mini.extra"
            MiniExtra.setup {}
          end
          do -- mini.pick
            _G.MiniPick = require 'mini.pick'
            MiniPick.setup {}
          end
          do -- mini.hipatterns
            local MiniHipatterns = require "mini.hipatterns"
            MiniHipatterns.setup {
              highlighters = {
                hex_color = MiniHipatterns.gen_highlighter.hex_color(),
              }
            }
          end
          do -- mini.starter
            local MiniStarter = require "mini.starter"
            MiniStarter.setup {
              header         = header,
              footer         = "",
              query_updaters = "",
              content_hooks  = {
                MiniStarter.gen_hook.adding_bullet('- '),
                MiniStarter.gen_hook.aligning('center', 'center'),
              },

            }
          end
          do -- mini.files
            _G.MiniFiles = require "mini.files"
            MiniFiles.setup {
              options = {
                use_as_default_explorer = true,
              },
              windows = {
                max_number = 3,
                preview = true,
                width_focus = 25,
                width_nofocus = 15,
                width_preview = 15,
              },
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
                scroll_down = '<C-d>',
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
        end
  }
)
