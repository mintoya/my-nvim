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

local welcomeScrens = {
	{
[[      _____         _____      _____                _____    ____      ____ ____     ______  _______   ]],
[[ ___|\     \   ____|\    \    /    /|___       ____|\    \  |    |    |    |    |   |      \/       \  ]],
[[|    |\     \ /     /\    \  /    /|    |     /     /\    \ |    |    |    |    |  /          /\     \ ]],
[[|    | |     /     /  \    \|\____\|    |    /     /  \    \|    |    |    |    | /     /\   / /\     |]],
[[|    | /_ _ |     |    |    | |   |/    |___|     |    |    |    |    |    |    |/     /\ \_/ / /    /|]],
[[|    |\    \|     |    |    |\|___/    /    |     |    |    |    |    |    |    |     |  \|_|/ /    / |]],
[[|    | |    |\     \  /    /|   /     /|    |\     \  /    /|\    \  /    /|    |     |       |    |  |]],
[[|____|/____/| \_____\/____/ |  |_____|/____/| \_____\/____/ | \ ___\/___ / |____|\____\       |____|  /]],
[[|    /     ||\ |    ||    | /  |     |    | |\ |    ||    | /\ |   ||   | /|    | |    |      |    | / ]],
[[|____|_____|/ \|____||____|/   |_____|____|/  \|____||____|/  \|___||___|/ |____|\|____|      |____|/  ]],
[[  \(    )/       \(    )/        \(    )/        \(    )/       \(    )/     \(     \(          )/     ]],
[[   '    '         '    '          '    '          '    '         '    '       '      '          '      ]]
	},
	{
[[    ,---,.                                                                 ____   ]],
[[  ,'  .'  \                                        ,---.  ,--,           ,'  , `. ]],
[[,---.' .' |   ,---.         ,----,   ,---.        /__./|,--.'|        ,-+-,.' _ | ]],
[[|   |  |: |  '   ,'\      .'   .`|  '   ,'\  ,---.;  ; ||  |,      ,-+-. ;   , || ]],
[[:   :  :  / /   /   |  .'   .'  .' /   /   |/___/ \  | |`--'_     ,--.'|'   |  || ]],
[[:   |    ; .   ; ,. :,---, '   ./ .   ; ,. :\   ;  \ ' |,' ,'|   |   |  ,', |  |, ]],
[[|   :     \'   | |: :;   | .'  /  '   | |: : \   \  \: |'  | |   |   | /  | |--'  ]],
[[|   |   . |'   | .; :`---' /  ;--,'   | .; :  ;   \  ' .|  | :   |   : |  | ,     ]],
[['   :  '; ||   :    |  /  /  / .`||   :    |   \   \   ''  : |__ |   : |  |/      ]],
[[|   |  | ;  \   \  / ./__;     .'  \   \  /     \   `  ;|  | '.'||   | |`-'       ]],
[[|   :   /    `----'  ;   |  .'      `----'       :   \ |;  :    ;|   ;/           ]],
[[|   | ,'             `---'                        '---" |  ,   / '---'            ]],
[[`----'                                                   ---`-'                   ]]
},{
[[$$$$$$$\                           $$\    $$\$$\              ]],
[[$$  __$$\                          $$ |   $$ \__|             ]],
[[$$ |  $$ |$$$$$$\ $$$$$$$$\ $$$$$$\$$ |   $$ $$\$$$$$$\$$$$\  ]],
[[$$$$$$$\ $$  __$$\\____$$  $$  __$$\$$\  $$  $$ $$  _$$  _$$\ ]],
[[$$  __$$\$$ /  $$ | $$$$ _/$$ /  $$ \$$\$$  /$$ $$ / $$ / $$ |]],
[[$$ |  $$ $$ |  $$ |$$  _/  $$ |  $$ |\$$$  / $$ $$ | $$ | $$ |]],
[[$$$$$$$  \$$$$$$  $$$$$$$$\\$$$$$$  | \$  /  $$ $$ | $$ | $$ |]],
[[\_______/ \______/\________|\______/   \_/   \__\__| \__| \__|]]
}

}
math.randomseed(os.time())
local default_header = {
    type = "text",
    val = welcomeScrens[math.random(1,3)],
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

local function button(sc, txt,onpress)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    local on_press = function()
	    onpress()
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local cmd = function(command)
	return(
		function()
			vim.cmd(command);
		end
	)
end
local buttons = {
    type = "group",
    val = {
        button(leader.." f h", " Recently opened files",cmd('Telescope oldfiles')),
        button(" "..leader.." c","  Change color scheme ",cmd('Telescope themes')),
        button(" "..leader.." e","  File tree ",cmd('Neotree focus')),
        button(leader.." f f", "󰈞  Find file",cmd('Telescope find_files')),
        button(leader.." f t", "󰈬  Find text",cmd('Telescope live_grep')),
        button(" nil ", "  Open config",cmd('cd '..vim.fn.stdpath('config').." |Telescope find_files")),
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
        { type = "padding", val = 5 },
        section.buttons,
        section.footer,
        { type = "padding", val = 30 },
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
