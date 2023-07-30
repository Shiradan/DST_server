local assets =
{
	Asset("ANIM", "anim/dpgun.zip"),
	Asset("ANIM", "anim/swap_dpgun.zip"),
    Asset("ATLAS", "images/inventoryimages/dpgun.xml"),
	
}

local prefabs = 
{
    "fire_projectile", 
	"dpclip",
}

local function onattack_dpgun(inst, owner, target)
	owner.components.inventory:ConsumeByName("dpclip", 1)
	target:AddTag("dpclip_hit")
	--[[
	if target:HasTag("dpclip_hit") and target.components.health:IsDead() then
	SpawnPrefab("dpclip").Transform:SetPosition(target.Transform:GetWorldPosition())
	end
	]]
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_dpgun", "swap_dpgun")
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
	local minimap = inst.entity:AddMiniMapEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("dpgun")
    inst.AnimState:SetBuild("dpgun")
    inst.AnimState:PlayAnimation("idle")
	inst:AddTag("dpgun") 
    
	
	inst:AddTag("firestaff")
    inst:AddTag("rangedfireweapon")
	
	 if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()
  
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(25)
    inst.components.weapon:SetRange(10)
    inst.components.weapon:SetOnAttack(onattack_dpgun)
    inst.components.weapon:SetProjectile("fire_projectile")
	
	
	minimap:SetIcon("dpgun.tex")
	

	inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/dpgun.xml"
 
    inst:AddComponent("equippable")
	
	
	inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	
	MakeHauntableLaunch(inst)
	
    inst.HasAmmo = function(inst, owner)
		if owner and owner.components.inventory and owner.components.inventory:Has("dpclip", 1) then
			return true
		end
		return false
	end
 
    return inst
end

STRINGS.NAMES.DPGUN = "Gun"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DPGUN = "Shoot!"


return Prefab("common/inventory/dpgun", fn, assets)