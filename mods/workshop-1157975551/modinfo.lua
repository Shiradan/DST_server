name = "Extended Map Icons"
version = "1.12"
description = "Add more icons to the map. Includes all the mobs, basic tools, flowers, gold nuggets, rocks, flints, and more."
author = "IceGrog"
forumthread = ""
icon = "modicon.tex"
icon_atlas = "modicon.xml"

api_version = 10

dont_starve_compatible = true
reign_of_giants_compatible = true
all_clients_require_mod = false
dst_compatible = true
client_only_mod = true

configuration_options = {
  {
    name = "Icons_Border",
    label = "Icons Border",
    default = "red_yellow",
    options = {
		{description = "Red", data = "red"},
		{description = "Yellow", data = "yellow"},
		{description = "Red/Yellow", data = "red_yellow"},
		{description = "Disabled", data = false}
	}
  },
  {
    name = "Basic_Mobs",
    label = "Basic Mobs",
    default = true,
	hover = "Show basic mobs in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "More_Mobs",
    label = "More Mobs (LAG)",
    default = false,
	hover = "Show more mobs in the map. This can cause some lag.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Giants",
    label = "Giants",
    default = true,
	hover = "Show giants in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Tools",
    label = "Tools",
    default = true,
	hover = "Show all basic tools droped in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Minerals",
    label = "Minerals",
    default = true,
	hover = "Show golds, rocks and flints droped in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Bones",
    label = "Bones",
    default = true,
	hover = "Show bones of human and animals in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Holes",
    label = "Holes",
    default = true,
	hover = "Show rabits, crabs and moles holes in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Vegetation",
    label = "Vegetation",
    default = true,
	hover = "Show mushrooms, carrots and seeds in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Flowers",
    label = "Flowers",
    default = false,
	hover = "Show flowers in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Pigs_Rituals",
    label = "Pigs Rituals",
    default = true,
	hover = "Show pigs and merms heads, and pigs torchs in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Walls",
    label = "Walls",
    default = true,
	hover = "Show walls in the map.",
    options = {
		{description = "Show", data = true, },
		{description = "Not show", data = false}
	}
  },
  {
    name = "Things",
    label = "Things",
    default = true,
	hover = "Show the 'Things' in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  {
    name = "Chester_Packim_Bones",
    label = "Chester's Eyebone",
    default = true,
	hover = "Show Chester's eyebone in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
    {
    name = "Tracks",
    label = "Tracks",
    default = true,
	hover = "Show tracks for koelefants in the map.",
    options = {
		{description = "Show", data = true},
		{description = "Not show", data = false}
	}
  },
  
}
