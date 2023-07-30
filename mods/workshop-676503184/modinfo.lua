name = "Deadpool"
description = "Play as Deadpool."
author = "Freezer"
version = "1"

forumthread = "/files/file/1463-spiderpool-dst/"

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
"character",
"deadpool",
"dead",
"pool",
}


configuration_options =
{
    {
		name = "deadpoolbasehp",
		label = "Deadpool's HP",
		options =
		{
			{description = "50", data = 50},
			{description = "150(Default)", data = 150},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "10000", data = 10000},
		},
		default = 150,
	},
	
	{
		name = "deadpoolbasesanity",
		label = "Deadpool's Sanity",
		options =
		{
			{description = "20(Default)", data = 20},
			{description = "50", data = 50},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "10000", data = 10000},
		},
		default = 20,
	},
	
	{
		name = "deadpoolbasehunger",
		label = "Deadpool's Hunger",
		options =
		{
			{description = "50", data = 50},
			{description = "100(Default)", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "10000", data = 10000},
		},
		default = 100,
	},
	
	
	{
		name = "deadpoolbasehpregen",
		label = "Deadpool's Health Regen",
		options =
		{
			{description = "0.5 per 1 sec", data = 0.5,hover = "0.5 hp every 1 seconds"},
			{description = "1 per 1 sec", data = 1,hover = "1 hp every 1 seconds"},
			{description = "2 per 1 sec", data = 2,hover = "2 hp every 1 seconds"},
			{description = "5 per 1 sec", data = 5,hover = "5 hp every 1 seconds"},
			{description = "10 per 1 sec", data = 10,hover = "10 hp every 1 seconds"},
			{description = "10000 per 1 sec", data = 10000,hover = "10000 hp every 1 seconds"},
		},
		default = 1,
	},
	
	{
		name = "deadpoolbasedamage",
		label = "Deadpool's Damage",
		options =
		{
			{description = "low", data = 0.75,hover = "Like Wendy "},
			{description = "normal", data = 1,hover = "Like Wilson"},
			{description = "high", data = 2,hover = "Willson x 2"},
			{description = "higher", data = 5,hover = "Willson x 5"},
			{description = "highest", data = 10,hover = "Willson x 10"},
			{description = "1000x", data = 10000,hover = "Willson x 1000"},
		},
		default = 1,
	},
--[[	
	{
		name = "deadpoolbasehungerdrains",
		label = "Deadpool's Hunger Rate:",
		hover = "Change your hunger drains",
		options =
		{
			{description = "Fastest", data = 0.4},
			{description = "Faster", data = 0.2},
			{description = "Fast", data = 0.15},
			{description = "normal", data = 0.1,hover = "Like Wilson"},
			{description = "Slowly", data = 0.01},
			{description = "stop hunger", data = 0},
		},
		default = 0.15,
	},
]]	
	{
		name = "katanasbasedamage",
		label = "Katanas's Damage",
		options =
		{
			{description = "low", data = 20,hover = "20 Damage"},
			{description = "normal", data = 30,hover = "30 Damage"},
			{description = "high", data = 60,hover = "60 Damage"},
			{description = "higher", data = 100,hover = "100 Damage"},
			{description = "highest", data = 1000,hover = "1000 Damage"},
			{description = "10000", data = 10000,hover = "10000 Damage"},
		},
		default = 30,
	},
	{
		name = "teleportdodelta",
		label = "Teleport",
		hover = "sanity while teleport",
		options =
		{
			{description = "+10", data = 10,hover = "+10 sanity"},
			{description = "+5", data = 5,hover = "+5 sanity"},
			{description = "+3", data = 3,hover = "+3 sanity"},
			{description = "no", data = 0,hover = "don't use sanity"},
			{description = "normal", data = -1,hover = "-1 sanity"},
			{description = "-3", data = -3,hover = "-3 sanity"},
			{description = "-5", data = -5,hover = "-5 sanity"},
			{description = "-10", data = -10,hover = "-10 sanity"},
		},
		default = -5,
	},
}