
local assets=
{
    Asset("ANIM", "anim/gandr.zip"),
    Asset("ANIM", "anim/swap_gandr.zip"),
 
    Asset("ATLAS", "images/inventoryimages/gandr.xml"),
    Asset("IMAGE", "images/inventoryimages/gandr.tex"),

}

local function onattack_gandr(inst, attacker, target)

    if attacker and attacker.components.sanity then
        attacker.components.sanity:DoDelta(-8)
    end
end

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

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("gandr")
    inst.AnimState:SetBuild("gandr")
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
	
	inst:AddComponent("chosenrin")
    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
 
    local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_gandr", "swap_gandr")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end
 
    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end
 
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "gandr"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/gandr.xml"
     
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.inventoryitem.keepondeath = true
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED_LARGE * 1.5
	
	inst:AddComponent("inspectable")
		
	inst:AddTag("shadow")
 	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(45)
	inst.components.weapon:SetOnAttack(onattack_gandr)
    inst.components.weapon:SetRange(10, 12)
	inst.components.weapon:SetProjectile("rinprojectile")

    return inst
	
end
	
return  Prefab("common/inventory/gandr", fn, assets)