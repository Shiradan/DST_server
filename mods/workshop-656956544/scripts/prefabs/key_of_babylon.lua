local assets=
{
Asset("ANIM", "anim/key_of_babylon.zip"),--这个是放在地上的动画文件
Asset("ANIM", "anim/swap_keyofbabylon_build.zip"), --这个是手上动画
Asset("ATLAS", "images/inventoryimages/key_of_babylon.xml"),--物品栏图标的xml
Asset("IMAGE", "images/inventoryimages/key_of_babylon.tex"),--物品栏图标的图片
}

local prefabs =
{
}

local function key_attack(inst,attacker,data)
  --[[  local target = attacker.components.combat.target
    	if target ~=nil and not target:HasTag("gilgamesh_target") then
        	target:AddTag("gilgamesh_target") 
        	attacker.components.talker:Say("标记敌人！")
    	end]]
end

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_keyofbabylon_build", "symbol")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
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
    inst.entity:AddDynamicShadow()
     
    MakeInventoryPhysics(inst)   

    inst.DynamicShadow:SetSize(1, 1)
      
    inst.AnimState:SetBank("key_of_babylon")
    inst.AnimState:SetBuild("key_of_babylon")
    inst.AnimState:PlayAnimation("idle",true)

    inst:AddTag("key_of_babylon")
    inst:AddTag("sharp")

       if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "key_of_babylon"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/key_of_babylon.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
    
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0.1)
    inst.components.weapon:SetRange(15,15)
    inst.components.weapon:SetOnAttack(key_attack)

    MakeHauntableLaunch(inst)

    return inst
end

return  Prefab("common/inventory/key_of_babylon", fn, assets, prefabs)

