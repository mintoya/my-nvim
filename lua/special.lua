local function LspRename()
  local curr_name = vim.fn.expand("<cword>")
  local value = vim.fn.input("LSP Rename: ", curr_name)
  local lsp_params = vim.lsp.util.make_position_params()

  if not value or #value == 0 or curr_name == value then return end

  -- request lsp rename
  lsp_params.newName = value
  vim.lsp.buf_request(0, "textDocument/rename", lsp_params, function(_, res, ctx, _)
    if not res then return end

    -- apply renames
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

    -- print renames
    local changed_files_count = 0
    local changed_instances_count = 0

    if (res.documentChanges) then
      for _, changed_file in pairs(res.documentChanges) do
        changed_files_count = changed_files_count + 1
        changed_instances_count = changed_instances_count + #changed_file.edits
      end
    elseif (res.changes) then
      for _, changed_file in pairs(res.changes) do
        changed_instances_count = changed_instances_count + #changed_file
        changed_files_count = changed_files_count + 1
      end
    end

    -- compose the right print message
    print(string.format("renamed %s instance%s in %s file%s. %s",
      changed_instances_count,
      changed_instances_count == 1 and '' or 's',
      changed_files_count,
      changed_files_count == 1 and '' or 's',
      changed_files_count > 1 and "To save them run ':wa'" or ''
    ))
  end)
end

local Menu = require("snipe.menu")
local menu = Menu:new {
  -- Per-menu configuration (does not affect global configuration)
  position = "center"
}

-- The items to snipe is just an array
-- Be careful how you reference the array in closures though
-- if you have the items table created inside a closure
-- as uncommented when setting the open keymap a few lines down,
-- this means that the items array will change every trigger and
-- can be an outdated capture in sub-closures.
local items = { "foo", "bar", "baz" }

local function testfn()
  -- local items = { ... }

  -- This method allows you to add `n' callbacks to be
  -- triggered whenever a new buffer is created.
  -- A new buffer is only ever created if it is somehow
  -- externally removed or at normal startup. The reason
  -- For this system is so that you can update any buffer local
  -- keymaps and alike to work for the new buffer.
  menu:add_new_buffer_callback(function(m)
    -- `m` is a reference to the menu, prefer referencing it via this (i.e. not through your menu variable) !

    -- Keymaps like "open in split" etc can be put in here
    print("I dont want any other keymaps X( !")
  end)

  menu:open(items, function(m, i)
    -- Prefer accessing items on the menu itself (m.items not items) !
    print("You selected: " .. m.items[i])
    print("You are hovering over: " .. m.items[m:hovered()])
    -- Close the menu
    m:close()
    -- You can also call `reopen` for things like navigating
    -- between pages when the window can stay open and just
    -- needs to be updated.
  end, function(item)
    -- Format function means you don't just have to pass a list of strings
    -- you get to format each item as you choose.
    return item
  end, 10 -- the item to preselect, if it is out of bounds of the currently shown page
  -- it is ignored
  )
end

return { rename = LspRename, snipe = testfn }
