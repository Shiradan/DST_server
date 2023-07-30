PrefabFiles = {
	"rin", "formredgem", "formbluegem", "formorangegem", "formyellowgem", "formgreengem", "formpurplegem", "formthulecite", "gandr", "rinprojectile", "rin_none", 
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/rin.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/rin.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/rin.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/rin.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/rin_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/rin_silho.xml" ),

    Asset( "IMAGE", "bigportraits/rin.tex" ),
    Asset( "ATLAS", "bigportraits/rin.xml" ),
	
	Asset( "IMAGE", "images/map_icons/rin.tex" ),
	Asset( "ATLAS", "images/map_icons/rin.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_rin.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_rin.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_rin.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_rin.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/formredgem.tex" ),
	Asset( "ATLAS", "images/inventoryimages/formredgem.xml" ),
	Asset( "IMAGE", "images/inventoryimages/formbluegem.tex" ),
	Asset( "ATLAS", "images/inventoryimages/formbluegem.xml" ),
	Asset( "IMAGE", "images/inventoryimages/formyellowgem.tex" ),
	Asset( "ATLAS", "images/inventoryimages/formyellowgem.xml" ),
	Asset( "IMAGE", "images/inventoryimages/formpurplegem.tex" ),
	Asset( "ATLAS", "images/inventoryimages/formpurplegem.xml" ),
	Asset( "IMAGE", "images/inventoryimages/formorangegem.tex" ),
	Asset( "ATLAS", "images/inventoryimages/formorangegem.xml" ),
	Asset( "IMAGE", "images/inventoryimages/formthulecite.tex" ),
	Asset( "ATLAS", "images/inventoryimages/formthulecite.xml" ),
	Asset( "IMAGE", "images/inventoryimages/formgreengem.tex" ),
	Asset( "ATLAS", "images/inventoryimages/formgreengem.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/craftgears.tex" ),
	Asset( "ATLAS", "images/inventoryimages/craftgears.xml" ),
	
	Asset( "IMAGE", "bigportraits/rin_none.tex" ),
    Asset( "ATLAS", "bigportraits/rin_none.xml" ),
	
	Asset( "IMAGE", "images/names_rin.tex" ),
    Asset( "ATLAS", "images/names_rin.xml" ),
	
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local resolvefilepath = GLOBAL.resolvefilepath

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

STRINGS.RECIPE_DESC.FORMREDGEM = "Oh so pretty! Firey too!" 
STRINGS.RECIPE_DESC.FORMBLUEGEM = "Oh so lovely! icey too!"
STRINGS.RECIPE_DESC.FORMPURPLEGEM = "How dark and mysterious. Captivating though..." 
STRINGS.RECIPE_DESC.FORMYELLOWGEM = "Sooo Shiny! Blinded by beauty!"
STRINGS.RECIPE_DESC.FORMORANGEGEM = "What a nice relaxing color...ah bliss" 
STRINGS.RECIPE_DESC.FORMGREENGEM = "I wonder if I can plant it?"
STRINGS.RECIPE_DESC.FORMTHULECITE = "Create ancient architecture!" 

STRINGS.RECIPE_DESC.GEARS = "Legit!" 

GLOBAL.STRINGS.NAMES.FORMREDGEM = "Crystallizing Redgem"
GLOBAL.STRINGS.NAMES.FORMBLUEGEM = "Crystallizing Bluegem"
GLOBAL.STRINGS.NAMES.FORMPURPLEGEM = "Crystallizing Purplegem"
GLOBAL.STRINGS.NAMES.FORMYELLOWGEM = "Crystallizing Yellowgem"
GLOBAL.STRINGS.NAMES.FORMORANGEGEM = "Crystallizing Orangegem"
GLOBAL.STRINGS.NAMES.FORMGREENGEM = "Crystallizing Greengem"
GLOBAL.STRINGS.NAMES.FORMTHULECITE = "Transforming Thulecite"

GLOBAL.STRINGS.NAMES.GANDR = "GANDR SHOT"

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORMREDGEM = "Oh so pretty! Firey too!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORMBLUEGEM = "Oh so lovely! icey too!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORMPURPLEGEM = "How dark and mysterious. Captivating though..."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORMYELLOWGEM = "Sooo Shiny! Blinded by beauty!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORMORANGEGEM = "What a nice relaxing color...ah bliss."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORMGREENGEM = "I wonder if I can plant it?"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORMTHULECITE = "Thulecite on the go!."

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GANDR = "A magic black bulbous sphere."


local formredgem_recipe = AddRecipe("formredgem", {GLOBAL.Ingredient("flint", 2), GLOBAL.Ingredient("charcoal", 2), GLOBAL.Ingredient("goldnugget", 1)}, GLOBAL.RECIPETABS.ANCIENT, GLOBAL.TECH.ANCIENT_TWO, nil, nil, nil, 3, nil, "images/inventoryimages/formredgem.xml", "formredgem.tex" )
	formredgem_recipe.tagneeded = false
	formredgem_recipe.builder_tag ="ancient_builder"

local formbluegem_recipe = AddRecipe("formbluegem", {GLOBAL.Ingredient("flint", 2), GLOBAL.Ingredient("ice", 3), GLOBAL.Ingredient("goldnugget", 1)}, GLOBAL.RECIPETABS.ANCIENT, GLOBAL.TECH.ANCIENT_TWO, nil, nil, nil, 3, nil, "images/inventoryimages/formbluegem.xml", "formbluegem.tex" )
	formbluegem_recipe.tagneeded = false
	formbluegem_recipe.builder_tag ="ancient_builder"

local formpurplegem_recipe = AddRecipe("formpurplegem", {GLOBAL.Ingredient("flint", 2), GLOBAL.Ingredient("nightmarefuel", 1), GLOBAL.Ingredient("goldnugget", 1)}, GLOBAL.RECIPETABS.ANCIENT, GLOBAL.TECH.ANCIENT_TWO, nil, nil, nil, 3, nil, "images/inventoryimages/formpurplegem.xml", "formpurplegem.tex" )
	formpurplegem_recipe.tagneeded = false
	formpurplegem_recipe.builder_tag ="ancient_builder"

local formyellowgem_recipe = AddRecipe("formyellowgem", {GLOBAL.Ingredient("flint", 2), GLOBAL.Ingredient("fireflies", 1), GLOBAL.Ingredient("goldnugget", 1)}, GLOBAL.RECIPETABS.ANCIENT, GLOBAL.TECH.ANCIENT_TWO, nil, nil, nil, 3, nil, "images/inventoryimages/formyellowgem.xml", "formyellowgem.tex" )		
	formyellowgem_recipe.tagneeded = false
	formyellowgem_recipe.builder_tag ="ancient_builder"
	
local formorangegem_recipe = AddRecipe("formorangegem", {GLOBAL.Ingredient("flint", 2), GLOBAL.Ingredient("houndstooth", 2), GLOBAL.Ingredient("goldnugget", 1)}, GLOBAL.RECIPETABS.ANCIENT, GLOBAL.TECH.ANCIENT_TWO, nil, nil, nil, 3, nil, "images/inventoryimages/formorangegem.xml", "formorangegem.tex" )		
	formorangegem_recipe.tagneeded = false	
	formorangegem_recipe.builder_tag ="ancient_builder"
	
local formgreengem_recipe = AddRecipe("formgreengem", {GLOBAL.Ingredient("flint", 2), GLOBAL.Ingredient("livinglog", 1), GLOBAL.Ingredient("goldnugget", 1)}, GLOBAL.RECIPETABS.ANCIENT, GLOBAL.TECH.ANCIENT_TWO, nil, nil, nil, 3, nil, "images/inventoryimages/formgreengem.xml", "formgreengem.tex" )		
	formgreengem_recipe.tagneeded = false	
	formgreengem_recipe.builder_tag ="ancient_builder"
	
local formthulecite_recipe = AddRecipe("formthulecite", {GLOBAL.Ingredient("cutstone", 1), GLOBAL.Ingredient("nightmarefuel", 1), GLOBAL.Ingredient("goldnugget", 1)}, GLOBAL.RECIPETABS.ANCIENT, GLOBAL.TECH.ANCIENT_TWO, nil, nil, nil, 4, nil, "images/inventoryimages/formthulecite.xml", "formthulecite.tex" )		
	formthulecite_recipe.tagneeded = false	
	formthulecite_recipe.builder_tag ="ancient_builder"
	
local gears_recipe = AddRecipe ("gears", {GLOBAL.Ingredient("flint", 10), GLOBAL.Ingredient("cutstone", 3), GLOBAL.Ingredient("transistor", 2)}, GLOBAL.RECIPETABS.ANCIENT, GLOBAL.TECH.ANCIENT_TWO, nil, nil, nil, 1, nil, "images/inventoryimages/craftgears.xml", "craftgears.tex" )		
	formgreengem_recipe.tagneeded = false	
	formgreengem_recipe.builder_tag ="ancient_builder"
	
-- The character select screen lines
STRINGS.CHARACTER_TITLES.rin = "The Elegant Noble Magus"
STRINGS.CHARACTER_NAMES.rin = "rin"
STRINGS.CHARACTER_DESCRIPTIONS.rin = "*Tohsaka Family\n*Expert in Jewel magic\n*Makes good chinese food"
STRINGS.CHARACTER_QUOTES.rin = "\"Look, Emiya-kun. People normally die when they are killed.\""

-- Custom speech strings
STRINGS.CHARACTERS.RIN = require "speech_rin"

-- The character's name as appears in-game 
STRINGS.NAMES.RIN = "rin"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.RIN = 
{
	GENERIC = "It's rin!",
	ATTACKER = "That rin looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "rin, friend of ghosts.",
	GHOST = "rin could use a heart.",
}

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "rin")


AddMinimapAtlas("images/map_icons/rin.xml")
AddModCharacter("rin")