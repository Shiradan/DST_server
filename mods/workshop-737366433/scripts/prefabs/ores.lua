function MakeOre(name)

	local fname = "ore_"..name
	local bank = fname
	local build = fname

	local assets=
	{--[[ASSETS]]
		Asset("ANIM", "anim/"..fname..".zip"),
	}

	local function shine(inst)
    	inst.task = nil
    	inst.AnimState:PlayAnimation("sparkle")
    	inst.AnimState:PushAnimation("idle")
    	inst.task = inst:DoTaskInTime(4 + math.random() * 5, shine)
	end

	local function ore()
    	local inst = CreateEntity()
    	inst.entity:AddTransform()
    	inst.entity:AddAnimState()
    	inst.entity:AddNetwork()
    	MakeInventoryPhysics(inst)
    	inst.entity:AddSoundEmitter()
    
    
    	if not TheWorld.ismastersim then
        	return inst
    	end
    
    	inst.AnimState:SetRayTestOnBB(true);
    	inst.AnimState:SetBank(bank)
    	inst.AnimState:SetBuild(build)
    	inst.AnimState:PlayAnimation("idle")
    
    	inst:AddComponent("tradable")
    
    	inst:AddComponent("stackable")
    	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    
    	inst:AddComponent("inspectable")
    
    	inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "inventoryimages/"..fname..".xml"

    	inst:AddComponent("repairer")
    
    
    	MakeHauntableLaunchAndSmash(inst)   
    	shine(inst)
    
    	return inst
	end

	return Prefab(fname, ore, assets)
end

return MakeOre("iron"),
       MakeOre("cobalt")--[[,
	   MakeOre("titan"),
	   MakeOre("tungsten")]]