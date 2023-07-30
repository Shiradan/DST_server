name = "Too Many Items 更新汉化"
forumthread = "" 
description = "原作者是 C.J.B.\nGaRAnTuLA 修复了BUG.\n Skull重新写了代码.\n自由生成物品.只要你是主机或是管理员.\n按T键显示菜单.\n单击默认生成1个物品.\n右击默认生成10个物品.\n键位设置和生成物品的个数可以在MOD选项中更改"
author = "一地鸡毛"
version = "0.4.1"
api_version = 10
priority = -7000
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true
version_compatible  = "0.3.7"
all_clients_require_mod = false
client_only_mod = true
server_filter_tags = { }

icon_atlas = "TooManyItems.xml"
icon = "TooManyItems.tex"

local alpha = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local KEY_A = 97
local keyslist = {}
for i = 1,#alpha do keyslist[i] = {description = alpha[i],data = i + KEY_A - 1} end

configuration_options =
{
	{
		name = "KEYBOARD_TOGGLE_KEY",
		label = "菜单按钮",
		hover = "显示TMI菜单的按键.",
		options = keyslist,
		default = 116, --T
	},
	{
		name = "TMI_L_CLICK_NUM",
		label = "左击资源",
		hover = "你获得的资源数量.",
		options =
		{
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
		},
		default = 1,
	},
	{
		name = "TMI_R_CLICK_NUM",
		label = "右击资源",
		hover = "你获得的资源数量.",
		options =
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
		},
		default = 10,
	},
}