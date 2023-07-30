--The name of this mod. (You can see it by clicking on 'mods' button in menu or at configurating of your world)
name = "Moar Metals [DST]"

--A description of this mod.
description = "Adds more new metals and things maded from it."

--Man, who wrote this mod.
author = "Cr3ePMaN"

--A version of mod
version = "1.4.2"

--This lets other players know if your mod is out of date. This typically needs to be updated every time there's a new game update.
api_version = 10

dont_starve_compatible = true	
reign_of_giants_compatible = true
dst_compatible = true
sw_compatible = false

--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = true
clients_only_mod = false
server_only_mod = true

--Link to Steam Workshop
forumthread = "http://steamcommunity.com/sharedfiles/filedetails/?id=737366433"

--Icon of this mod
icon_atlas = "MoarMetals.xml"
icon = "MoarMetals.tex"


 configuration_options =
{
	{
		name = "rock_rarity",
		label = "Boulder Rarity",
		options =
		{
			{description = "Are they spawned?", data = 0.01},
			{description = "Ultra rare", data = 0.05},
			{description = "Rare", data = 0.1},
			{description = "Few", data = 0.5},
			{description = "Normal", data = 1.0},
			{description = "Few more", data = 1.5},
			{description = "Many", data = 2.0},
			{description = "Lots!", data = 3.0},
			{description = "It's a BoulderLand?", data = 5.0}
		},
		default = 1.0
	},
	{
		name = "lang",
		label = "Language",
		options =
		{
			{description = "English", data = 0},
			{description = "Русский", data = 1}
		},
		default = 0
	}
}


