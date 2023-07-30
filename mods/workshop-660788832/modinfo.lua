name = "SpiderMan"
description = "Play as Spider Man."
author = "Freezer"
version = "1.0.2"

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
"spider",
"spiderman",
}


configuration_options =
{
    {
		name = "spidermanbasehp",
		label = "Spiderman's HP:",
		options =
		{
			{description = "50", data = 50},
			{description = "100", data = 100},
			{description = "150(Default)", data = 150},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "10000", data = 10000},
		},
		default = 150,
	},
	
	{
		name = "spidermanbasesanity",
		label = "Spiderman's Sanity:",
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
		name = "spidermanbasehunger",
		label = "Spiderman's Hunger:",
		options =
		{
			{description = "50", data = 50},
			{description = "100(Default)", data = 100},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "10000", data = 10000},
		},
		default = 100,
	},
	{
		name = "spidermanbasedamage",
		label = "Spider man's Damage:",
		options =
		{
			{description = "low", data = 0.75,hover = "Like Wendy "},
			{description = "normal", data = 1,hover = "Like Wilson"},
			{description = "high", data = 2,hover = "x 2"},
			{description = "higher", data = 5,hover = "x 5"},
			{description = "highest", data = 10,hover = "x 10"},
			{description = "1000x", data = 10000,hover = "x 1000"},
		},
		default = 1,
	},
	
	{
		name = "spidermanbasehungerdrains",
		label = "Spider man's Hunger Rate:",
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
	
	{
		name = "shieldbasedamage",
		label = "Shield's Damage:",
		options =
		{
			{description = "low", data = 30,hover = "30 Damage"},
			{description = "normal", data = 50,hover = "50 Damage"},
			{description = "high", data = 60,hover = "60 Damage"},
			{description = "higher", data = 100,hover = "100 Damage"},
			{description = "highest", data = 1000,hover = "1000 Damage"},
			{description = "10000", data = 10000,hover = "10000 Damage"},
		},
		default = 50,
	},
	
	{
		name = "shieldspeed",
		label = "Shield's speed:",
		options =
		{
			{description = "More slowly", data = 8,hover = "8 speed"},
			{description = "Slowly", data = 10,hover = "10 speed"},
			{description = "normal", data = 12,hover = "Like Boomerang"},
			{description = "Fast", data = 20,hover = "20 speed"},
			{description = "Faster", data = 30,hover = "30 speed"},
		},
		default = 12,
	},
}