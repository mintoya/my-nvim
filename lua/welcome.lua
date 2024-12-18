local if_nil = vim.F.if_nil

local default_terminal = {
    type = "terminal",
    command = nil,
    width = 69,
    height = 8,
    opts = {
        redraw = true,
        window_config = {},
    },
}

local default_header = {
    type = "text",
    val = {
[[$$$$$$$\                           $$\    $$\$$\              ]],
[[$$  __$$\                          $$ |   $$ \__|             ]],
[[$$ |  $$ |$$$$$$\ $$$$$$$$\ $$$$$$\$$ |   $$ $$\$$$$$$\$$$$\  ]],
[[$$$$$$$\ $$  __$$\\____$$  $$  __$$\$$\  $$  $$ $$  _$$  _$$\ ]],
[[$$  __$$\$$ /  $$ | $$$$ _/$$ /  $$ \$$\$$  /$$ $$ / $$ / $$ |]],
[[$$ |  $$ $$ |  $$ |$$  _/  $$ |  $$ |\$$$  / $$ $$ | $$ | $$ |]],
[[$$$$$$$  \$$$$$$  $$$$$$$$\\$$$$$$  | \$  /  $$ $$ | $$ | $$ |]],
[[\_______/ \______/\________|\______/   \_/   \__\__| \__| \__|]]
    },
    opts = {
        position = "center",
        hl = "Type",
    },
}

local footer = {
    type = "text",
    val = "inspiring quote",
    opts = {
        position = "center",
        hl = "Number",
    },
}

local leader = "󱁐 "

local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button(leader.." f h", " Recently opened files"),
        button(" "..leader.." e","  File tree "),
        button(leader.." f f", "󰈞  Find file"),
        button(leader.." f t", "󰈬  Find text"),
    },
    opts = {
        spacing = 1,
    },
}

local section = {
    terminal = default_terminal,
    header = default_header,
    buttons = buttons,
    footer = footer,
}

local config = {
    layout = {
        { type = "padding", val = 10 },
        section.header,
        { type = "padding", val = 10 },
        section.buttons,
        section.footer,
        { type = "padding", val = 20 },
    },
    opts = {
        margin = 5,
    },
}

return {
    button = button,
    section = section,
    config = config,
    -- theme config
    leader = leader,
    -- deprecated
    opts = config,
}
