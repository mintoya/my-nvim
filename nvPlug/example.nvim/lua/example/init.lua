local M = {}
<<<<<<< Updated upstream
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
=======
local n = require("nui-components")
local component = require("nui-components.component")
local function getFiles(arg)
    arg = arg or "*"
    -- table:{name,isDirectory}
    local filesList = {}
    local dir = vim.fn.getcwd()
    local fileNames = vim.fn.glob(arg, true, true, 2)
    print(vim.inspect(fileNames))
    for _, file in ipairs(fileNames) do
        table.insert(filesList, { name = file, isDirectory = vim.fn.isdirectory(dir .. '\\' .. file) == 1 })
    end
    return filesList
end
function M.popup()
    local filesTable = getFiles()
    local renderer =
        n.create_renderer(
            {
                width = 60,
                height = 8
            }
        )
    -- local signal =
    --     n.create_signal(
    --         {
    --             is_loading = false,
    --         }
    --     )
    --
    local body = function()
        local a = {}
        for _, file in ipairs(filesTable) do
            table.insert(a, n.node({ text = file.name, data = file, indexed = false }))
        end
        return n.tree({
            autofocus = true,
            border_label = "ls",
            data = a,
            on_select = function(node, component)
                local tree = component:get_tree()
                node.indexed = not node.indexed
                if node.data.isDirectory then
                    getFiles(node.data.name .. '/*')
                end
                tree:render()
            end,
            prepare_node = function(node, line, component)
                if node.data.isDirectory then
                    line:append(" ", "String")
                end
                line:append(node.text)
                return line
            end,
        })
    end

    renderer:render(body)
end

function M.setup(opts)
    if opts then
        vim.keymap.set(
            "n",
            "<Leader>h",
            function()
                if opts.a then
                    -- print("hello, " .. opts.b)
                    M.popup()
                else
                    print("no fucking opts")
                end
            end
        )
    else
        print("opts is nil or false!")
    end
end

>>>>>>> Stashed changes
return M
