local assets=
{
    Asset("ANIM", "anim/gaebolg.zip"),
    Asset("ANIM", "anim/swap_gaebolg.zip"),
  
    Asset("ATLAS", "images/inventoryimages/gaebolg.xml"),
    Asset("IMAGE", "images/inventoryimages/gaebolg.tex"),
}

local prefabs = 
{

}

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_gaebolg", "swap_gaebolg")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end
  
local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onattack_lancer(inst, attacker, target)	
    local atkfx = SpawnPrefab("shadowstrike_slash2_fx")
    if atkfx then
	    local follower = atkfx.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
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
    inst.entity:AddNetwork()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("gaebolg")
    inst.AnimState:SetBuild("gaebolg")
    inst.AnimState:PlayAnimation("idle")
 
    inst:AddTag("sharp")
 
    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()
	
	inst._container = nil
	
    inst._oncontainerownerchanged = function(container)
        topocket(inst, container)
    end

    inst._oncontainerremoved = function()
        unstore(inst)
    end
	
    inst:AddComponent("chosenlancer")
    inst.components.chosenlancer.revert_fx = "lucy_ground_transform_fx"
    inst.components.chosenlancer.transform_fx = "lucy_transform_fx"
    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
     
    inst:AddComponent("weapon")
	inst.components.weapon:SetOnAttack(onattack_lancer)
    inst.components.weapon:SetDamage(36)
	inst.components.weapon:SetRange(1.3,1.3)
	
    inst:AddComponent("inspectable")
      
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.imagename = "gaebolg"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/gaebolg.xml"
      
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.inventoryitem.keepondeath = true
		     
    return inst
end

STRINGS.NAMES.GAEBOLG = "Lancer's Gae Bolg."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GAEBOLG = "Here it comes, the one Scáthach handed down directly!"

return  Prefab("common/inventory/gaebolg", fn, assets, prefabs) 