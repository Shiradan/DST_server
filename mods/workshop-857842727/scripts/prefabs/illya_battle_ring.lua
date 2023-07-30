
local assets =
{
    Asset("ANIM", "anim/illya_battle_ring.zip"),
	Asset("ATLAS", "images/illya_battle_ring.xml")
}

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function onequip(inst, owner) 
	if owner.prefab == "illya_mahoo" then
    owner.AnimState:OverrideSymbol("swap_body", "illya_battle_ring", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)
	inst.mod_task = inst:DoPeriodicTask(20, function()
	owner.components.sanity:DoDelta(2)
	end)
		owner.illya_amulet = 1
	if owner.illya_weapon_ok == 1 then
	owner.components.combat.damagemultiplier = 1
	else
		owner.components.combat.damagemultiplier = 0.7
	end
	else
		owner:DoTaskInTime(0, function()
            local inv = owner.components.inventory 
            if inv then
                inv:GiveItem(inst)
            end
            local talker = owner.components.talker 
            if talker then
                talker:Say("I cannot use !")
            end
        end)
    end
	
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
	owner.illya_amulet = 0
	if owner.illya_weapon_ok == 1 then
	owner.components.combat.damagemultiplier = 1
	else
		owner.components.combat.damagemultiplier = 0.5
	end
	
	if inst.mod_task ~=nil then
	inst.mod_task:Cancel()
	inst.task = nil
	end
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("armor_ruins")
    inst.AnimState:SetBuild("illya_battle_ring")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("ruins")
    inst:AddTag("metal")

    inst.foleysound = "dontstarve/movement/foley/metalarmour"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/illya_battle_ring.xml"
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(10000000, 0.8)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

	inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/illya_battle_ring", fn, assets)
