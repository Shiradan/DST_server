local assets =
{
    Asset("ANIM", "anim/illya_rubystar.zip"),
    Asset("ANIM", "anim/illya_rubystar_swap.zip"),
    Asset("ATLAS", "images/illya_rubystar.xml"),
	Asset("IMAGE", "images/illya_rubystar.tex"),
}

local prefabs =
{
    "ice_projectile",
}


	local function OnEquip(inst, owner)
	if owner.prefab == "illya_mahoo" then
		inst.Light:Enable(true)
		owner.components.combat:SetAreaDamage(8, 1)
        owner.AnimState:OverrideSymbol("swap_object", "illya_rubystar_swap", "swap_cane")
        owner.components.combat.damagemultiplier = 1
		owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
		owner.illya_weapon_ok = 1
		if not(owner.Mag_Power == nil) then
		owner.Mag_Power2 = owner.Mag_Power2 + 60
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
 
    local function OnUnequip(inst, owner)
		inst.Light:Enable(false)
		owner.components.combat:SetAreaDamage(nil, nil)
		--owner.components.combat.damagemultiplier = 0.5
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
		owner.illya_weapon_ok = 0
		if not(owner.Mag_Power == nil) then
		owner.Mag_Power2 = owner.Mag_Power2 - 60
		end
		local amulet = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
		if owner.illya_amulet == 1 then
		owner.components.combat.damagemultiplier = 0.7
		else
		owner.components.combat.damagemultiplier = 0.5
		end
    end

local function onlightning(staff, caster, target)
	if caster.components.sanity ~= nil and caster.components.sanity.current >= 55 then
		caster.components.sanity:DoDelta(- 55)
				else
		caster.components.health:DoDelta(- 13, true)
		end

	if target.components.health and caster.Mag_Power then
		target.components.health:DoDelta(- (caster.Mag_Power + caster.Mag_Power2) * 0.4 - 20)
	end
--	target.AnimState:SetMultColour(125/255,125/255,125/255,1)
	--staff.components.finiteuses:Use(1)
	SpawnPrefab("lightning").Transform:SetPosition(target.Transform:GetWorldPosition())


end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)
	inst.AnimState:SetBank("cane")
	inst.AnimState:SetBuild("illya_rubystar")
	inst.AnimState:PlayAnimation("idle")
	inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		return inst
	end
	--[[inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(20)
	inst.components.finiteuses:SetUses(20)
	if inst.components.finiteuses.current < 0 then
       inst.components.finiteuses.current = 0
    end]]
	--inst.components.finiteuses:SetOnFinished(inst.Remove)
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/illya_rubystar.xml"
	inst.components.inventoryitem.imagename = "illya_rubystar"
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(OnEquip)
	inst.components.equippable:SetOnUnequip(OnUnequip)
	inst:AddComponent("inspectable")
		local light = inst.entity:AddLight()--光 
	light:Enable(true) 
	light:SetRadius(2) --范围
	light:SetIntensity(0.8) --光亮度
	light:SetColour(255/255,255/255,192/255) 
	light:SetFalloff(0.33)--亮度衰减，越小越好。不可为0
	inst:AddComponent("weapon")
	inst.components.weapon:SetOnAttack(onlightning)
	inst.components.weapon:SetDamage(1)
	inst.components.weapon:SetRange(20, 25)
	inst.components.weapon:SetProjectile("bishop_charge")
	
    return inst
end

return Prefab("common/inventory/illya_rubystar2", fn, assets, prefabs)
