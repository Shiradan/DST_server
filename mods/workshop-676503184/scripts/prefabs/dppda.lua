local assets=
{
    Asset("ANIM", "anim/dppda.zip"),
    Asset("ANIM", "anim/swap_dppda.zip"),
 
    Asset("ATLAS", "images/inventoryimages/dppda.xml"),
    Asset("IMAGE", "images/inventoryimages/dppda.tex"),
}

local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_dppda", "swap_dppda")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end
 
    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end
 
  local function onblink(staff, pos, caster)
    if caster.components.sanity ~= nil then
        caster.components.sanity:DoDelta(TUNING.TELEPORT_SANITY)
    end
 
end 

 local function blinkstaff_reticuletargetfn()
    local player = ThePlayer
    local rotation = player.Transform:GetRotation() * DEGREES
    local pos = player:GetPosition()
    for r = 13, 1, -1 do
        local numtries = 2 * PI * r
        local pt = FindWalkableOffset(pos, rotation, r, numtries)
        if pt ~= nil then
            return pt + pos
        end
    end
end
 
 local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
     
    inst.AnimState:SetBank("dppda")
    inst.AnimState:SetBuild("dppda")
    inst.AnimState:PlayAnimation("idle")
 
 if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()
    
    inst:AddTag("sharp")

    
    inst:AddComponent("blinkstaff")
    inst.components.blinkstaff.onblinkfn = onblink
 
    inst:AddComponent("inspectable")
	
     
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "dppda"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dppda.xml"
     
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
 
    return inst
end
   
return  Prefab("common/inventory/dppda", fn, assets, prefabs)
