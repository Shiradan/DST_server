-- This information tells other players more about the mod
name = "Bee Nice"
description = "Bees no longer attack you when harvesting their honey while wearing the Beekeeper Hat."
author = "Ryuu, original by =|:3"
version = "0.7"

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
-- Example:
-- http://forums.kleientertainment.com/showthread.php?19505-Modders-Your-new-friend-at-Klei!
-- becomes
-- 19505-Modders-Your-new-friend-at-Klei!
forumthread = "25059-Download-Sample-Mods"

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

icon_atlas = "bee_nice.xml"
icon = "bee_nice.tex"

-- Only compatible with Don't Starve Together
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true

all_clients_require_mod = false

--This let's the game know that this mod doesn't need to be listed in the server's mod listing
client_only_mod = false

--These tags allow the server running this mod to be found with filters from the server listing screen
server_filter_tags = {"bee_nice"}

configuration_options =
{
	{
		name = "RELEASE_BEES",
		label = "Release bees?",
		hover = "Sets if the bees should pacifically leave their home when it's harvested.",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false}
					},
		default = false
	},
	{
		name = "HAT_DECAY",
		label = "Hat Degradation",
		hover = "Sets if the Beekeeper Hat durability should go down on Beebox harvests.",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false}
					},
		default = false
	},
	{
		name = "SPRING_BEES",
		label = "Neutral Spring Bees",
		hover = "Sets if bees should be passive in Spring while earing the Beekeeper Hat.",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false}
					},
		default = true
	}
}