-- Import the engine.
modimport("engine.lua")

-- Imports to keep the keyhandler from working while typing in chat.
Load "chatinputscreen"
Load "consolescreen"
Load "textedit"

PrefabFiles = {
	"caster", "rulebreaker", "assassinsword", "summonassassin", "casterstaff", "caster_ring_fx", "casterprojectile", "caster_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/caster.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/caster.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/caster.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/caster.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/caster_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/caster_silho.xml" ),

    Asset( "IMAGE", "bigportraits/caster.tex" ),
    Asset( "ATLAS", "bigportraits/caster.xml" ),
	
	Asset( "IMAGE", "images/map_icons/caster.tex" ),
	Asset( "ATLAS", "images/map_icons/caster.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_caster.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_caster.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_caster.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_caster.xml" ),
	
	Asset( "ATLAS", "images/hud/castertab.xml" ),
	Asset( "IMAGE", "images/hud/castertab.tex" ),
	
	Asset( "IMAGE", "bigportraits/caster_none.tex" ),
    Asset( "ATLAS", "bigportraits/caster_none.xml" ),
	
	Asset( "IMAGE", "images/names_caster.tex" ),
    Asset( "ATLAS", "images/names_caster.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local resolvefilepath = GLOBAL.resolvefilepath


local SITCOMMAND = GLOBAL.Action(4, true, true, 10,	false, false, nil)
local SITCOMMAND_CANCEL = GLOBAL.Action(4, true, true, 10, false, false, nil)

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

local TUNING = GLOBAL.TUNING

TUNING.HEALTHVALUE = GetModConfigData("healthvalue")
TUNING.SANITYVALUE = GetModConfigData("sanityvalue")

--Transformation Section
GLOBAL.TUNING.CASTER = {}
GLOBAL.TUNING.CASTER.KEY = GetModConfigData("magicalkey") or 122

local function MagicalFn(inst, data)
if inst:HasTag("playerghost") then return end
if inst.transformed then
inst.AnimState:SetBuild("caster")
	local x, y, z = inst.Transform:GetWorldPosition()
	local fx = SpawnPrefab("splash_snow_fx")
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
	fx.Transform:SetPosition(x, y, z)
	SpawnPrefab("collapse_big").Transform:SetPosition(inst:GetPosition():Get())
inst.soundsname = "wendy"

inst.AnimState:Show("HAIR_HAT")
 
else
inst.AnimState:SetBuild("casteryoung")
	local x, y, z = inst.Transform:GetWorldPosition()
	local fx = SpawnPrefab("splash_snow_fx")
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
	fx.Transform:SetPosition(x, y, z)
	SpawnPrefab("collapse_big").Transform:SetPosition(inst:GetPosition():Get())
inst.soundsname = "willow"

inst.AnimState:Show("HAIR_HAT")

end
 
inst.transformed = not inst.transformed
 
-- inst.components.health:SetCurrentHealth(1)
-- inst.components.health:DoDelta(0)
return true
 
end
 
AddModRPCHandler("caster", "MAGICAL", MagicalFn)

-- Custom Items 

GLOBAL.STRINGS.NAMES.RULEBREAKER = "Rule Breaker"
GLOBAL.STRINGS.NAMES.ASSASSINSWORD = "Assassin's Sword"
GLOBAL.STRINGS.NAMES.SUMMONASSASSIN = "Assassin"
GLOBAL.STRINGS.NAMES.CASTERSTAFF = "Caster's Staff"

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.RULEBREAKER = "Break ALL the rules!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ASSASSINSWORD = "Used by a forever perched Swordsman."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SUMMONASSASSIN = "Shouldn't you be guarding something?"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.CASTERSTAFF = "What a very pretty staff."

-- An assassinbone is given every time player is spawned/loaded. It's not saved
local function GiveAssassinbone(inst)
	local assassinbone = GLOBAL.SpawnPrefab("rulebreaker")
	if assassinbone then
		assassinbone.owner = inst
		inst.assassinbone = assassinbone
		inst.components.inventory.ignoresound = true
		inst.components.inventory:GiveItem(assassinbone)
		inst.components.inventory.ignoresound = false
		assassinbone.components.named:SetName(inst.name.."'s Rulebreaker")
	return assassinbone
	end
end
local function GetSpawnPoint(pt)
	local theta = math.random() * 2 * GLOBAL.PI
	local radius = 4
	local offset = GLOBAL.FindWalkableOffset(pt, theta, radius, 12, true)
	return offset ~= nil and (pt + offset) or nil
end
local function PersonalAssassin(inst)
	if not inst:HasTag("specialassassinowner") then
		return
	end

	local OnDespawn_prev = inst.OnDespawn
	local OnDespawn_new = function(inst)
		-- Remove assassin
		if inst.assassin then
			-- Don't allow assassin to despawn with irreplaceable items
			
			-- We need time to save before despawning.
			inst.assassin:DoTaskInTime(0.1, function(inst)
				if inst and inst:IsValid() then
					inst:Remove()
				end
			end)
			
		end
		
		if inst.assassinbone then
			-- Assassinbone drops from whatever its in
			local owner = inst.assassinbone.components.inventoryitem.owner
			if owner then
				-- Remember if assassinbone is held
				if owner == inst then
					inst.assassinbone.isheld = true
				else
					inst.assassinbone.isheld = false
				end
				if owner.components.container then
					owner.components.container:DropItem(inst.assassinbone)
				elseif owner.components.inventory then
					owner.components.inventory:DropItem(inst.assassinbone)
				end
			end
			-- Remove assassinbone
			inst.assassinbone:DoTaskInTime(0.1, function(inst)
				if inst and inst:IsValid() then
					inst:Remove()
				end
			end)
		else
			print("Error: Player has no linked assassinbone!")
		end
		if OnDespawn_prev then
			return OnDespawn_prev(inst)
		end
	end
	inst.OnDespawn = OnDespawn_new
	
	local OnSave_prev = inst.OnSave
	local OnSave_new = function(inst, data)
		local references = OnSave_prev and OnSave_prev(inst, data)
		if inst.assassin then
			-- Save assassin
			local refs = {}
			if not references then
				references = {}
			end
			data.assassin, refs = inst.assassin:GetSaveRecord()
			if refs then
				for k,v in pairs(refs) do
					table.insert(references, v)
				end 
			end				
		end
		if inst.assassinbone then
			-- Save assassinbone
			local refs = {}
			if not references then
				references = {}
			end
			data.assassinbone, refs = inst.assassinbone:GetSaveRecord()
			if refs then
				for k,v in pairs(refs) do
					table.insert(references, v)
				end 
			end
			-- Remember if was holding assassinbone
			if inst.assassinbone.isheld then
				data.holdingassassinbone = true
			else
				data.holdingassassinbone = false
			end
		end
		return references
	end
    inst.OnSave = OnSave_new
	
	local OnLoad_prev = inst.OnLoad
	local OnLoad_new = function(inst, data, newents)
		if data.assassin ~= nil then
			-- Load assassin
			inst.assassin = GLOBAL.SpawnSaveRecord(data.assassin, newents)
		else
			--print("Warning: No assassin was loaded from save file!")
		end
		
		if data.assassinbone ~= nil then
			-- Load assassin
			inst.assassinbone = GLOBAL.SpawnSaveRecord(data.assassinbone, newents)
			
			-- Look for assassinbone at spawn point and re-equip
			inst:DoTaskInTime(0, function(inst)
				if data.holdingassassinbone or (inst.assassinbone and inst:IsNear(inst.assassinbone,4)) then
					--inst.components.inventory:GiveItem(inst.assassinbone)
					inst:ReturnAssassinbone()
				end
			end)
		else
			print("Warning: No assassinbone was loaded from save file!")
		end
		
		-- Create new assassinbone if none loaded
		if not inst.assassinbone then
			GiveAssassinbone(inst)
		end
		
		inst.assassinbone.owner = inst
		
		
		if OnLoad_prev then
			return OnLoad_prev(inst, data, newents)
		end
	end
    inst.OnLoad = OnLoad_new
	
	local OnNewSpawn_prev = inst.OnNewSpawn
	local OnNewSpawn_new = function(inst)
		-- Give new assassinbone. Let assassin spawn naturally.
		GiveAssassinbone(inst)
		if OnNewSpawn_prev then
			return OnNewSpawn_prev(inst)
		end
	end
    inst.OnNewSpawn = OnNewSpawn_new
	
	if GLOBAL.TheNet:GetServerGameMode() == "wilderness" then
		local function ondeath(inst, data)
			-- Kill player's assassin in wilderness mode :(
			if inst.assassin then
				inst.assassin.components.health:Kill()
			end
			if inst.assassinbone then
				inst.assassinbone:Remove()
			end
		end
		inst:ListenForEvent("death", ondeath)
	end
	
	-- Debug function to return assassinbone
	inst.ReturnAssassinbone = function()
		if inst.assassinbone and inst.assassinbone:IsValid() then
			if inst.assassinbone.components.inventoryitem.owner ~= inst then
				inst.components.inventory:GiveItem(inst.assassinbone)
			end
		else
			GiveAssassinbone(inst)
		end
		if inst.assassin and not inst:IsNear(inst.assassin, 20) then
			local pt = inst:GetPosition()
			local spawn_pt = GetSpawnPoint(pt)
			if spawn_pt ~= nil then
				inst.assassin.Physics:Teleport(spawn_pt:Get())
				inst.assassin:FacePoint(pt:Get())
			end
		end
	end
end

GLOBAL.c_returnassassinbone = function(inst)
	if not inst then
		inst = GLOBAL.ThePlayer or GLOBAL.AllPlayers[1]
	end
	if not inst or not inst.ReturnAssassinbone then 
		print("Error: Cannot return assassinbone")
		return 
	end
	inst:ReturnAssassinbone()
end

AddPlayerPostInit(PersonalAssassin)

AddMinimapAtlas("images/inventoryimages/summonassassin.xml")
AddMinimapAtlas("images/inventoryimages/assassinsword.xml")
AddMinimapAtlas("images/inventoryimages/rulebreaker.xml")

--Follower Commands

AddReplicableComponent("followersitcommand")

SITCOMMAND.id = "SITCOMMAND"
SITCOMMAND.str = "Order to Stay"
SITCOMMAND.fn = function(act)
	local targ = act.target
	if targ and targ.components.followersitcommand then
		act.doer.components.locomotor:Stop()
		act.doer.components.talker:Say("Assassin stay on lookout.")
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
		act.doer.components.talker:Say("Assassin defend me. Now.")
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

AddPrefabPostInit("assassinsword", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("armor_sanity", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("umbrella", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("grass_umbrella", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("torch", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("lantern", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("minerhat", HF_addtradablecomponenttoprefab)
AddPrefabPostInit("nightstick", HF_addtradablecomponenttoprefab)
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
STRINGS.CHARACTER_TITLES.caster = "Magus, Age of the Gods"
STRINGS.CHARACTER_NAMES.caster = "Caster"
STRINGS.CHARACTER_DESCRIPTIONS.caster = "*Unparalleled Magic\n*Assassin Assistance\n*Magical"
STRINGS.CHARACTER_QUOTES.caster = "\"But this is cruel. I finally found a wish...\""

-- Custom speech strings
STRINGS.CHARACTERS.CASTER = require "speech_caster"

-- The character's name as appears in-game 
STRINGS.NAMES.CASTER = "Caster"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CASTER = 
{
	GENERIC = "It's Caster!",
	ATTACKER = "That Caster looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Caster, friend of ghosts.",
	GHOST = "Caster could use a heart.",
}


AddMinimapAtlas("images/map_icons/caster.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("caster", "FEMALE")

