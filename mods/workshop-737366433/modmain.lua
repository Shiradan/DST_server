--[[TUNING]]
	TUNING.ARMOR_HARDNESS = 900--1000
	TUNING.ARMOR_ABSORPTION = 0.7--0.8

	TUNING.HELMET_HARDNESS = 450--500
	TUNING.HELMET_ABSORPTION = 0.4--0.5

	TUNING.TOOL_ATTACK_PENALTY = 1.5

	TUNING.TOOL_USES = 100

	TUNING.TOOL_DAMAGE = 17.5--20
	TUNING.WEAPON_DAMAGE = 35

	--TUNING.SWORD_BONUS = 1.1
	TUNING.IRON_BONUS = 1.2
	TUNING.COBALT_BONUS = 1.3--1.5

	TUNING.COBALT_COOLER = -10

PrefabFiles = 
{
	"ores",			
	"boulders",		
	"axes",			
	"chestplates",	
	"pickaxes",		
	"helmets",			
--[["amulets",
	"backpacks",]]
	"spears",
	"hammers",	
--[["swords",
	"traps", 
	"mwalls", ]] --It can be added at next updates
	"shovels",
	"plates",
}

Assets = 
{
	Asset("ATLAS", "inventoryimages/ore_iron.xml"),
	Asset("ATLAS", "inventoryimages/axe_iron.xml"),
	Asset("ATLAS", "inventoryimages/armor_iron.xml"),
	Asset("ATLAS", "inventoryimages/pickaxe_iron.xml"),
	Asset("ATLAS", "inventoryimages/helmet_iron.xml"),
	Asset("ATLAS", "inventoryimages/shovel_iron.xml"),
	Asset("ATLAS", "inventoryimages/hammer_iron.xml"),
	Asset("ATLAS", "inventoryimages/spear_iron.xml"),
	Asset("ATLAS", "inventoryimages/plate_iron.xml"),

	Asset("ATLAS", "inventoryimages/ore_cobalt.xml"),
	Asset("ATLAS", "inventoryimages/axe_cobalt.xml"),
	Asset("ATLAS", "inventoryimages/armor_cobalt.xml"),
	Asset("ATLAS", "inventoryimages/pickaxe_cobalt.xml"),
	Asset("ATLAS", "inventoryimages/helmet_cobalt.xml"),
	Asset("ATLAS", "inventoryimages/shovel_cobalt.xml"),
	Asset("ATLAS", "inventoryimages/hammer_cobalt.xml"),
	Asset("ATLAS", "inventoryimages/spear_cobalt.xml"),
	Asset("ATLAS", "inventoryimages/plate_cobalt.xml"),
}

--[[DESCRIPTION OF ITEMS]]
local _G = GLOBAL
local string = _G.STRINGS
local name = string.NAMES
local charDesc = string.CHARACTERS
local recipeDesc = string.CHARACTERS
local lang = (GetModConfigData("lang"))


--[[NAMES]]
if lang == 0 then
	name.ORE_IRON = "Iron Ore"
	name.ROCK_IRON = "Rusty Boulder"
	name.AXE_IRON = "Iron Axe"
	name.ARMOR_IRON = "Iron Chestplate"
	name.PICKAXE_IRON = "Iron Pickaxe"
	name.HELMET_IRON = "Iron Helmet"
	name.SHOVEL_IRON = "Iron Shovel"
	name.HAMMER_IRON = "Iron Hammer"
	name.SPEAR_IRON = "Iron Spear"
	name.PLATE_IRON = "Iron Plate"
--											
	name.ORE_COBALT = "Cobalt Ore"			
	name.ROCK_COBALT = "Blue Boulder"		
	name.AXE_COBALT = "Cobalt Axe"			
	name.ARMOR_COBALT = "Cobalt Chestplate"	
	name.PICKAXE_COBALT = "Cobalt Pickaxe"	
	name.HELMET_COBALT = "Cobalt Helmet"	
	name.SHOVEL_COBALT = "Cobalt Shovel"	
	name.HAMMER_COBALT = "Cobalt Hammer"	
	name.SPEAR_COBALT = "Cobalt Spear"		
	name.PLATE_COBALT = "Cobalt Plate"		
end			

if lang == 1 then
	name.ORE_IRON = "Железная руда"
	name.ROCK_IRON = "Камень с ржавчиной"
	name.AXE_IRON = "Железный топор"
	name.ARMOR_IRON = "Железный нагрудник"
	name.PICKAXE_IRON = "Железная кирка"
	name.HELMET_IRON = "Железный шлем"
	name.SHOVEL_IRON = "Железная лопата"
	name.HAMMER_IRON = "Железный молот"
	name.SPEAR_IRON = "Железное копьё"
	name.PLATE_IRON = "Железная пластина"

	name.ORE_COBALT = "Кобальтовая руда"
	name.ROCK_COBALT = "Синеватый камень"
	name.AXE_COBALT = "Кобальтовый топор"
	name.ARMOR_COBALT = "Кобальтовый нагрудник"
	name.PICKAXE_COBALT = "Кобальтовая кирка"
	name.HELMET_COBALT = "Кобальтовый шлем"
	name.SHOVEL_COBALT = "Кобальтовая лопата"
	name.HAMMER_COBALT = "Кобальтовый молот"
	name.SPEAR_COBALT = "Кобальтовое копьё"
	name.PLATE_COBALT = "Кобальтовая пластина"
end

--[[RECIPE DESCRIPTIONS]]

recipeDesc.AXE_IRON = "With this axe any tree can be chopped down!"
recipeDesc.ARMOR_IRON = "Cold and strong!"
recipeDesc.PICKAXE_IRON = "It can destruct any boulder on your way!"
recipeDesc.HELMET_IRON = "Harder than your head. Don't try to check it, ok?"
recipeDesc.SHOVEL_IRON = "It's an iron shovel."
recipeDesc.HAMMER_IRON = "Now you can crush and smash everything(not)!"
recipeDesc.SPEAR_IRON = "Don't touch the spearhead! It's very sharp."
recipeDesc.PLATE_IRON = "Flatter than Earth."

--[[CHARACTER DESCRIPTIONS]]

--{{ORES}}
charDesc.GENERIC.DESCRIBE.ORE_IRON = "That's not a gold..."
charDesc.WX78.DESCRIBE.ORE_IRON="I made from that?"
charDesc.WICKERBOTTOM.DESCRIBE.ORE_IRON = "That's stronger than gold, but cheaper..."
charDesc.WENDY.DESCRIBE.ORE_IRON = "It's harder than all the other rocks!"
charDesc.WOLFGANG.DESCRIBE.ORE_IRON = "Hard materials for a hard mans!"
charDesc.WILLOW.DESCRIBE.ORE_IRON = "Time to create something dangerous with it"

charDesc.GENERIC.DESCRIBE.ORE_COBALT = "It's so c-c-cold-d..."

--{{BOULDERS}}
charDesc.GENERIC.DESCRIBE.ROCK_IRON = "Is it better than gold?"
charDesc.WX78.DESCRIBE.ROCK_IRON="HARD ROCK CONTAINS METAL...IRON"
charDesc.WICKERBOTTOM.DESCRIBE.ROCK_IRON = "Where have I seen this kind of boulders before..?"
charDesc.WENDY.DESCRIBE.ROCK_IRON = "Let's smash it into pieces!"
charDesc.WOLFGANG.DESCRIBE.ROCK_IRON = "I stronger, than it!"
charDesc.WILLOW.DESCRIBE.ROCK_IRON = "These look kind of funny"

charDesc.GENERIC.DESCRIBE.ROCK_COBALT = "This boulder are colder, than other."

--{{AXES}}
charDesc.GENERIC.DESCRIBE.AXE_IRON ="Woodie would have liked it" 
charDesc.WX78.DESCRIBE.AXE_IRON="Initializing FORESTCUTTER.BAT..."
charDesc.WICKERBOTTOM.DESCRIBE.AXE_IRON = "Not Environmentally Friendly"
charDesc.WENDY.DESCRIBE.AXE_IRON = "Everything dies eventually. Even Trees."
charDesc.WOLFGANG.DESCRIBE.AXE_IRON = "Wood is WEAK, I am MIGHTY!"
charDesc.WILLOW.DESCRIBE.AXE_IRON = "Where do Trees go when they die? ON THE FIRE!"
charDesc.WOODIE.DESCRIBE.AXE_IRON = "Pfff... I have Lucy! She are the best!"

--{{ARMORS}}
charDesc.GENERIC.DESCRIBE.ARMOR_IRON ="Wow, that's so tough!"
charDesc.WX78.DESCRIBE.ARMOR_IRON="I made from iron and not needing this!"
charDesc.WICKERBOTTOM.DESCRIBE.ARMOR_IRON = "A hard chestplate in medieval style."
charDesc.WENDY.DESCRIBE.ARMOR_IRON = "Cold deep inside, like Abigail."
charDesc.WOLFGANG.DESCRIBE.ARMOR_IRON = "Stay Safe, Stay Cool, Stay MIGHTY!"
charDesc.WILLOW.DESCRIBE.ARMOR_IRON = "Safe AND Cold, That's no fun!"

charDesc.GENERIC.DESCRIBE.ARMOR_COBALT = "Please, give me something warm."

--{{PICKAXES}}
charDesc.GENERIC.DESCRIBE.PICKAXE_IRON ="I WILL DESTRUCT ANY STONES ON MY WAY!!!"

charDesc.GENERIC.DESCRIBE.PICKAXE_COBALT = "Pickaxe."
--{{HELMETS}}
charDesc.GENERIC.DESCRIBE.HELMET_IRON ="Good hat"

charDesc.GENERIC.DESCRIBE.HELMET_COBALT ="Very cold hat"
--{{SHOVELS}}
charDesc.GENERIC.DESCRIBE.SHOVEL_IRON = "Iron shovel. It's all."

charDesc.GENERIC.DESCRIBE.SHOVEL_COBALT = "Shovel"
--{{SPEARS}}
charDesc.GENERIC.DESCRIBE.SPEAR_IRON = "So sharp!"

charDesc.GENERIC.DESCRIBE.SPEAR_COBALT = "Spear"
--{{PLATES}}
charDesc.GENERIC.DESCRIBE.PLATE_IRON = "Flat as autor's jokes."

charDesc.GENERIC.DESCRIBE.PLATE_COBALT = "Flat and cold."

--[[RECIPES]] 

local ingredient = GLOBAL.Ingredient
local recipetab = GLOBAL.RECIPETABS
local tech = GLOBAL.TECH
local recipe = GLOBAL.Recipe

--[[IRON]] 

AddRecipe("axe_iron",{
		ingredient("twigs", 3),
		ingredient("ore_iron", 4,"inventoryimages/ore_iron.xml")
		},recipetab.TOOLS, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/axe_iron.xml", "axe_iron.tex")

AddRecipe("pickaxe_iron",{
		ingredient("twigs", 3),
		ingredient("ore_iron", 4,"inventoryimages/ore_iron.xml")
		},recipetab.TOOLS, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/pickaxe_iron.xml", "pickaxe_iron.tex")

AddRecipe("shovel_iron",{
		ingredient("twigs", 3),
		ingredient("plate_iron", 1,"inventoryimages/plate_iron.xml")
		},recipetab.TOOLS, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/shovel_iron.xml", "shovel_iron.tex")

AddRecipe("hammer_iron",{
		ingredient("twigs", 3),
		ingredient("ore_iron", 4,"inventoryimages/ore_iron.xml")
		},recipetab.TOOLS, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/hammer_iron.xml", "hammer_iron.tex")

AddRecipe("armor_iron",{
		ingredient("plate_iron", 5,"inventoryimages/plate_iron.xml")
		},recipetab.WAR, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/armor_iron.xml", "armor_iron.tex")

AddRecipe("helmet_iron",{
		ingredient("plate_iron", 3,"inventoryimages/plate_iron.xml")
		},recipetab.WAR, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/helmet_iron.xml", "helmet_iron.tex")

AddRecipe("spear_iron",{
		ingredient("ore_iron", 2,"inventoryimages/ore_iron.xml"),
		ingredient("twigs", 3)
		},recipetab.WAR, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/spear_iron.xml", "spear_iron.tex")

AddRecipe("plate_iron",{
		ingredient("ore_iron", 3, "inventoryimages/ore_iron.xml"),
		},recipetab.REFINE, tech.SCIENCE_ONE, nil, nil, nil, nil ,nil, "inventoryimages/plate_iron.xml", "plate_iron.tex")

AddRecipe("gears",{
		ingredient("ore_iron", 4, "inventoryimages/ore_iron.xml"),
		},recipetab.REFINE, tech.SCIENCE_TWO, nil, nil, nil, nil ,nil)

--[[COBALT]]

AddRecipe("axe_cobalt",{
		ingredient("twigs", 3),
		ingredient("ore_cobalt", 4,"inventoryimages/ore_cobalt.xml")
		},recipetab.TOOLS, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/axe_cobalt.xml", "axe_cobalt.tex")

AddRecipe("pickaxe_cobalt",{
		ingredient("twigs", 3),
		ingredient("ore_cobalt", 4,"inventoryimages/ore_cobalt.xml")
		},recipetab.TOOLS, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/pickaxe_cobalt.xml", "pickaxe_cobalt.tex")

AddRecipe("shovel_cobalt",{
		ingredient("twigs", 3),
		ingredient("plate_cobalt", 1,"inventoryimages/plate_cobalt.xml")
		},recipetab.TOOLS, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/shovel_cobalt.xml", "shovel_cobalt.tex")

AddRecipe("hammer_cobalt",{
		ingredient("twigs", 3),
		ingredient("ore_cobalt", 4,"inventoryimages/ore_cobalt.xml")
		},recipetab.TOOLS, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/hammer_cobalt.xml", "hammer_cobalt.tex")

AddRecipe("armor_cobalt",{
		ingredient("plate_cobalt", 2, "inventoryimages/plate_cobalt.xml"),
		ingredient("bluegem", 1),
		ingredient("armor_iron", 1, "inventoryimages/armor_iron.xml")
		},recipetab.WAR, tech.MAGIC_TWO, nil, nil, nil, nil, nil, "inventoryimages/armor_cobalt.xml", "armor_cobalt.tex")

AddRecipe("helmet_cobalt",{
		ingredient("plate_cobalt", 1,"inventoryimages/plate_cobalt.xml"),
		ingredient("helmet_iron", 1, "inventoryimages/helmet_iron.xml"),
		ingredient("bluegem", 1)
		},recipetab.WAR, tech.MAGIC_TWO, nil, nil, nil, nil, nil, "inventoryimages/helmet_cobalt.xml", "helmet_cobalt.tex")

AddRecipe("spear_cobalt",{
		ingredient("ore_cobalt", 2,"inventoryimages/ore_cobalt.xml"),
		ingredient("twigs", 3)
		},recipetab.WAR, tech.SCIENCE_TWO, nil, nil, nil, nil, nil, "inventoryimages/spear_cobalt.xml", "spear_cobalt.tex")

AddRecipe("plate_cobalt",{
		ingredient("ore_cobalt", 3, "inventoryimages/ore_cobalt.xml"),
		},recipetab.REFINE, tech.SCIENCE_ONE, nil, nil, nil, nil ,nil, "inventoryimages/plate_cobalt.xml", "plate_cobalt.tex")

--[[TITAN]]

--[[TUNGSTEN]]
