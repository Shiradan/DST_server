function MakeSpear(name)
    local fname = "spear_"..name
    local fn = nil

    local assets =
    {
        Asset("ANIM", "anim/"..fname..".zip"),
        Asset("ANIM", "anim/swap_"..fname..".zip"),
    }

    local function onequip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_"..fname, "swap_spear")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end

    local function onunequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end

    local function spear(bonus)
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        MakeInventoryPhysics(inst)
        inst.entity:AddNetwork()

        inst.AnimState:SetBank("spear")
        inst.AnimState:SetBuild(fname)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("sharp")
        inst:AddTag("pointy")

        if not TheWorld.ismastersim then
            return inst
        end

        inst.entity:SetPristine()

        inst:AddComponent("weapon")
        inst.components.weapon:SetDamage(TUNING.WEAPON_DAMAGE * bonus)

        inst:AddComponent("finiteuses")
        inst.components.finiteuses:SetMaxUses(TUNING.TOOL_USES * bonus)
        inst.components.finiteuses:SetUses(TUNING.TOOL_USES * bonus)

        inst.components.finiteuses:SetOnFinished(inst.Remove)

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "inventoryimages/"..fname..".xml"

        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)

        MakeHauntableLaunch(inst)

        return inst
    end

    local function iron()
        local inst = spear(TUNING.IRON_BONUS)
        
        if not TheWorld.ismastersim then
            return inst
        end
        return inst
    end

    local function cobalt()
        local inst = spear(TUNING.COBALT_BONUS)

        if not TheWorld.ismastersim then
            return inst
        end
        return inst
    end

    if name =="iron" then
        fn = iron
    elseif name == "cobalt" then
        fn = cobalt
    end
    
    return Prefab(fname, fn, assets)
end

return MakeSpear("iron"),
       MakeSpear("cobalt")--[[,
       MakeSpear("titan"),
       MakeSpear("tungsten")]]