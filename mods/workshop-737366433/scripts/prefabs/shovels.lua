function MakeShovel(name)
    local fname = "shovel_"..name
    local fn = nil

    local assets=
    {
        Asset("ANIM", "anim/"..fname..".zip"),
        Asset("ANIM", "anim/swap_"..fname..".zip"),
    }

    local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_"..fname, "swap_goldenshovel")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end
 
    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end

    local function shovel(bonus)
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        MakeInventoryPhysics(inst)
        inst.entity:AddNetwork()
     
        inst.AnimState:SetBank("goldenshovel")
        inst.AnimState:SetBuild(fname)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("sharp")

        if not TheWorld.ismastersim then
            return inst
        end
    
        inst.entity:SetPristine()

        inst:AddComponent("tool")
        inst.components.tool:SetAction(ACTIONS.DIG)

        inst:AddComponent("finiteuses")
        inst.components.finiteuses:SetOnFinished(inst.Remove) 
        inst.components.finiteuses:SetMaxUses(TUNING.TOOL_USES * bonus)
        inst.components.finiteuses:SetUses(TUNING.TOOL_USES * bonus)
        inst.components.finiteuses:SetConsumption(ACTIONS.DIG, 1 / bonus)

        inst:AddComponent("weapon")
        inst.components.weapon:SetDamage(TUNING.TOOL_DAMAGE * bonus)
        inst.components.weapon.attackwear = TUNING.TOOL_ATTACK_PENALTY

        inst:AddComponent("inspectable")
        
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "inventoryimages/"..fname..".xml"

        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(OnEquip)
        inst.components.equippable:SetOnUnequip(OnUnequip)
    
        inst:AddInherentAction(ACTIONS.DIG)

        MakeHauntableLaunch(inst)
 
        return inst
    end

    local function iron()
        local inst = shovel(TUNING.IRON_BONUS)

        if not TheWorld.ismastersim then
            return inst
        end

        return inst
    end

    local function cobalt()
        local inst = shovel(TUNING.COBALT_BONUS)

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
    
    return  Prefab(fname, fn, assets, prefabs)
end

return MakeShovel("iron"),
       MakeShovel("cobalt")--[[,
       MakeShovel("titan"),
       MakeShovel("tungsten")]]