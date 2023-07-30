name = "Chinese"
description = "黄金矛中文输入\n小地图显示玩家图标\n\n更多中文mod点击下面网址"
author = "QQ3157747"
version = "20200629"

forumthread = ""

api_version = 10

dst_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

--This lets the clients know that they need to download the mod before they can join a server that is using it.
all_clients_require_mod = true

--This let's the game know that this mod doesn't need to be listed in the server's mod listing
client_only_mod = false

server_filter_tags = {"china"}

configuration_options =
{
	{
		name = "速度",
		label = "移动速度",
		hover = "默认",
		options =	{
						{description = "1倍", data = 1, hover = "x1"},
						{description = "2倍", data = 2, hover = "x2"},
						{description = "3倍", data = 3, hover = "x3"},
					},
		default = "默认",
	},
}