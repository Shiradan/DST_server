local assets=
{
    Asset("ANIM", "anim/lawsword.zip"),
    Asset("ANIM", "anim/swap_lawsword.zip"),
  
    Asset("ATLAS", "images/inventoryimages/lawsword.xml"),
    Asset("IMAGE", "images/inventoryimages/lawsword.tex"),
}
local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_lawsword", "swap_lawsword")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end
  
local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function linkToBuilder(inst, builder)
	-- sound and anim reactions
	if builder then
		SpawnPrefab("mossling_spin_fx").Transform:SetPosition(inst:GetPosition():Get())
	end
end

local function onattack_lawsword(inst, attacker, data)
	if attacker then
		SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	end
end
 
local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("lawsword")
    inst.AnimState:SetBuild("lawsword")
    inst.AnimState:PlayAnimation("idle")
 
    inst:AddTag("sharp")
 
    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()
    
---------------------------------------------------
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(45)
	inst.components.weapon:SetOnAttack(onattack_lawsword)
  
    inst:AddComponent("inspectable")
      
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "lawsword"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/lawsword.xml"
	
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(1.5*30*16*2)
    inst.components.perishable:StartPerishing()
    inst.components.perishable:SetOnPerishFn(inst.Remove)
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )

	inst.OnBuilt = linkToBuilder
-------------------------

    return inst
end
return  Prefab("common/inventory/archer_lawsword", fn, assets, prefabs) --- Different compared to forum