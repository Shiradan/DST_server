-- This information tells other players more about the mod
name = "Lancer(Fate/Stay Night)"
description = "Lancer from the Fate/Stay Night Series."
author = "Arcade and Silhh"
version = "1.0.3" -- This is the version of the template. Change it to your own number.

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = "/files/file/950-extended-sample-character/"


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
		name = "SMALL_MISS_CHANCE",
		label = "Miss Small Creatures",
		options =	{
						{description = "100%", data = 2},
						{description = "90%", data = 0.9},
						{description = "80%", data = 0.8},
						{description = "70%", data = 0.7},
						{description = "60%", data = 0.6},
						{description = "50%", data = 0.5},
						{description = "40%", data = 0.4},
						{description = "30%", data = 0.3},
						{description = "20%", data = 0.2},
						{description = "10%", data = 0.1},
						{description = "0%", data = 0},
					},

		default = 0.5,
	
	},
	{
		name = "LARGE_USES",
		label = "# Uses on Large",
		options =	{
						{description = "2", data = 2},
						{description = "3", data = 3},
						{description = "5", data = 5},
						{description = "10", data = 10},
						{description = "15", data = 15},
						{description = "25", data = 25},
						{description = "30", data = 30},
						{description = "50", data = 50},
						{description = "75", data = 75},
						{description = "150", data = 150},
					},

		default = 75,
	},
	{
		name = "SMALL_USES",
		label = "# Uses on Small",
		options =	{
						{description = "2", data = 2},
						{description = "3", data = 3},
						{description = "5", data = 5},
						{description = "10", data = 10},
						{description = "15", data = 15},
						{description = "25", data = 25},
						{description = "30", data = 30},
						{description = "50", data = 50},
						{description = "75", data = 75},
						{description = "150", data = 150},
					},

		default = 5,
	},
	{
		name = "RANGE_CHECK",
		label = "Check Range",
		options =	{
						{description = "yes", data = true},
						{description = "no", data = false},
					},

		default = true,
	},

	{
		name = "enablejab",
		label = "Do spear jabs?",
		hover = "Can be enabled or disabled.",
		options =	{	
						{description = "True", data = true, hover = "Animation is enabled."},
						{description = "False", data = false, hover = "Animation is disabled."},
					},
		default = true,
	},
		
	{
		name = "healthvalue",
		label = "Gaebolg health throw",
		hover = "Health consumption for Gaebolg throw?",
		options = {
						{description = "1", data = -1},
						{description = "5", data = -5},
						{description = "10", data = -10},
						{description = "15", data = -15},
						{description = "20", data = -20},
				},
				
		default = -5,
	
	},
	{
		name = "hungervalue",
		label = "Gaebolg hunger throw",
		hover = "Hunger consumption for Gaebolg throw.",
		options = {
						{description = "1", data = -1},
						{description = "5", data = -5},
						{description = "10", data = -10},
						{description = "15", data = -15},
						{description = "20", data = -20},
				},
				
		default = -5,
	
	},
	
	-- {
        -- name = "key",
        -- label = "Transformation Key",
        -- hover = "This is the key use to transform Lancer.",
        -- options =
        -- {
            -- {description="TAB", data = 9},
            -- {description="KP_PERIOD", data = 266},
            -- {description="KP_DIVIDE", data = 267},
            -- {description="KP_MULTIPLY", data = 268},
            -- {description="KP_MINUS", data = 269},
            -- {description="KP_PLUS", data = 270},
            -- {description="KP_ENTER", data = 271},
            -- {description="KP_EQUALS", data = 272},
            -- {description="MINUS", data = 45},
            -- {description="EQUALS", data = 61},
            -- {description="SPACE", data = 32},
            -- {description="ENTER", data = 13},
            -- {description="ESCAPE", data = 27},
            -- {description="HOME", data = 278},
            -- {description="INSERT", data = 277},
            -- {description="DELETE", data = 127},
            -- {description="END", data   = 279},
            -- {description="PAUSE", data = 19},
            -- {description="PRINT", data = 316},
            -- {description="CAPSLOCK", data = 301},
            -- {description="SCROLLOCK", data = 302},
            -- {description="RSHIFT", data = 303}, -- use SHIFT instead
            -- {description="LSHIFT", data = 304}, -- use SHIFT instead
            -- {description="RCTRL", data = 305}, -- use CTRL instead
            -- {description="LCTRL", data = 306}, -- use CTRL instead
            -- {description="RALT", data = 307}, -- use ALT instead
            -- {description="LALT", data = 308}, -- use ALT instead
            -- {description="ALT", data = 400},
            -- {description="CTRL", data = 401},
            -- {description="SHIFT", data = 402},
            -- {description="BACKSPACE", data = 8},
            -- {description="PERIOD", data = 46},
            -- {description="SLASH", data = 47},
            -- {description="LEFTBRACKET", data     = 91},
            -- {description="BACKSLASH", data     = 92},
            -- {description="RIGHTBRACKET", data = 93},
            -- {description="TILDE", data = 96},
            -- {description="A", data = 97},
            -- {description="B", data = 98},
            -- {description="C", data = 99},
            -- {description="D", data = 100},
            -- {description="E", data = 101},
            -- {description="F", data = 102},
            -- {description="G", data = 103},
            -- {description="H", data = 104},
            -- {description="I", data = 105},
            -- {description="J", data = 106},
            -- {description="K", data = 107},
            -- {description="L", data = 108},
            -- {description="M", data = 109},
            -- {description="N", data = 110},
            -- {description="O", data = 111},
            -- {description="P", data = 112},
            -- {description="Q", data = 113},
            -- {description="R", data = 114},
            -- {description="S", data = 115},
            -- {description="T", data = 116},
            -- {description="U", data = 117},
            -- {description="V", data = 118},
            -- {description="W", data = 119},
            -- {description="X", data = 120},
            -- {description="Y", data = 121},
            -- {description="Z", data = 122},
            -- {description="F1", data = 282},
            -- {description="F2", data = 283},
            -- {description="F3", data = 284},
            -- {description="F4", data = 285},
            -- {description="F5", data = 286},
            -- {description="F6", data = 287},
            -- {description="F7", data = 288},
            -- {description="F8", data = 289},
            -- {description="F9", data = 290},
            -- {description="F10", data = 291},
            -- {description="F11", data = 292},
            -- {description="F12", data = 293},
 
            -- {description="UP", data = 273},
            -- {description="DOWN", data = 274},
            -- {description="RIGHT", data = 275},
            -- {description="LEFT", data = 276},
            -- {description="PAGEUP", data = 280},
            -- {description="PAGEDOWN", data = 281},
 
            -- {description="0", data = 48},
            -- {description="1", data = 49},
            -- {description="2", data = 50},
            -- {description="3", data = 51},
            -- {description="4", data = 52},
            -- {description="5", data = 53},
            -- {description="6", data = 54},
            -- {description="7", data = 55},
            -- {description="8", data = 56},
            -- {description="9", data = 57},
        -- },
        -- default = 122,
    -- },
}