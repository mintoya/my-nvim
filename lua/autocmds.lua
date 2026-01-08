local special = require "special"
do -- autocommands
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(afile, _)
      special.file.write(colorfile, afile.match)
    end
  })
  vim.api.nvim_create_autocmd({ "Signal", "VimEnter" }, {
    pattern = { "*" },
    callback = function(ev)
      if (ev.event == "VimEnter" or ev.match == "SIGUSR1") then
        local colorscheme = special.file.read(colorfile) or "default"
        if ev.event == "VimEnter" then
          vim.cmd("colorscheme " .. colorscheme)
        else
          vim.schedule(function() vim.cmd("colorscheme " .. colorscheme) end)
        end
        vim.notify("reloaded colorscheme " .. colorscheme)
      end
    end
  })
  -- vim.api.nvim_create_autocmd("Signal", {
  --   pattern = "SIGWINCH",
  --   callback = function()
  --     local layout = vim.fn.winlayout;
  --     vim.notify(vim.inspect(layout))
  --   end
  -- })
end
do -- usercommands
  vim.api.nvim_create_user_command('VText',
    function(opts)
      local which = opts.args
      special.vtext[which]()
    end,
    {
      nargs    = 1,
      desc     = "toggle virtual text",
      complete = function(_, _)
        local res = {}
        for i, _ in pairs(special.vtext) do
          table.insert(res, i)
        end
        return res
      end,
    }
  )
  vim.api.nvim_create_user_command('TermClear',
    function(opts)
      vim.fn.feedkeys("", 'n')
      local sb = vim.bo.scrollback
      vim.bo.scrollback = 1
      vim.bo.scrollback = sb
    end,
    {
      nargs = 0,
      desc  = "clear terminal",
    }
  )
  vim.api.nvim_create_user_command('Z',
    function(opts)
      local folder = opts.args
      folder = vim.fn.system("zoxide query " .. folder)
      vim.notify(folder)
      vim.cmd("cd " .. folder);
    end,
    {
      nargs = 1,
      desc  = "cd with zoxide",
    }
  )
end
