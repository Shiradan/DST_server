local assets=
{
	Asset("ANIM", "anim/goldenspear.zip"),
	Asset("ANIM", "anim/gold_spear.zip"),
    Asset("ATLAS", "images/inventoryimages/goldenspear.xml"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "gold_spear", "swap_spear")
	owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end


local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("spear")
    inst.AnimState:SetBuild("goldenspear")
    inst.AnimState:PlayAnimation("idle")
	
    inst:AddTag("sharp")

	if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.GOLDENSPEAR_DAMAGE)
    
    -------
    
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.GOLDENSPEAR_USES)
    inst.components.finiteuses:SetUses(TUNING.GOLDENSPEAR_USES)
    
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/goldenspear.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	
	MakeHauntableLaunch(inst)
    
    return inst
end

return Prefab( "common/inventory/goldenspear", fn, assets) 
