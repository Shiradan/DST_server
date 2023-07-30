PrefabFiles = {
	"spiderman",
	"spiderman_none",
	"shield",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/spiderman.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/spiderman.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/spiderman.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/spiderman.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/spiderman_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/spiderman_silho.xml" ),

    Asset( "IMAGE", "bigportraits/spiderman.tex" ),
    Asset( "ATLAS", "bigportraits/spiderman.xml" ),
	
	Asset( "IMAGE", "images/map_icons/spiderman.tex" ),
	Asset( "ATLAS", "images/map_icons/spiderman.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_spiderman.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_spiderman.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_spiderman.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_spiderman.xml" ),
	
    Asset("SOUNDPACKAGE", "sound/spiderman.fev"),
    Asset("SOUND", "sound/spiderman.fsb"),
	
	Asset( "ATLAS", "images/hud/spidermantab.xml" ),
	Asset( "IMAGE", "images/hud/spidermantab.tex" ),
	
	Asset("ATLAS", "images/inventoryimages/silker.xml"),
    Asset("IMAGE", "images/inventoryimages/silker.tex"),
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local resolvefilepath = GLOBAL.resolvefilepath

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

---------------------------------------------------------------
TUNING.SPIDERMAN_BASE_HP = GetModConfigData("spidermanbasehp")
TUNING.SPIDERMAN_SANITY = GetModConfigData("spidermanbasesanity")
TUNING.SPIDERMAN_HUNGER = GetModConfigData("spidermanbasehunger")
TUNING.SPIDERMAN_DAMAGE = GetModConfigData("spidermanbasedamage")
TUNING.SPIDERMAN_HUNGER_RATE = GetModConfigData("spidermanbasehungerdrains")
TUNING.SHIELD_DAMAGE = GetModConfigData("shieldbasedamage")
TUNING.SHIELD_SPEED = GetModConfigData("shieldspeed")
---------------------------------------------------------------

GLOBAL.STRINGS.NAMES.SHIELD = "Captain America's Shield"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHIELD = "Boomerang auto catch"

RemapSoundEvent( "dontstarve/characters/spiderman/death_voice", "spiderman/spiderman/death_voice" )
RemapSoundEvent( "dontstarve/characters/spiderman/hurt", "spiderman/spiderman/hurt" )
RemapSoundEvent( "dontstarve/characters/spiderman/talk_LP", "spiderman/spiderman/talk_LP" )

--Spiderman Tab

local spidermantab = AddRecipeTab( "Spiderman's Tab", 996, "images/hud/spidermantab.xml", "spidermantab.tex", "spiderman_builder")



AddRecipe("silk", 
{GLOBAL.Ingredient("spidergland", 2), GLOBAL.Ingredient("butterflywings", 2)},
spidermantab, TECH.NONE, nil, nil, nil, 20, "spiderman_builder",
"images/inventoryimages/silker.xml", "silker.tex" )

STRINGS.RECIPE_DESC.SILK = "Spiderman produces good silk"

-- Quick pickin thanks san
local myhandler = GLOBAL.ActionHandler(GLOBAL.ACTIONS.PICK, function(inst, action)
	if action.target.components.pickable then
		if action.target.components.pickable.quickpick or inst.prefab == "spiderman" then
			return "doshortaction"
		else
			return "dolongaction"
		end
	end
end)

AddStategraphActionHandler("wilson", myhandler)

-- The character select screen lines
STRINGS.CHARACTER_TITLES.spiderman = "Spider Man"
STRINGS.CHARACTER_NAMES.spiderman = "Spider Man"
STRINGS.CHARACTER_DESCRIPTIONS.spiderman = "*Fast (move, harvest, chop)\n*Can see in the dark \n*Has fast hunger drains"
STRINGS.CHARACTER_QUOTES.spiderman = "\"Hey! everyone\""

-- Custom speech strings
STRINGS.CHARACTERS.SPIDERMAN = require "speech_spiderman"

-- The character's name as appears in-game 
STRINGS.NAMES.SPIDERMAN = "Spider Man"

AddMinimapAtlas("images/map_icons/spiderman.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("spiderman", "MALE")

