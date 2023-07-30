function MakeArmor(name)
	local fname = "armor_"..name
	local fn = nil

	local assets =
	{
		Asset("ANIM", "anim/"..fname..".zip"),
	}

	local function OnBlocked(owner) 
    	owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour") 
	end

	local function onequip(inst, owner) 
    	owner.AnimState:OverrideSymbol("swap_body", fname, "swap_body")
    	inst:ListenForEvent("blocked", OnBlocked, owner)
	end

	local function onunequip(inst, owner) 
    	owner.AnimState:ClearOverrideSymbol("swap_body")
    	inst:RemoveEventCallback("blocked", OnBlocked, owner)
	end

	local function armor(bonus)

		local inst = CreateEntity()
    
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
    	inst.entity:AddNetwork()
        inst.foleysound = "dontstarve/movement/foley/metalarmour"
    	MakeInventoryPhysics(inst)

    	inst.AnimState:SetBank("armor_ruins")
    	inst.AnimState:SetBuild(fname)
    	inst.AnimState:PlayAnimation("anim")
    
    	inst:AddTag("metal")
	
    	inst.entity:SetPristine()
    
    	if not TheWorld.ismastersim then
        	return inst
    	end

    	inst:AddComponent("inspectable")
    
    	inst:AddComponent("inventoryitem")
    	inst.components.inventoryitem.atlasname = "inventoryimages/"..fname..".xml"

    	inst:AddComponent("armor")
        inst.components.armor:InitCondition(TUNING.ARMOR_HARDNESS * bonus, TUNING.ARMOR_ABSORPTION * bonus)

        inst:AddComponent("heater")

    	inst:AddComponent("equippable")
    	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    	inst.components.equippable:SetOnEquip(onequip)
    	inst.components.equippable:SetOnUnequip(onunequip)
        inst.components.equippable.walkspeedmult = 0.85

    	MakeHauntableLaunch(inst)
	    
    	return inst
	end

    local function iron()
        local inst = armor(TUNING.IRON_BONUS)

        if not TheWorld.ismastersim then
            return inst
        end

    	return inst
	end

    local function cobalt()
        local inst = armor(TUNING.COBALT_BONUS)
        
        if not TheWorld.ismastersim then
            return inst
        end

        inst.components.heater.iscooler = true
        inst.components.heater.carriedheat= TUNING.COBALT_COOLER
        inst.components.heater.equippedheat = TUNING.COBALT_COOLER * 3
    
        return inst
    end

    if name == "iron" then
        fn = iron
    elseif name =="cobalt" then
        fn = cobalt
	end
        

	return Prefab(fname, fn, assets)
end

return MakeArmor("iron"),
       MakeArmor("cobalt")--[[,
	   MakeArmor("titan"),
	   MakeArmor("tungsten")]]