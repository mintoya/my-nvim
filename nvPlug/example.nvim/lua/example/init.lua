local M = {}
-- annoying lsp
local vim = vim

local NuiTree = require("nui.tree")
local Layout = require("nui.layout")
local Popup = require("nui.popup")
local Menu = require("nui.menu")

local function getFiles(arg)
    -- table:{name,isDirectory}
    if arg then
        arg = arg .. '/*'
    end
    arg = arg or "*"
    local filesList = {}
    local fileNames = vim.fn.glob(arg, true, true, 2)
    for _, file in ipairs(fileNames) do
        table.insert(filesList, {
            name = file,
            location = vim.fn.fnamemodify(file, ':p:h'),
            isDirectory = vim.fn.isdirectory(file) == 1
        })
    end
    return filesList
end
local function fileToItems(arg)
    local a = {}
    for _, v in ipairs(getFiles(arg)) do
        local appen = ''
        if v.isDirectory then
            appen = ' '
        end
        table.insert(a, Menu.item(appen .. v.name, v))
    end
    return a
end

local function fileToNodes(arg)
    local a = {}
    for _, v in ipairs(getFiles(arg)) do
        local appen = ''
        if v.isDirectory then
            appen = ' '
        end
        table.insert(a, NuiTree.Node({ text = appen .. vim.fn.fnamemodify(v.name, ':t') }))
    end
    return a
end
function M.popup()
    local basicGraph =
    {
        lines = {},
        max_width = 200,
    }

    local bottom_left_popup = Popup({ focusable = false, border = { style = 'rounded', text = { bottom = '{ }' } } },
        basicGraph)
    local bottom_right_popup = Popup({ focusable = true, border = { style = 'rounded', text = { top = '{ }' } } },
        basicGraph)



    local function updateNext(directory, isDirectory)
        vim.api.nvim_buf_set_option(bottom_right_popup.bufnr, 'modifiable', true)
        vim.api.nvim_buf_set_lines(bottom_right_popup.bufnr, 0, -1, false, {})
        if isDirectory then
            local nodetable = fileToNodes(directory)
            local tree = NuiTree({
                bufnr = bottom_right_popup.bufnr,
                nodes = nodetable
            })
            tree:render()
        end
    end

    local function updatePrev(directory, isDirectory)
        vim.api.nvim_buf_set_option(bottom_left_popup.bufnr, 'modifiable', true)
        vim.api.nvim_buf_set_lines(bottom_left_popup.bufnr, 0, -1, false, {})
        local grandParent = ''
        if isDirectory then
            grandParent = vim.fn.fnamemodify(string.sub(directory, -1), ':h')
        else
            grandParent = vim.fn.fnamemodify(directory, ':h')
        end

        print(grandParent)
        local nodetable = fileToNodes(grandParent)
        local tree = NuiTree({
            bufnr = bottom_left_popup.bufnr,
            nodes = nodetable
        })
        tree:render()
    end



    local top_popup = Menu(
        {
            border = {
                style = 'rounded',
                text =
                {
                    top = string.sub(vim.fn.getcwd(), -20),
                    top_align = 'left'
                }
            }
        },
        {
            lines = fileToItems(),
            max_width = 20,
            keymap = {
                focus_next = { "j", "<Down>", "<Tab>" },
                focus_prev = { "k", "<Up>", "<S-Tab>" },
                close = { "<Esc>", "q" },
                submit = { "<CR>", "<Space>" },
            },
            on_close = function()
                print("CLOSED")
            end,
            on_submit = function(node)
                print("SUBMITTED")
            end,
            on_change = function(node)
                updateNext(node.location, node.isDirectory)
                updatePrev(node.location)
            end
        })

    local layout = Layout(
        {
            position = { row = 0, col = 1 },
            size = {
                width = '30%',
                height = '105%',
            },
        },
        Layout.Box({
            Layout.Box(top_popup, { size = "60%" }),
            Layout.Box({

                Layout.Box(bottom_right_popup, { size = { height = '60%', width = '100%' } }),
                Layout.Box(bottom_left_popup, { size = { height = '40%', width = '100%' } }),
            }, { dir = "col", size = "40%" }),
        }, { dir = "col" })
    )

    layout:mount()
end

function M.setup(opts)
    if opts then
        vim.keymap.set("n", "<Leader>h", function()
            M.popup()
        end)
    else
        print("opts is nil or false!")
    end
end

return M
