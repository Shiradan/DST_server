function MakeHelmet(name)
	local fname = "helmet_"..name
	local fn = nil

	local assets =
	{
    	Asset("ANIM", "anim/"..fname..".zip"),
	}

	local function onequip(inst, owner)
    	owner.AnimState:OverrideSymbol("swap_hat", fname, "swap_hat")
    	owner.AnimState:Show("HAT")
    	owner.AnimState:Show("HAT_HAIR")
    	owner.AnimState:Hide("HAIR_NOHAT")
    	owner.AnimState:Hide("HAIR")

    	if owner:HasTag("player") then
        	owner.AnimState:Hide("HEAD")
        	owner.AnimState:Show("HEAD_HAT")
    	end
	end

	local function onunequip(inst, owner)
    	owner.AnimState:ClearOverrideSymbol("swap_hat")
    	owner.AnimState:Hide("HAT")
    	owner.AnimState:Hide("HAT_HAIR")
    	owner.AnimState:Show("HAIR_NOHAT")
    	owner.AnimState:Show("HAIR")

    	if owner:HasTag("player") then
        	owner.AnimState:Show("HEAD")
        	owner.AnimState:Hide("HEAD_HAT")
    	end
	end

	local function helmet(bonus)
    	local inst = CreateEntity()
    
    	inst.entity:AddTransform()
    	inst.entity:AddAnimState()
    	inst.entity:AddNetwork()

    	MakeInventoryPhysics(inst)

    	inst.AnimState:SetBank(fname)
    	inst.AnimState:SetBuild(fname)
    	inst.AnimState:PlayAnimation("anim")
	    
    	inst:AddTag("hat")
	    
    	if not TheWorld.ismastersim then
        	return inst
    	end

    	inst.entity:SetPristine()
    
    	inst:AddComponent("inspectable")
    
    	inst:AddComponent("inventoryitem")
	    inst.components.inventoryitem.atlasname = "inventoryimages/"..fname..".xml"

    	inst:AddComponent("armor")
        inst.components.armor:InitCondition(TUNING.HELMET_HARDNESS * bonus, TUNING.HELMET_ABSORPTION * bonus)

        inst:AddComponent("heater")

        inst:AddComponent("waterproofer")
        inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALLMED)

    	inst:AddComponent("equippable")
    	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    	inst.components.equippable:SetOnEquip(onequip)
    	inst.components.equippable:SetOnUnequip(onunequip)
        inst.components.equippable.walkspeedmult = 0.95

    	MakeHauntableLaunch(inst)
	    
    	return inst
	end

	local function iron()
    	local inst = helmet(TUNING.IRON_BONUS)

        if not TheWorld.ismastersim then
        	return inst
    	end

    	return inst
	end

    local function cobalt()
        local inst = helmet(TUNING.COBALT_BONUS)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.components.heater.iscooler = true
        inst.components.heater.carriedheat= TUNING.COBALT_COOLER / 2
        inst.components.heater.equippedheat = TUNING.COBALT_COOLER

        return inst
    end

    if name == "iron" then
        fn = iron
    elseif name == "cobalt" then
        fn = cobalt
    end
    
	return Prefab(fname, fn, assets)
end

return MakeHelmet("iron"),
	   MakeHelmet("cobalt")--[[,
	   MakeHelmet("titan"),
	   MakeHelmet("tungsten")]]