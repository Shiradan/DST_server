
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset( "ANIM", "anim/lancerpower.zip"),
}
local prefabs = {
	"gaebolg",
}

-- Custom starting items
local start_inv = {
	"gaebolg",
}

--Demon Test start
local function applyForm(inst)
	if inst.form == "demonic" then
	
		inst.AnimState:SetMultColour(186/255,0/255,0/255,1)				  
	  	inst.components.combat.damagemultiplier = 1.25
		inst.components.health.absorb = 0.80
		inst.components.locomotor:SetExternalSpeedMultiplier(inst, "lancer_speed_mod", 0.80)
		inst:AddTag("noheal")
						
	end

	if inst.form == "normal" then
		
		inst.AnimState:SetMultColour(255/255,255/255,255/255,1)				
		inst.components.combat.damagemultiplier = 1
		inst.components.health.absorb = 0.25
		inst.components.locomotor:SetExternalSpeedMultiplier(inst, "lancer_speed_mod", 1)
		inst:RemoveTag("noheal")
				
	end	
end

local function becomenormal(inst, silent)

	if inst.form == "normal" then
		return
	end
	
	inst.components.talker:Say("Feelin' better than ever.", 2.5,true) 
	
	if inst.demontask then
		inst.demontask:Cancel()
		inst.demontask = nil
	end
	
	inst.form = "normal"
	inst.AnimState:SetBuild("lancer")
		
end

local function becomedemonic(inst, silent)

	if inst.form == "demonic" then
		return
	end
	
	inst.sg:PushEvent("powerup")	
	inst.components.talker:Say("I wouldn't be a hero if I instantly died from a wound like this.", 2.5,true) 
	
	local x, y, z = inst.Transform:GetWorldPosition()
	local fx = SpawnPrefab("lavaarena_portal_player_fx")
	fx.Transform:SetPosition(x, y, z)
	SpawnPrefab("wathgrithr_spirit").Transform:SetPosition(inst:GetPosition():Get())
	
		inst.demontask = inst:DoPeriodicTask (0.003, function()
		if inst.components.health then
			inst.components.health:DoDelta(-0.0375 * 0.2, true, "Curse")
		end
	end)
	
	inst.form = "demonic"
	inst.AnimState:SetBuild("lancerpower")
	
end

local function onhealthchange(inst, data, forcesilent)

	if inst.sg:HasStateTag("nomorph") or
		inst:HasTag("playerghost") or
		inst.components.health:IsDead() then
		return
	end

	local silent = inst.sg:HasStateTag("silentmorph") or not inst.entity:IsVisible() or forcesilent

	if inst.form == "demonic" then
		if inst.components.health.currenthealth > (65) then
			becomenormal(inst, silent)
		end
	elseif inst.form == "normal" then
		if inst.components.health.currenthealth < (50) then
			becomedemonic(inst, silent)
		end
	end
	applyForm(inst)

end

local function onnewstate(inst)

	if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
		inst._wasnomorph = not inst._wasnomorph
		if not inst._wasnomorph then
				onhealthchange(inst)
		end
	end

end

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when reviving from ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "lancer_speed_mod", 1)
    if inst._wasnomorph == nil then
        inst.form = "normal"
        inst._wasnomorph = inst.sg:HasStateTag("nomorph")
        inst:ListenForEvent("healthdelta", onhealthchange)
        inst:ListenForEvent("newstate", onnewstate)
		if inst.demontask then
		inst.demontask:Cancel()
		inst.demontask = nil
		inst:RemoveTag("noheal")
	end
        onhealthchange(inst, nil, true)
    end
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "lancer_speed_mod")
  	if inst._wasnomorph ~= nil then
		inst.form = "normal"
		inst._wasnomorph = nil
		inst:RemoveEventCallback("healthdelta", onhealthchange)
		inst:RemoveEventCallback("newstate", onnewstate)
	end
end
--Demon test end

--Lancer body loot
local function OnDeath(inst)
    local lootbag = SpawnPrefab("lancerlootbag")
    local loot = { "hound" }
    lootbag.components.lootdropper:SetLoot(loot)
    lootbag.components.lootdropper:DropLoot(inst:GetPosition())
    lootbag:Remove()
	SpawnPrefab("shadow_shield1").entity:AddFollower():FollowSymbol(inst.GUID, "swap_body", 0, 0, 0)
end
--End body loot

--Can only wear one body type equip
local function WearOnlySpecifiedArmor(inst)
	local _Equip = inst.components.inventory.Equip
	inst.components.inventory.Equip = function(self, item, old_to_active)
		if not item or not item.components.equippable or not item:IsValid() then
			return
		end
		if item.components.equippable.equipslot == EQUIPSLOTS.BODY then
			if not (item.prefab == "armorwood") then
				inst.components.talker:Say("Doesn't fit my style.", 2.5,true) 
				self:DropItem(item)
				self:GiveItem(item)
				return
			end
		end
		return _Equip(self, item, old_to_active)
	end
end
--Can only wear one body type equip end

local function giveitem(inst)
    local item = SpawnPrefab("bandage")
    inst.components.inventory:GiveItem(item)
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
	
	inst:ListenForEvent("ms_respawnedfromghost", giveitem)
    inst:ListenForEvent("ms_becameghost", giveitem)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local untouchables = {
	chester = true,
	glommer = true,
	hutch = true,
}  

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "lancer.tex" )
	inst:AddTag("lanceruser")
	inst:AddTag("fishpro")
	
	-- inst.transformed = false 
	-- inst:AddComponent("keyhandler")
    -- inst.components.keyhandler:AddActionListener("lancer", TUNING.LANCER.KEY, "POWER")
	
	inst:DoTaskInTime(0, function()
		local old = inst.replica.combat.IsValidTarget
		inst.replica.combat.IsValidTarget = function(self, target)
			if target and untouchables[target.prefab] then
				return false
			end
			return old(self, target)
		end
	end)
end

--Check for Gaebolg
local function IsGaebolg(item)
    return item.prefab == "gaebolg"
end

local function onworked(inst, data)
	local equipitem = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if equipitem ~= nil and (equipitem.prefab == "pickaxe" or equipitem.prefab == "goldenpickaxe") then
		local itemuses = equipitem.components.finiteuses ~= nil and equipitem.components.finiteuses:GetUses() or nil
		if itemuses == nil or itemuses > 0 then
			--Don't make Gaebolg if we already have one
			if inst.components.inventory:FindItem(IsGaebolg) == nil then
				local gaebolg = SpawnPrefab("gaebolg")
				gaebolg.components.chosenlancer.revert_prefab = equipitem.prefab
				gaebolg.components.chosenlancer.revert_uses = itemuses
				equipitem:Remove()
				inst.components.inventory:Equip(gaebolg)
				if gaebolg.components.chosenlancer.transform_fx ~= nil then
					local fx = SpawnPrefab(gaebolg.components.chosenlancer.transform_fx)
					if fx ~= nil then
						fx.entity:AddFollower()
						fx.Follower:FollowSymbol(inst.GUID, "swap_object", 50, -25, 0)
					end
				end
			end
		end
	end
end
--End Check for Gaebolg

local function Glowy(inst)
	if inst.form == "demonic" then
		SpawnPrefab("ember_short_fx").entity:AddFollower():FollowSymbol(inst.GUID, "swap_body", 0, 0, 0)
		inst:DoTaskInTime(math.random(6, 8), Glowy)
	end
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "lancer"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(300)
	inst.components.hunger:SetMax(75)
	inst.components.sanity:SetMax(125)
	
	WearOnlySpecifiedArmor(inst)
	inst.components.builder:UnlockRecipe("armorwood")
	inst.components.builder:UnlockRecipe("rope")
			
	inst:ListenForEvent("death", OnDeath)
	inst:DoTaskInTime(math.random(6, 8), Glowy)
		
	--Gaebolg Callback
	inst:ListenForEvent("working", onworked)
	inst:ListenForEvent("onequip", WearOnlySpecifiedArmor)
			
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	--Glow Time
	inst:DoTaskInTime(math.random(6, 8), Glowy)
	
	--Speech Colour
	inst.components.talker.fontsize = 46     
	inst.components.talker.font = TALKINGFONT    
	inst.components.talker.colour = Vector3(0/255,191/255,255/255)
	
	local _DoDelta = inst.components.health.DoDelta
	inst.components.health.DoDelta = function(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
		if amount > 0 then
			if self.inst:HasTag("noheal") then
				amount = 0
			end
		end
		_DoDelta(self, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
	end
	
	inst.components.health.SetPenalty = function(self, penalty)
    self.penalty = math.clamp(penalty, 0, 0)
	end
		
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("lancer", prefabs, assets, common_postinit, master_postinit, start_inv)
