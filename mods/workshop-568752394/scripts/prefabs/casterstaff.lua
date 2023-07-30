local assets=
{
    Asset("ANIM", "anim/casterstaff.zip"),
    Asset("ANIM", "anim/swap_casterstaff.zip"),
 
    Asset("ATLAS", "images/inventoryimages/casterstaff.xml"),
    Asset("IMAGE", "images/inventoryimages/casterstaff.tex"),
}

local function storeincontainer(inst, container)
    if container ~= nil and container.components.container ~= nil then
        inst:ListenForEvent("onputininventory", inst._oncontainerownerchanged, container)
        inst:ListenForEvent("ondropped", inst._oncontainerownerchanged, container)
        inst._container = container
    end
end

local function unstore(inst)
    if inst._container ~= nil then
        inst:RemoveEventCallback("onputininventory", inst._oncontainerownerchanged, inst._container)
        inst:RemoveEventCallback("ondropped", inst._oncontainerownerchanged, inst._container)
        inst._container = nil
    end
end

local function topocket(inst, owner)
    if inst._container ~= owner then
        unstore(inst)
        storeincontainer(inst, owner)
    end
end

local function toground(inst)
    unstore(inst)
end

local healthvalue = TUNING.HEALTHVALUE
local sanityvalue = TUNING.SANITYVALUE

local function onattack_casterstaff(inst, attacker, target)
    if attacker and attacker.components.health and attacker.components.sanity then
        attacker.components.health:DoDelta(healthvalue)
		attacker.components.sanity:DoDelta(sanityvalue)
    end
	
    local atkfx = SpawnPrefab("groundpound_fx")
	local atkfxx = SpawnPrefab("caster_ring_fx")
    if atkfx and atkfxx then
	    local follower = atkfx.entity:AddFollower()
		local follower = atkfxx.entity:AddFollower()
	    follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
    end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("casterstaff")
    inst.AnimState:SetBuild("casterstaff")
    inst.AnimState:PlayAnimation("idle")
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst._container = nil
	
    inst._oncontainerownerchanged = function(container)
        topocket(inst, container)
    end

    inst._oncontainerremoved = function()
        unstore(inst)
    end
	
	inst:AddComponent("chosencaster")
    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
 
    local function OnEquip(inst, owner)
		owner.components.combat:SetAreaDamage(7, 1)
        owner.AnimState:OverrideSymbol("swap_object", "swap_casterstaff", "swap_casterstaff")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end
 
    local function OnUnequip(inst, owner)
		owner.components.combat:SetAreaDamage(nil, nil)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end
 
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.imagename = "casterstaff"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/casterstaff.xml"
     
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
			
	inst:AddComponent("inspectable")
			
	inst:AddTag("shadow")
 	inst:AddComponent("weapon")
	inst.components.weapon:SetOnAttack(onattack_casterstaff)
    inst.components.weapon:SetDamage(45)
    inst.components.weapon:SetRange(12, 18)
	inst.components.weapon:SetProjectile("casterprojectile")

    return inst
	
end
	
return  Prefab("common/inventory/casterstaff", fn, assets)