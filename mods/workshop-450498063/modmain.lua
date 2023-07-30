PrefabFiles = {
	"illya", "summonbeserker", "illyahat", "beserkersword", "illyabird", "grail", "illya_projectile", "illya_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/illya.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/illya.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/illya.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/illya.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/illya_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/illya_silho.xml" ),

    Asset( "IMAGE", "bigportraits/illya.tex" ),
    Asset( "ATLAS", "bigportraits/illya.xml" ),
	
	Asset( "IMAGE", "images/map_icons/illya.tex" ),
	Asset( "ATLAS", "images/map_icons/illya.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_illya.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_illya.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_illya.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_illya.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/grail.tex" ),
	Asset( "ATLAS", "images/inventoryimages/grail.xml" ),
	
	Asset( "IMAGE", "bigportraits/illya_none.tex" ),
    Asset( "ATLAS", "bigportraits/illya_none.xml" ),
	
	Asset( "IMAGE", "images/names_illya.tex" ),
    Asset( "ATLAS", "images/names_illya.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local SITCOMMAND = GLOBAL.Action(4, true, true, 10,	false, false, nil)
local SITCOMMAND_CANCEL = GLOBAL.Action(4, true, true, 10, false, false, nil)

local resolvefilepath = GLOBAL.resolvefilepath
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

local summonbeserker_recipe = AddRecipe("summonbeserker",
{GLOBAL.Ingredient("grail", 1, "images/inventoryimages/grail.xml")},
RECIPETABS.WAR, TECH.NONE,
nil, nil, nil, nil, nil,
"images/inventoryimages/summonbeserker.xml", "summonbeserker.tex")
summonbeserker_recipe.tagneeded = false
summonbeserker_recipe.builder_tag ="illya_builder"
summonbeserker_recipe.atlas = resolvefilepath("images/inventoryimages/summonbeserker.xml")

GLOBAL.STRINGS.NAMES.SUMMONBESERKER = "Berserker"
GLOBAL.STRINGS.RECIPE_DESC.SUMMONBESERKER = "Summon a hero."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SUMMONBESERKER = {"Berserker"}
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SUMMONBESERKER.GENERIC = "What a rather scary human."

GLOBAL.STRINGS.NAMES.ILLYABIRD = "Zelle"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYABIRD = "A helpful familiar."

GLOBAL.STRINGS.NAMES.GRAIL = "Holy Grail"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GRAIL = "It grants wishes!"

GLOBAL.STRINGS.NAMES.BESERKERSWORD = "Berserker's Stone Sword/Axe"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.BESERKERSWORD = "What a MASSIVE weapon!"

GLOBAL.STRINGS.NAMES.ILLYAHAT = "Illya's Winter hat"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYAHAT = "Nice and snug!"

AddMinimapAtlas("images/inventoryimages/summonbeserker.xml")
AddMinimapAtlas("images/inventoryimages/grail.xml")

AddReplicableComponent("followersitcommand")

SITCOMMAND.id = "SITCOMMAND"
SITCOMMAND.str = "Order to Stay"
SITCOMMAND.fn = function(act)
	local targ = act.target
	if targ and targ.components.followersitcommand then
		act.doer.components.locomotor:Stop()
		act.doer.components.talker:Say("Stay Berserker!!")
		targ.components.followersitcommand:SetStaying(true)
		targ.components.followersitcommand:RememberSitPos("currentstaylocation", GLOBAL.Point(targ.Transform:GetWorldPosition())) 
		return true
	end
end
AddAction(SITCOMMAND)

SITCOMMAND_CANCEL.id = "SITCOMMAND_CANCEL"
SITCOMMAND_CANCEL.str = "Order to Follow"
SITCOMMAND_CANCEL.fn = function(act)
	local targ = act.target
	if targ and targ.components.followersitcommand then
		act.doer.components.locomotor:Stop()
		act.doer.components.talker:Say("Berserker come!")
		targ.components.followersitcommand:SetStaying(false)
		return true
	end
end
AddAction(SITCOMMAND_CANCEL)

AddComponentAction("SCENE", "followersitcommand", function(inst, doer, actions, rightclick)
	if rightclick and inst.replica.followersitcommand then
		if not inst.replica.followersitcommand:IsCurrentlyStaying() then
			table.insert(actions, GLOBAL.ACTIONS.SITCOMMAND)
		else
			table.insert(actions, GLOBAL.ACTIONS.SITCOMMAND_CANCEL)
		end
	end
end)

-- add tradable component to various gear
function HF_addtradablecomponenttoprefab(inst)
	if not inst.components.tradable then
		inst:AddComponent("tradable")
	end
end

AddPrefabPostInit("beserkersword", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("armor_sanity", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("umbrella", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("grass_umbrella", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("torch", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("armorwood", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("armormarble", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("armorgrass", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("armorruins", HF_addtradablecomponenttoprefab)
-- DLC
AddPrefabPostInit("armordragonfly", HF_addtradablecomponenttoprefab)

AddComponentPostInit("moisture", function(self)
	local old = self.GetMoistureRate
	self.GetMoistureRate = function(self)
		local oldvalue = old(self)
		local x, y, z = self.inst.Transform:GetWorldPosition()
		local ents = GLOBAL.TheSim:FindEntities(x, y, z, 4, {'sheltercarrier'})
		for k, v in pairs(ents) do 
			if v.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and 
			v.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).prefab == "umbrella" then
				return 0
			end
			if v.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and 
			v.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).prefab == "grass_umbrella" then
				return oldvalue * 0.5
			end
		end
		return oldvalue
	end
end)

-- The character select screen lines
STRINGS.CHARACTER_TITLES.illya = "Illya Von Einzbern"
STRINGS.CHARACTER_NAMES.illya = "Illya"
STRINGS.CHARACTER_DESCRIPTIONS.illya = "*Frail\n*High Sanity\n*A special giant"
STRINGS.CHARACTER_QUOTES.illya = "\"BAHSAHKAH\""

-- Custom speech strings
STRINGS.CHARACTERS.ILLYA = require "speech_illya"
GLOBAL.STRINGS.CHARACTERS.ILLYA.DESCRIBE.SUMMONBESERKER = "BAHSAHKAH!"

-- The character's name as appears in-game 
STRINGS.NAMES.ILLYA = "Illya"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYA = 
{
	GENERIC = "It's Illya!",
	ATTACKER = "That Illya looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Illya, friend of ghosts.",
	GHOST = "Illya could use a..oh. Awkwaaaaard.",
}


AddMinimapAtlas("images/map_icons/illya.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("illya", "FEMALE")

