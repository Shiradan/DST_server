name = "  Gilgamesh(fate/zero)"
description = "2021年2月15日更新:具体见创意工坊更新日志\n有bug直接steam留言即可。\n玩法介绍：\n（1）初始自带一个王律键和一本王的日记，标记敌人后按C可以打开王之财宝攒射敌人；王之日记是一个说明书，右键可以看到一些指示。\n。\n（2）独有制造栏“王之宝库”，其中可以制作备用钥匙、乖离剑等物品；\n（3）黄金律：工作的时候会获得黄金块的奖励；\n(4)吉尔伽美什作为弓兵本体十分脆弱，饱食上限不高但是饥饿速度会因为英灵化的身体而变慢。"
author = "Procupine"
version = "0.6.7.3" 
forumthread = ""
api_version = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {
"character",
}

configuration_options = { 

	{ 
	name = "Language", 
	label = "语言Language", 
	hover = "中文/English", 
	options = { 
		{description = "Chinese", data = "cn"}, 	
		{description = "English", data = "el"}, 
	}, 
	default = "cn", }, 

	{ 
	name = "PingA_Range", 
	label = "平A范围AttackRange", 
	hover = "正常Normal/及远Far", 
	options = { 
		{description = "Normal", data = "normal"}, 	
		{description = "Far", data = "far"}, 
	}, 
	default = "normal", }, 


} 