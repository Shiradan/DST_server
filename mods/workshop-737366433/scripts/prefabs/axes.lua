function MakeAxe(name)
	local fname = "axe_"..name
	local fn = nil
	local assets=
	{
		Asset("ANIM", "anim/"..fname..".zip"),
		Asset("ANIM", "anim/swap_"..fname..".zip"),
	}

	local function onequip(inst, owner) 
    	owner.AnimState:OverrideSymbol("swap_object", "swap_"..fname, "swap_axe")
    	owner.AnimState:Show("ARM_carry") 
    	owner.AnimState:Hide("ARM_normal")
	end

	local function onunequip(inst, owner) 
    	owner.AnimState:Hide("ARM_carry") 
    	owner.AnimState:Show("ARM_normal") 
	end

	local function onattack(weapon, attacker, target)
    	if target ~= nil then
        	weapon.components.finiteuses:Use(TUNING.TOOL_ATTACK_PENALTY)
    	end
	end

	local function axe(bonus)

    	local inst = CreateEntity()

    	inst.entity:AddTransform()
    	inst.entity:AddAnimState()
    	inst.entity:AddSoundEmitter()
    	inst.entity:AddNetwork()

    	MakeInventoryPhysics(inst)

    	inst.AnimState:SetBank("axe")
    	inst.AnimState:SetBuild(fname)
    	inst.AnimState:PlayAnimation("idle")

    	inst:AddTag("sharp")
	
    	inst.entity:SetPristine()

    	if not TheWorld.ismastersim then
        	return inst
    	end

    	-----
    	inst:AddComponent("tool")
    	inst.components.tool:SetAction(ACTIONS.CHOP, bonus)
    	-------
    	inst:AddComponent("finiteuses")
    	inst.components.finiteuses:SetOnFinished(inst.Remove)
    	inst.components.finiteuses:SetMaxUses(TUNING.TOOL_USES * bonus)
    	inst.components.finiteuses:SetUses(TUNING.TOOL_USES * bonus)
    	inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, 1 / bonus)
    	-------
    	inst:AddComponent("weapon")
    	inst.components.weapon:SetAttackCallback(onattack)
    	inst.components.weapon:SetDamage(TUNING.TOOL_DAMAGE * bonus)

    	inst:AddComponent("inventoryitem")
      inst.components.inventoryitem.atlasname = "inventoryimages/"..fname..".xml"

    	inst:AddComponent("inspectable")
    
    	inst:AddComponent("equippable")
    	inst.components.equippable:SetOnEquip(onequip)
    	inst.components.equippable:SetOnUnequip(onunequip)

    	MakeHauntableLaunch(inst)

    	return inst
	end

	local function iron()
        local bonus = TUNING.IRON_BONUS
    	local inst = axe(bonus)

    	if not TheWorld.ismastersim then
        	return inst
    	end

    	return inst
	end

    local function cobalt()
        local bonus = TUNING.COBALT_BONUS
        local inst = axe(bonus)
        
        if not TheWorld.ismastersim then
            return inst
        end

        return inst
    end
    
	if name == "iron" then
		fn = iron
    elseif name == "cobalt" then
        fn = cobalt
	end

	return Prefab(fname, fn, assets)
end

return MakeAxe("iron"),
       MakeAxe("cobalt")--[[,
	   MakeAxe("titan"),
	   MakeAxe("tungsten")]]