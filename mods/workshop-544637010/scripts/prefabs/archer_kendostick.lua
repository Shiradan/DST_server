local assets=
{
    Asset("ANIM", "anim/kendostick.zip"),
    Asset("ANIM", "anim/swap_kendostick.zip"),
  
    Asset("ATLAS", "images/inventoryimages/kendostick.xml"),
    Asset("IMAGE", "images/inventoryimages/kendostick.tex"),
}
local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_kendostick", "swap_kendostick")
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
 
local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("kendostick")
    inst.AnimState:SetBuild("kendostick")
    inst.AnimState:PlayAnimation("idle")
 
    inst:AddTag("sharp")
 
    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()
     
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(45)
  
    inst:AddComponent("inspectable")
      
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "kendostick"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/kendostick.xml"
	
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(1.5*30*16*2)
    inst.components.perishable:StartPerishing()
    inst.components.perishable:SetOnPerishFn(inst.Remove)
      
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	
	inst.OnBuilt = linkToBuilder
     
    return inst
end
return  Prefab("common/inventory/archer_kendostick", fn, assets) 