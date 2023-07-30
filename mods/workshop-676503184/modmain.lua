PrefabFiles = {
	"deadpool",
	"deadpool_none",
	"katanas",
	"dppda",
	"dpgun",
	"dpclip",
	"dpbomb",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/deadpool.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/deadpool.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/deadpool.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/deadpool.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/deadpool_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/deadpool_silho.xml" ),

    Asset( "IMAGE", "bigportraits/deadpool.tex" ),
    Asset( "ATLAS", "bigportraits/deadpool.xml" ),
	
	Asset( "IMAGE", "images/map_icons/deadpool.tex" ),
	Asset( "ATLAS", "images/map_icons/deadpool.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_deadpool.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_deadpool.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_deadpool.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_deadpool.xml" ),
	
    Asset("SOUNDPACKAGE", "sound/deadpool.fev"),
    Asset("SOUND", "sound/deadpool.fsb"),
	
	Asset( "ATLAS", "images/hud/deadpooltab.xml" ),
	Asset( "IMAGE", "images/hud/deadpooltab.tex" ),
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local resolvefilepath = GLOBAL.resolvefilepath

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

---------------------------------------------------------------
TUNING.DEADPOOL_BASE_HP = GetModConfigData("deadpoolbasehp")
TUNING.DEADPOOL_SANITY = GetModConfigData("deadpoolbasesanity")
TUNING.DEADPOOL_HUNGER = GetModConfigData("deadpoolbasehunger")
TUNING.DEADPOOL_HP_Regen = GetModConfigData("deadpoolbasehpregen")
TUNING.DEADPOOL_DAMAGE = GetModConfigData("deadpoolbasedamage")
TUNING.KATANAS_DAMAGE = GetModConfigData("katanasbasedamage")
TUNING.TELEPORT_SANITY = GetModConfigData("teleportdodelta")
---------------------------------------------------------------

GLOBAL.STRINGS.NAMES.KATANAS = "Katana"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.KATANAS = "a set of sharpened swords"

GLOBAL.STRINGS.NAMES.DPPDA = "Teleport"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DPPDA = "Im Jumper!"

GLOBAL.STRINGS.NAMES.DPCLIP = "Ammo"
GLOBAL.STRINGS.RECIPE_DESC.DPCLIP = "It's Ammo!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DPCLIP = "Ammo for Deadpool's gun."

RemapSoundEvent( "dontstarve/characters/deadpool/death_voice", "deadpool/deadpool/death_voice" )
RemapSoundEvent( "dontstarve/characters/deadpool/hurt", "deadpool/deadpool/hurt" )
RemapSoundEvent( "dontstarve/characters/deadpool/talk_LP", "deadpool/deadpool/talk_LP" )

--Deadpool Tab

local deadpooltab = AddRecipeTab( "Deadpool's Tab", 996, "images/hud/deadpooltab.xml", "deadpooltab.tex", "deadpool_builder")

AddRecipe("katanas", 
{GLOBAL.Ingredient("goldnugget", 5), GLOBAL.Ingredient("flint", 10), GLOBAL.Ingredient("cutstone", 10)},
deadpooltab, TECH.NONE, nil, nil, nil, nil, "deadpool_builder", 
"images/inventoryimages/katanas.xml", "katanas.tex" )

AddRecipe("dpgun", 
{GLOBAL.Ingredient("lightninggoathorn", 3), GLOBAL.Ingredient("transistor", 4), GLOBAL.Ingredient("gears", 4)},
deadpooltab, TECH.NONE, nil, nil, nil, nil, "deadpool_builder", 
"images/inventoryimages/dpgun.xml", "dpgun.tex" )

AddRecipe("dpclip", 
{GLOBAL.Ingredient("charcoal", 5), Ingredient("nitre", 1)},
deadpooltab, TECH.NONE, nil, nil, nil, 12, "deadpool_builder", 
"images/inventoryimages/dpclip.xml", "dpclip.tex" )

AddRecipe("dpbomb", 
{GLOBAL.Ingredient("gunpowder", 1), Ingredient("nitre", 1)},
deadpooltab, TECH.NONE, nil, nil, nil, 3, "deadpool_builder", 
"images/inventoryimages/dpbomb.xml", "dpbomb.tex" )


-- Custom Recipe Desc
STRINGS.RECIPE_DESC.KATANAS = "A set of sharpened swords" 
STRINGS.RECIPE_DESC.DPGUN = "Pistol!"
STRINGS.RECIPE_DESC.DPCLIP = "Ammo!"
STRINGS.RECIPE_DESC.DPBOMB = "Boom!"


-- The character select screen lines
STRINGS.CHARACTER_TITLES.deadpool = "Deadpool"
STRINGS.CHARACTER_NAMES.deadpool = "Deadpool"
STRINGS.CHARACTER_DESCRIPTIONS.deadpool = "*Healing factor\n*Not afraid of monsters\n*Low sanity"
STRINGS.CHARACTER_QUOTES.deadpool = "\"Hey! everyone\""

-- Custom speech strings
STRINGS.CHARACTERS.DEADPOOL = require "speech_deadpool"

-- The character's name as appears in-game 
STRINGS.NAMES.DEADPOOL = "Dead pool"

AddMinimapAtlas("images/map_icons/deadpool.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("deadpool", "MALE")

