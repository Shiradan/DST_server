-- This information tells other players more about the mod
name = "Wormhole icons"
description = "Adds icons for matching wormholes."
author = "Ryuu"
version = "1.2"

icon_atlas = "wormhole_icons.xml"
icon = "wormhole_icons.tex"

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
-- Example:
-- http://forums.kleientertainment.com/showthread.php?19505-Modders-Your-new-friend-at-Klei!
-- becomes
-- 19505-Modders-Your-new-friend-at-Klei!
forumthread = "25059-Download-Sample-Mods"

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version_dst = 10
priority = 0

-- Only compatible with DST
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true


--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = false

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = true

--These tags allow the server running this mod to be found with filters from the server listing screen
server_filter_tags = {""}

local ScaleValues = {}
local MinScale = 0.6 -- actually 0.7
for i=1, 4 do
	ScaleValues[i] = {description = "" .. (MinScale + i*0.1), data = (MinScale + i*0.1)}
end

configuration_options =
{
	{
		name = "DISPLAY_NUMBERS",
		label = "Display Numbers",
		hover = "Should numbers be displayed over wormholes?",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "SCALE",
		label = "Scale",
		hover = "Sets the wormhole icons scale",
		options =	ScaleValues,
		default = 1,
	},
}