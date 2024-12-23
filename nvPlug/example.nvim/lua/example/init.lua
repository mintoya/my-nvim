local M = {}
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

return M
