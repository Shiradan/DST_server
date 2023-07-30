PrefabFiles = {
	"archer", "archer_bakuya", "archer_celtic", "archer_cutlass", "archer_excalibur", "archer_kanshou", "archer_katana", "archer_nandao", "archer_piandao", "archer_kendostick", "archer_lawsword", "archer_sandai", "archer_shusui", "archer_pearlsword", "archer_pearlspear", "archer_knife", "archer_gsword", "archer_galientsword", "archer_gkatana", "archer_needle", "archer_sanspear", "archer_none", 
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/archer.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/archer.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/archer.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/archer.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/archer_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/archer_silho.xml" ),

    Asset( "IMAGE", "bigportraits/archer.tex" ),
    Asset( "ATLAS", "bigportraits/archer.xml" ),
	
	Asset( "IMAGE", "images/map_icons/archer.tex" ),
	Asset( "ATLAS", "images/map_icons/archer.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_archer.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_archer.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_archer.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_archer.xml" ),
	
	Asset( "ATLAS", "images/hud/archertab.xml" ),
	
    Asset("SOUNDPACKAGE", "sound/archer.fev"),
	Asset("SOUND", "sound/archer.fsb"),
	
	Asset( "IMAGE", "bigportraits/archer_none.tex" ),
    Asset( "ATLAS", "bigportraits/archer_none.xml" ),
	
	Asset( "IMAGE", "images/names_archer.tex" ),
    Asset( "ATLAS", "images/names_archer.xml" ),

}

RemapSoundEvent( "dontstarve/characters/archer/death_voice", "archer/sound/death_voice" )
RemapSoundEvent( "dontstarve/characters/archer/hurt", "archer/sound/hurt" )
RemapSoundEvent( "dontstarve/characters/archer/talk_LP", "archer/sound/talk_LP" )

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local resolvefilepath = GLOBAL.resolvefilepath

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH


-- Speech strings and chat (not the actual chat text) strings converted
local function OneLine(old_message)
	return "..."
end

AddPrefabPostInit("archer", function(inst)
	inst.components.talker.mod_str_fn = OneLine
end)
-- Speech strings only

local function OneLine()
	return "..."
end

local _GetSpecialCharacterString = GLOBAL.GetSpecialCharacterString
GLOBAL.GetSpecialCharacterString = function(character)
	if character == nil then
		return nil
	end

	character = string.lower(character)

	return (character == "archer" and OneLine()) or _GetSpecialCharacterString(character)
end

--Custom Crafting Tab
archerstab = AddRecipeTab("Archer", 998, "images/hud/archertab.xml", "archertab.tex", "archerbuilder")

--Recipe

local archer_bakuya_recipe = AddRecipe("archer_bakuya",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/bakuya.xml", "bakuya.tex")
archer_bakuya_recipe.tagneeded = false
archer_bakuya_recipe.builder_tag = "archerbuilder"

local archer_sanspear_recipe = AddRecipe("archer_sanspear",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/sanspear.xml", "sanspear.tex")
archer_sanspear_recipe.tagneeded = false
archer_sanspear_recipe.builder_tag = "archerbuilder"

local archer_needle_recipe = AddRecipe("archer_needle",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/needle.xml", "needle.tex")
archer_needle_recipe.tagneeded = false
archer_needle_recipe.builder_tag = "archerbuilder"

local archer_celtic_recipe = AddRecipe("archer_celtic",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/celtic.xml", "celtic.tex")
archer_celtic_recipe.tagneeded = false
archer_celtic_recipe.builder_tag = "archerbuilder"

local archer_cutlass_recipe = AddRecipe("archer_cutlass",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/cutlass.xml", "cutlass.tex")
archer_cutlass_recipe.tagneeded = false
archer_cutlass_recipe.builder_tag = "archerbuilder"

local archer_excalibur_recipe = AddRecipe("archer_excalibur",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/excalibur.xml", "excalibur.tex")
archer_excalibur_recipe.tagneeded = false
archer_excalibur_recipe.builder_tag = "archerbuilder"

local archer_galientsword_recipe = AddRecipe("archer_galientsword",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/galientsword.xml", "galientsword.tex")
archer_galientsword_recipe.tagneeded = false
archer_galientsword_recipe.builder_tag = "archerbuilder"

local archer_gkatana_recipe = AddRecipe("archer_gkatana",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/gkatana.xml", "gkatana.tex")
archer_gkatana_recipe.tagneeded = false
archer_gkatana_recipe.builder_tag = "archerbuilder"

local archer_gsword_recipe = AddRecipe("archer_gsword",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/gsword.xml", "gsword.tex")
archer_gsword_recipe.tagneeded = false
archer_gsword_recipe.builder_tag = "archerbuilder"

local archer_kanshou_recipe = AddRecipe("archer_kanshou",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/kanshou.xml", "kanshou.tex")
archer_kanshou_recipe.tagneeded = false
archer_kanshou_recipe.builder_tag = "archerbuilder"

local archer_katana_recipe = AddRecipe("archer_katana",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/katana.xml", "katana.tex")
archer_katana_recipe.tagneeded = false
archer_katana_recipe.builder_tag = "archerbuilder"

local archer_kendostick_recipe = AddRecipe("archer_kendostick",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/kendostick.xml", "kendostick.tex")
archer_kendostick_recipe.tagneeded = false
archer_kendostick_recipe.builder_tag = "archerbuilder"

local archer_knife_recipe = AddRecipe("archer_knife",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/knife.xml", "knife.tex")
archer_knife_recipe.tagneeded = false
archer_knife_recipe.builder_tag = "archerbuilder"

local archer_lawsword_recipe = AddRecipe("archer_lawsword",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/lawsword.xml", "lawsword.tex")
archer_lawsword_recipe.tagneeded = false
archer_lawsword_recipe.builder_tag = "archerbuilder"

local archer_nandao_recipe = AddRecipe("archer_nandao",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/nandao.xml", "nandao.tex")
archer_nandao_recipe.tagneeded = false
archer_nandao_recipe.builder_tag = "archerbuilder"

local archer_pearlspear_recipe = AddRecipe("archer_pearlspear",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/pearlspear.xml", "pearlspear.tex")
archer_pearlspear_recipe.tagneeded = false
archer_pearlspear_recipe.builder_tag = "archerbuilder"

local archer_pearlsword_recipe = AddRecipe("archer_pearlsword",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/pearlsword.xml", "pearlsword.tex")
archer_pearlsword_recipe.tagneeded = false
archer_pearlsword_recipe.builder_tag = "archerbuilder"

local archer_piandao_recipe = AddRecipe("archer_piandao",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/piandao.xml", "piandao.tex")
archer_piandao_recipe.tagneeded = false
archer_piandao_recipe.builder_tag = "archerbuilder"

local archer_sandai_recipe = AddRecipe("archer_sandai",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/sandai.xml", "sandai.tex")
archer_sandai_recipe.tagneeded = false
archer_sandai_recipe.builder_tag = "archerbuilder"

local archer_shusui_recipe = AddRecipe("archer_shusui",
{GLOBAL.Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 20)},
archerstab, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/shusui.xml", "shusui.tex")
archer_shusui_recipe.tagneeded = false
archer_shusui_recipe.builder_tag = "archerbuilder"

-- Custom Items Swords(RECIPE_DESC)
STRINGS.RECIPE_DESC.ARCHER_BAKUYA = "Used by the redman." 
STRINGS.RECIPE_DESC.ARCHER_SANSPEAR = "Used by the Wolf Girl." 
STRINGS.RECIPE_DESC.ARCHER_CELTIC = "A Celtic Sword" 
STRINGS.RECIPE_DESC.ARCHER_CUTLASS = "A Cutlass sword" 
STRINGS.RECIPE_DESC.ARCHER_EXCALIBUR = "Used by the female knight." 
STRINGS.RECIPE_DESC.ARCHER_GALIENTSWORD = "Used by a Sadist." 
STRINGS.RECIPE_DESC.ARCHER_GKATANA = "Used by a certain someone." 
STRINGS.RECIPE_DESC.ARCHER_GSWORD = "Used by a certain someone." 
STRINGS.RECIPE_DESC.ARCHER_KANSHOU = "Used by the redman." 
STRINGS.RECIPE_DESC.ARCHER_KATANA = "A Standard Katana." 
STRINGS.RECIPE_DESC.ARCHER_KENDOSTICK = "A standard Kendostick" 
STRINGS.RECIPE_DESC.ARCHER_KNIFE = "Used by a graceful killer." 
STRINGS.RECIPE_DESC.ARCHER_LAWSWORD = "Used by a Special Surgeon." 
STRINGS.RECIPE_DESC.ARCHER_NANDAO = "A Nandao sword." 
STRINGS.RECIPE_DESC.ARCHER_NEEDLE = "Used for sewing." 
STRINGS.RECIPE_DESC.ARCHER_PEARLSPEAR = "Used by a special Gem." 
STRINGS.RECIPE_DESC.ARCHER_PEARLSWORD = "Used by a special Gem." 
STRINGS.RECIPE_DESC.ARCHER_PIANDAO = "A Piandao Sword." 
STRINGS.RECIPE_DESC.ARCHER_SANDAI = "Used by a Pirate Swordsman" 
STRINGS.RECIPE_DESC.ARCHER_SHUSUI = "Used by a Pirate Swordsman" 

-- Custom Items Swords(GLOBAL STRING NAMES)
GLOBAL.STRINGS.NAMES.ARCHER_BAKUYA = "Archer's Bakuya"
GLOBAL.STRINGS.NAMES.ARCHER_SANSPEAR = "San's Spear"
GLOBAL.STRINGS.NAMES.ARCHER_CELTIC = "A Celtic Sword"
GLOBAL.STRINGS.NAMES.ARCHER_CUTLASS = "A Cutlass Sword"
GLOBAL.STRINGS.NAMES.ARCHER_EXCALIBUR = "Saber's Sword"
GLOBAL.STRINGS.NAMES.ARCHER_GALIENTSWORD = "Iris Heart's Sword"
GLOBAL.STRINGS.NAMES.ARCHER_GKATANA = "Yoyo's Katana"
GLOBAL.STRINGS.NAMES.ARCHER_GSWORD = "Yoyo's Sword"
GLOBAL.STRINGS.NAMES.ARCHER_KANSHOU = "Archer's Kanshou"
GLOBAL.STRINGS.NAMES.ARCHER_KATANA = "A Katana"
GLOBAL.STRINGS.NAMES.ARCHER_KENDOSTICK = "A Kendostick"
GLOBAL.STRINGS.NAMES.ARCHER_KNIFE = "Shiki's Knife"
GLOBAL.STRINGS.NAMES.ARCHER_LAWSWORD = "Law's Sword"
GLOBAL.STRINGS.NAMES.ARCHER_NANDAO = "A Nandao Sword"
GLOBAL.STRINGS.NAMES.ARCHER_NEEDLE = "Eira's Neddle"
GLOBAL.STRINGS.NAMES.ARCHER_PEARLSPEAR = "Pearl's Spear"
GLOBAL.STRINGS.NAMES.ARCHER_PEARLSWORD = "Pearl's Sword"
GLOBAL.STRINGS.NAMES.ARCHER_PIANDAO = "A Piandao Sword"
GLOBAL.STRINGS.NAMES.ARCHER_SANDAI = "Zoro's Sandai"
GLOBAL.STRINGS.NAMES.ARCHER_SHUSUI = "Zoro's Shusui"

--Custom Items Swords(DESC)
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_BAKUYA = "Used by the redman." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_SAN = "Used by the Wolf Girl." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_CELTIC = "A Celtic Sword" 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_CUTLASS = "A Cutlass sword" 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_EXCALIBUR = "Used by the female knight." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_GALIENTSWORD = "Used by a Sadist." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_GKTANA = "Used by a certain someone." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_GSWORD = "Used by a certain someone." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_KANSHOU = "Used by the redman." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_KATANA = "A Standard Katana."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_KENDOSTICK = "A standard Kendostick" 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_KNIFE = "Used by a graceful killer."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_LAWSWORD = "Used by a Special Surgeon." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_NANDAO = "A Nandao sword." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_needle = "Used for sewing." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_PEARLSPEAR = "Used by a special Gem." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_PEARLSWORD = "Used by a special Gem." 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_PIANDAO = "A Piandao Sword."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_SAIDAI = "Used by a Pirate Swordsman" 
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_SHUSUI = "Used by a Pirate Swordsman" 

-- The character select screen lines
STRINGS.CHARACTER_TITLES.archer = "Wrought Iron Hero"
STRINGS.CHARACTER_NAMES.archer = "Archer"
STRINGS.CHARACTER_DESCRIPTIONS.archer = "\n*Crafting swordsman\n*No Master, Slowly withering..."
STRINGS.CHARACTER_QUOTES.archer = "\"It is useless. I am your ideal. You should realize you cannot match me.\""

-- Custom speech strings
STRINGS.CHARACTERS.ARCHER = require "speech_archer"

-- The character's name as appears in-game 
STRINGS.NAMES.ARCHER = "Esc"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER = 
{
	GENERIC = "It's Archer!",
	ATTACKER = "That Archer looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Archer, friend of ghosts.",
	GHOST = "Archer could use a heart.",
}


AddMinimapAtlas("images/map_icons/archer.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("archer", "MALE")

