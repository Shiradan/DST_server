name = "Extended Indicators"
description = "Shows an indicator at all times, revealing the location of other players."
author = "William Akins"
version = "1.1"

forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Can specify a custom icon for this mod!
icon_atlas = "ExtendedIndicators.xml"
icon = "ExtendedIndicators.tex"

-- Specify compatibility with the game!
dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = true

all_clients_require_mod = false
clients_only_mod = false

server_filter_tags = {"indicator", "indicators", "icons", "extended indicators", "extended"}


configuration_options =
{
	{
		name = "PlayerIndicators",
		label = "Player Indicators",
		options =	{
						{description = "Enabled", data = 1},
						{description = "Disabled", data = 2},
					},
		default = 1,
	},
	{
		name = "IndicatorSize",
		label = "Indicator Size",
		options =	{
						{description = "Tiny", data = 1},
						{description = "Small", data = 2},
						{description = "Medium", data = 3},
						{description = "Large", data = 4},
					},
		default = 3,
	},
	{
		name = "MaxIndicator",
		label = "Max Indicator Range",
		options =	{
						{description = "Original", data = 50},
						{description = "Double", data = 100},
						{description = "Huge", data = 250},
						{description = "Unlimited", data = 7000},
					},
		default = 7000,
	}
}