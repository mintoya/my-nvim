local vim = vim
local function LspRename()
	local curr_name = vim.fn.expand("<cword>")
	local value = vim.fn.input("LSP Rename: ", curr_name)
	local lsp_params = vim.lsp.util.make_position_params()

	if not value or #value == 0 or curr_name == value then
		return
	end

	-- request lsp rename
	lsp_params.newName = value
	vim.lsp.buf_request(0, "textDocument/rename", lsp_params, function(_, res, ctx, _)
		if not res then
			return
		end

		-- apply renames
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

		-- print renames
		local changed_files_count = 0
		local changed_instances_count = 0

		if res.documentChanges then
			for _, changed_file in pairs(res.documentChanges) do
				changed_files_count = changed_files_count + 1
				changed_instances_count = changed_instances_count + #changed_file.edits
			end
		elseif res.changes then
			for _, changed_file in pairs(res.changes) do
				changed_instances_count = changed_instances_count + #changed_file
				changed_files_count = changed_files_count + 1
			end
		end

		-- compose the right print message
		print(
			string.format(
				"renamed %s instance%s in %s file%s. %s",
				changed_instances_count,
				changed_instances_count == 1 and "" or "s",
				changed_files_count,
				changed_files_count == 1 and "" or "s",
				changed_files_count > 1 and "To save them run ':wa'" or ""
			)
		)
	end)
end

local Menu = require("snipe.menu")
local menu = Menu:new({
	-- Per-menu configuration (does not affect global configuration)
	position = "topleft",
	open_win_override = {
		title = "Pinned files",
		border = "double", -- use "rounded" for rounded border
	},
})

local jsonDataPath = vim.fn.stdpath("config") .. "/pinned.json"
local function read_from_file(filepath)
	local f
	local i, result = pcall(function()
		f = vim.fn.readfile(filepath, "b")
	end)
	if not i then
		f = "[]"
	else
		f = table.concat(f)
	end
	return f
end

local function write_to_file(filepath, content)
	vim.fn.writefile({ content }, filepath, "b")
end

local function pin()
	local path = (vim.fn.bufname(0))
	local name = vim.fn.fnamemodify(path, ":.")
	print("appending ", path)
	local items = vim.fn.json_decode(read_from_file(jsonDataPath)) or {}
	table.insert(items, 1, { name = name, path = path })
	write_to_file(jsonDataPath, vim.fn.json_encode(items))
end
local function unpin()
	local items = vim.fn.json_decode(read_from_file(jsonDataPath))
	local name = menu.items[menu:hovered()].name
	for i, v in ipairs(items) do
		if v.name == name then
			table.remove(items, i)
		end
	end
	if #items == 0 then
		table.insert(items, { name = "<leader>p : pin", path = "" })
		table.insert(items, { name = "<leader>d : remove", path = "" })
	end
	write_to_file(jsonDataPath, vim.fn.json_encode(items))
end

local function rename()
	local items = vim.fn.json_decode(read_from_file(jsonDataPath))
	local name = menu.items[menu:hovered()].name
	local path = menu.items[menu:hovered()].path
	for i, v in ipairs(items) do
		if v.name == name and v.path == path then
			v.name = vim.fn.input("New name:")
		end
	end
	if #items == 0 then
		table.insert(items, { name = "<leader>p : pin", path = "" })
		table.insert(items, { name = "<leader>d : remove", path = "" })
	end
	write_to_file(jsonDataPath, vim.fn.json_encode(items))
end
local function snipeFn()
	local items = vim.fn.json_decode(read_from_file(jsonDataPath))
	if #items == 0 then
		table.insert(items, { name = "<leader>p : pin", path = "" })
		table.insert(items, { name = "<leader>d : remove", path = "" })
	end
	menu:add_new_buffer_callback(function(m)
		local maptable = {
			{
				"n",
				"q",
				function()
					m:close()
				end,
			},
			{
				"n",
				"<leader>p",
				function()
					pin()
					m.items = vim.fn.json_decode(read_from_file(jsonDataPath))
					m:reopen()
				end,
			},
			{
				"n",
				"<leader>d",
				function()
					unpin()
					m.items = vim.fn.json_decode(read_from_file(jsonDataPath))
					m:reopen()
				end,
			},
			{
				"n",
				"<leader>r",
				function()
					rename()
					m.items = vim.fn.json_decode(read_from_file(jsonDataPath))
					m:reopen()
				end,
			},
		}
		for _i, v in ipairs(maptable) do
			vim.keymap.set(v[1], v[2], v[3], { nowait = true, buffer = m.buf })
		end
	end)

	menu:open(items, function(m, i)
		-- print("You selected: " .. m.items[i])
		-- print("You are hovering over: " .. m.items[m:hovered()])
		if m.items[i].path == "" then
			print("not a file?")
		else
			m:close()
			vim.cmd.edit(m.items[i].path)
		end
	end, function(item)
		return item.name
	end, 2)
end

local function open_oil_sidebar()
	-- in some function, whenever you want to open Oil in a sidebar:
	local cwin = vim.api.nvim_get_current_win()
	vim.cmd("vsplit | enew")
	local sidebar_win = vim.api.nvim_get_current_win()
	vim.cmd("Oil") -- open the Oil buffer in that new window

	-- create a one‑shot augroup & autocmd to close it on the next non‑oil buffer enter:
	local group = vim.api.nvim_create_augroup("OilSidebar", { clear = true })
	vim.api.nvim_create_autocmd("BufEnter", {
		group = group,
		pattern = "*",
		-- once=true makes Neovim automatically clear this autocmd after it fires
		once = true,
		callback = function(args)
			-- if we’re still in Oil, bail out
			if vim.bo[args.buf].filetype == "oil" then
				return
			end
			-- make sure both windows are still valid
			if not (vim.api.nvim_win_is_valid(cwin) and vim.api.nvim_win_is_valid(sidebar_win)) then
				return
			end

			-- move the new buffer into the original window, then close the sidebar
			vim.api.nvim_win_set_buf(cwin, args.buf)
			vim.api.nvim_set_current_win(cwin)
			vim.api.nvim_win_close(sidebar_win, true)
		end,
	})
end

vim.api.nvim_create_user_command("OilSidebar", open_oil_sidebar, {})

vim.api.nvim_create_user_command("SnipePinned", snipeFn, {
	nargs = "*", -- Number of arguments: 0 (`nargs=0`), 1 (`nargs=1`), or any (`nargs=*`)
	complete = "file", -- Optional: For tab-completion (e.g., file paths, commands, etc.)
	desc = "snipe a pinned file", -- Optional: Command description (shown in `:help :MyCommand`)
})

return { rename = LspRename, snipe = snipeFn, oilSidebar = open_oil_sidebar }
