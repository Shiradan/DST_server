local assets=
{
    Asset("ANIM", "anim/galientsword.zip"),
    Asset("ANIM", "anim/swap_galientsword.zip"),


  
    Asset("ATLAS", "images/inventoryimages/ea.xml"),
    Asset("IMAGE", "images/inventoryimages/ea.tex"),
}




local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_galientsword", "swap_galientsword")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

end

local function onattack_ea(inst, attacker, data)


    local x, y, z = inst.Transform:GetWorldPosition()
    if not attacker:HasTag("gilgamesh") then
        attacker.components.health:DoDelta(-5)
        attacker.components.sanity:DoDelta(-10)
        SpawnPrefab("statue_transition_2")
    elseif attacker then
      -- SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())



    end
 

   --inst.components.finiteuses:Use(1)
end

  
local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

end


 
local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("galientsword")
    inst.AnimState:SetBuild("galientsword")
    inst.AnimState:PlayAnimation("idle")
	
    --inst.MiniMapEntity:SetIcon("galientsword.tex")
 
    inst:AddTag("sharp")
 
    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()
     
    inst:AddComponent("weapon")
    inst.components.weapon:SetRange(10,10)
    inst.components.weapon:SetDamage(50)
	inst.components.weapon:SetOnAttack(onattack_ea)
  
    inst:AddComponent("inspectable")
      
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ea"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ea.xml"
		      
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )

    
    return inst
end

return  Prefab("common/inventory/ea", fn, assets, prefabs) 