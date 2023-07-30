-- This information tells other players more about the mod
name = "illya"
description = "魔法少女伊利亚: \n a character from Fate/kaleid liner 魔法少女☆伊莉雅。\n"
author = "四季酱"
version = "0.1.4" -- This is the version of the template. Change it to your own number.

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""


-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false

-- Character mods need this set to true
all_clients_require_mod = true 

icon_atlas = "modicon.xml" 
icon = "modicon.tex" 

-- The mod's tags displayed on the server list
server_filter_tags = {
"character",
}

configuration_options =
{
	{
        name = "lang1",
        label = "语言（language）", --选项栏测试用
        hover = "choose your language",
        options =
        {
			{description = "english", data = 0},
			{description = "中文", data = 1},
        },
        default = 1,
    },
    {
        name = "magic_regene",
        label = "san值回复速度(recover)", --选项栏测试用
        hover = "magic regeneration multiply",
        options =
        {
			{description = "不需要基础回复", data = 0, hover = "no regeneration"},
			{description = "少量回复", data = 1, hover = "some regeneration"},
			{description = "中等水平", data = 2, hover = "nomal regeneration"},
			{description = "快速回复", data = 3, hover = "height regeneration"},
			{description = "无限活力", data = 4, hover = "ultra regeneration"},
        },
        default = 2,
    },
} 