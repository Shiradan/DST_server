local assets=
{
    Asset("ANIM", "anim/gsword.zip"),
    Asset("ANIM", "anim/swap_gsword.zip"),
  
    Asset("ATLAS", "images/inventoryimages/gsword.xml"),
    Asset("IMAGE", "images/inventoryimages/gsword.tex"),
}

local prefabs = 
{
}

--local function ShouldAcceptItem(inst, item)
  --  local player = GetPlayer()
   -- if player.components.inventory:Has("cutgrass", 4) then
    --   if item.prefab == "cutgrass" then
    --    return true
    --    end
  --  end
  --  return false
--end
--local function OnGetItemFromPlayer(inst, giver, item)
   -- local names = {"trinket_1"}
   -- inst.name = names[math.random(#names)]
   -- local trinket = SpawnPrefab(inst.name)
   -- if item.prefab == "cutgrass" then
    --   giver.components.inventory:ConsumeByName("cutgrass", 3)
     --  giver.components.inventory:GiveItem(trinket)
  --  end
--end
local function onattack(inst,attacker,item)
      local names = {"goldnugget"}
    inst.name = names[math.random(#names)]
    local gold = SpawnPrefab(inst.name)
    attacker.components.inventory:GiveItem(gold)
end

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_gsword", "swap_gsword")
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
      
    inst.AnimState:SetBank("gsword")
    inst.AnimState:SetBuild("gsword")
    inst.AnimState:PlayAnimation("idle")
 
    inst:AddTag("sharp")
 
    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()
     
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetOnAttack(onattack)
	
    inst:AddComponent("inspectable")

    --inst:AddComponent("trader")
    --inst.components.trader.onaccept = OnGetItemFromPlayer
    --inst.components.trader:SetAcceptTest(ShouldAcceptItem)

      
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "gsword"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/gsword.xml"
	
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(30)
    inst.components.perishable:StartPerishing()
    inst.components.perishable:SetOnPerishFn(inst.Remove)
      
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	
	inst.OnBuilt = linkToBuilder
   
    return inst
end
return  Prefab("common/inventory/archer_gsword", fn, assets, prefabs) 