local brain = require "brains/summonassassinbrain"

local assets = {
	Asset("ATLAS", "images/inventoryimages/summonassassin.xml"),
	Asset("ANIM", "anim/assassin.zip"),
}

local prefabs = {
	"caster",
	"groundpound_fx",
	"groundpoundring_fx",
	"assassinsword",
}

local function OnStopFollowing(inst)
    --print("assassin - OnStopFollowing")
    inst:RemoveTag("companion")
end

local function OnStartFollowing(inst)
    --print("assassin - OnStartFollowing")
    inst:AddTag("companion")
end

local function OnSave(inst, data)
    data.AssassinState = inst.AssassinState
end

local function SetGroundPounderSettings(inst, mode)
	if mode == "normal" then 
		inst.components.groundpounder2.damageRings = 2
		inst.components.groundpounder2.destructionRings = 2
		inst.components.groundpounder2.numRings = 3
	--[[elseif mode == "hibernation" then 
		inst.components.groundpounder.damageRings = 3
		inst.components.groundpounder.destructionRings = 3
		inst.components.groundpounder.numRings = 4]]
	end
end

local function OnSave(inst, data)
	data.cangroundpound = inst.cangroundpound
end

local function OnLoad(inst, data)
	if data ~= nil then
		inst.cangroundpound = data.cangroundpound
	end
end

local function ShouldAcceptItem(inst, item)
	local currenthealth = inst.components.health.currenthealth / inst.components.health.maxhealth
	if item.components.edible and currenthealth < 1 and item.components.edible.healthvalue > 0 then
		return true
	end
	if item.components.equippable and 
	(item.components.equippable.equipslot == EQUIPSLOTS.HEAD or 
	item.components.equippable.equipslot == EQUIPSLOTS.HANDS or 
	item.components.equippable.equipslot == EQUIPSLOTS.BODY) and 
	not item.components.projectile then
		if item.prefab == "batbat" then
			print("refusing batbat")
			return false
		end
		return true
	end
end

local function OnGetItemFromPlayer(inst, giver, item)
	if item.components.equippable and 
	(item.components.equippable.equipslot == EQUIPSLOTS.HEAD or 
	item.components.equippable.equipslot == EQUIPSLOTS.HANDS or 
	item.components.equippable.equipslot == EQUIPSLOTS.BODY) then     
		local newslot = item.components.equippable.equipslot
		local current = inst.components.inventory:GetEquippedItem(newslot)
		if current then
			inst.components.inventory:DropItem(current)
		end      
		inst.components.inventory:Equip(item)
	elseif item.components.edible then
		inst.components.health:DoDelta(item.components.edible:GetHunger(inst), nil, item.prefab)
		inst:PushEvent("oneatsomething", {food = item})
		inst.sg:GoToState("eat")
	end
end

local function OnRefuseItem(inst, item)
	inst.sg:GoToState("refuse")
	inst.components.talker:Say("...")
end

local function NormalRetargetFn(inst)
        return FindEntity(inst, TUNING.PIG_TARGET_DIST, function(guy)
                return guy:HasTag("monster") and guy.components.health and not guy.components.health:IsDead()
                and inst.components.combat:CanTarget(guy)
        end, nil, { "character" }, nil)
end

local function linkToBuilder(inst, builder)
	if not builder.components.leader then
		builder:AddComponent("leader")
	end
	builder.components.leader:AddFollower(inst, true)

	builder.components.health:DoDelta(-1, nil, nil, nil, nil, true)
    builder.components.sanity:DoDelta(-1)

	-- sound and anim reactions
    	if builder.components.combat.hurtsound ~= nil and builder.SoundEmitter ~= nil then
        	builder.SoundEmitter:PlaySound(builder.components.combat.hurtsound)
    	end

	builder:PushEvent("damaged", {})
end

local function OnAttacked(inst, data)
	local attacker = data.attacker
    inst.components.combat:SetTarget(attacker)
    inst.components.combat:ShareTarget(attacker, 30, function(dude)
		return dude:HasTag("summonedbyplayer") and dude.components.follower.leader == inst.components.follower.leader
	end, 5)
end

local function OnAttackOther(inst, data)
	local target = data.target
	inst.components.combat:ShareTarget(target, 30, function(dude)
		return dude:HasTag("summonedbyplayer") and dude.components.follower.leader == inst.components.follower.leader
	end, 5)
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()
	
	MakeCharacterPhysics(inst, 30, .3)
	
	inst.DynamicShadow:SetSize(2, 1.5)
	
	inst.Transform:SetFourFaced()
	inst.Transform:SetScale(1, 1, 1)

	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("assassin")
	inst.AnimState:PlayAnimation("idle_loop", true)
	inst.AnimState:Hide("ARM_carry")
	inst.AnimState:Show("ARM_normal")
	
    inst.MiniMapEntity:SetIcon("summonassassin.tex")
    inst.MiniMapEntity:SetPriority(4)
	
	inst:AddTag("summonassassin")
	inst:AddTag("sheltercarrier")
	inst:AddTag("summonedbyplayer")
    inst:AddTag("noauradamage")
	inst:AddTag("casterspecific")
	
    inst:AddTag("companion")
    inst:AddTag("character")
    inst:AddTag("scarytoprey")
    inst:AddTag("personal_assassin")
    inst:AddTag("notraptrigger")
	
    inst:AddTag("_named")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	MakeMediumBurnableCharacter(inst, "pig_torso")
	
	inst.persists = false
	
	inst:AddComponent("assassincracker")
	
	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(75)
	inst.components.combat:SetAttackPeriod(2)
	inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)
	
	local self = inst.components.combat
	local old = self.GetAttacked
	function self:GetAttacked(attacker, damage, weapon, stimuli)
		if attacker then
			return true
		end
		return old(self, attacker, damage, weapon, stimuli)
	end
			
	inst:AddComponent("follower")
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
    inst:ListenForEvent("startfollowing", OnStartFollowing)
	
	inst:AddComponent("followersitcommand")
	
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(800)
	inst.components.health:StartRegen(1, 1)
	inst.components.health.fire_damage_scale = 0
	
    --print("   inspectable")
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()
    --inst.components.inspectable.getstatus = GetStatus
    inst.components.inspectable.nameoverride = "assassin"
	
    --print("   knownlocations")
    inst:AddComponent("knownlocations")
	
	inst:AddComponent("groundpounder2")
	inst.components.groundpounder2.destroyer = true
	SetGroundPounderSettings(inst, "normal")
	--inst.components.groundpounder2.damageRings = 2
	--inst.components.groundpounder2.destructionRings = 2
	--inst.components.groundpounder2.numRings = 3
	
	inst:AddComponent("timer")

	inst:AddComponent("inventory")
	inst.sword = SpawnPrefab( "assassinsword" )

	if inst.sword ~= nil then
		inst.components.inventory:Equip( inst.sword )
	end
	
    inst:AddComponent("named")
	
	inst:AddComponent("locomotor")
	inst.components.locomotor.runspeed = 6
	inst.components.locomotor.walkspeed = 8
	
	inst:AddComponent("lootdropper")
	
	inst:AddComponent("talker")
	inst.components.talker:StopIgnoringAll()
	
	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.deleteitemonaccept = false
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem
	inst.components.trader:Enable()
	
	inst:ListenForEvent("equip", function()
	inst.AnimState:ClearOverrideSymbol("swap_hat")
	inst.AnimState:Show("hair")
	inst.AnimState:ClearOverrideSymbol("swap_body")
	end)
	
	inst.cangroundpound = false
	
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad

	inst:SetBrain(brain)
	inst:SetStateGraph("SGsummonassassin")
		
	inst.OnBuilt = linkToBuilder
	
	inst:ListenForEvent("attacked", OnAttacked)  
	inst:ListenForEvent("onattackother", OnAttackOther)

	return inst
end

return Prefab("common/summonassassin", fn, assets, prefabs)