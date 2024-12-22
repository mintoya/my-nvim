local M = {}
M.currentFileTree = nil

local function fstr()
	local Menu = require("nui.menu")
	local files = vim.fn.glob("*", true, true)
	--lines example
	-- lines = {
	-- 	Menu.separator("Group One"),
	-- 	Menu.item("Item 1"),
	-- 	Menu.item("Item 2"),
	-- 	Menu.separator("Group Two", {
	-- 		char = "-",
	-- 		text_align = "right",
	-- 	}),
	-- 	Menu.item("Item 3"),
	-- 	Menu.item("Item 4"),
	-- },
	local sTable = {
		lines = {},
		max_width = 30,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			print("CLOSED")
		end,
		on_submit = function(item)
			-- print(item.id)
			-- print(item.isFolder)
			if item.isFolder then
				local ntree = M.choices(currentFileTree)
				ntree:mount()
			end
		end,
	}
	for _, file in ipairs(files) do
		local fileName = file
		isF = vim.fn.isdirectory(file) == 1
		if isF then
			file = " " .. file
		end
		local item = Menu.item(file, { id = fileName, isFolder = isF })
		table.insert(sTable.lines, item)
	end
	return sTable
end
function M.choices(fsTable)
	if not fsTable then
		fsTable = fstr()
		M.currentFileTree = fsTable
	end
	local Menu = require("nui.menu")
	local event = require("nui.utils.autocmd").event
	local popup_options = {
		-- relative = "cursor",
		position = {
			row = 0,
			col = 0,
		},
		border = {
			style = "rounded",
			text = {
				top = "text",
				top_align = "left",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal",
		},
	}
	return Menu(popup_options, fsTable)
end
function M.setup(opts)
	-- if opts then
	-- 	vim.keymap.set("n", "<Leader>h", function()
	-- 		M.choices():mount()
	-- 	end)
	-- else
	-- 	print("opts is nil or false!")
	-- end
end
return M
