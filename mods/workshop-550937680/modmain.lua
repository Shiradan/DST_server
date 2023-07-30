PrefabFiles = {
	"hastur",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/hastur.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/hastur.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/hastur.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/hastur.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/hastur_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/hastur_silho.xml" ),

    Asset( "IMAGE", "bigportraits/hastur.tex" ),
    Asset( "ATLAS", "bigportraits/hastur.xml" ),
	
	Asset( "IMAGE", "images/map_icons/hastur.tex" ),
	Asset( "ATLAS", "images/map_icons/hastur.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_hastur.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_hastur.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_hastur.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_hastur.xml" ),
    Asset("SOUNDPACKAGE", "sound/hastur.fev"),
    Asset("SOUND", "sound/hastur.fsb"),
}
RemapSoundEvent( "dontstarve/characters/hastur/death_voice", "hastur/hastur/death_voice" )
RemapSoundEvent( "dontstarve/characters/hastur/hurt", "hastur/hastur/hurt" )
RemapSoundEvent( "dontstarve/characters/hastur/talk_LP", "hastur/hastur/talk_LP" )


local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.HASTUR = "The King in Yellow"
STRINGS.CHARACTER_NAMES.HASTUR = "Hastur"
STRINGS.CHARACTER_DESCRIPTIONS.HASTUR = "*He need not eat\n*He feeds upon death itself\n*The night holds him not in its sway"
STRINGS.CHARACTER_QUOTES.HASTUR = "\"...but stranger still is lost Carcosa.\""

-- Custom speech strings
STRINGS.CHARACTERS.HASTUR = require "speech_hastur"

-- The character's name as appears in-game 
STRINGS.NAMES.HASTUR = "Hastur"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HASTUR = 
{
	GENERIC = "It's Hastur!",
	ATTACKER = "Hastur is a beast like no earthly beast!",
	MURDERER = "Murderer!",
	REVIVER = "Hastur, walker of the black ways",
	GHOST = "Hastur must be reborn!",
}


AddMinimapAtlas("images/map_icons/hastur.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("hastur", "PLURAL")

