function MakePlate(name)
    local fname = "plate_"..name
    local fn = nil

    local assets=
    {
	   Asset("ANIM", "anim/"..fname..".zip"),
    }

    local function plate()
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
        inst.AnimState:SetBank("flint")
        inst.AnimState:SetBuild(fname)
        inst.AnimState:PlayAnimation("idle")
    
        inst:AddComponent("tradable")
    
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM / 2
        
        inst:AddComponent("inspectable")
    
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "inventoryimages/"..fname..".xml"
    
        MakeHauntableLaunchAndSmash(inst)
    
        return inst
    end

    return Prefab(fname, fn or plate, assets)
end

return MakePlate("iron"),
       MakePlate("cobalt")--[[,
       MakePlate("titan"),
       MakePlate("tungsten")]]