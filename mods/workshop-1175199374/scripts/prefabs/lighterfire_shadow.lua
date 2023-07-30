local assets =
{

}

--In order to achive the effect I want without doing any art we have this...
--Basically it's just an object that burns when willow pulls out her shadow lighter
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("playerlight")
	
	inst:AddTag("willowsanityexcluded")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("burnable")
    inst.components.burnable:SetFXLevel(2)
    inst.components.burnable:AddBurnFX("nightlight_flame", Vector3(0, 0, 0)) --shadowflame
	--inst.components.burnable:AddBurnFX("pigtorch_flame", Vector3(0, 0, 0)) --orange flame
	inst.components.burnable:Ignite()

    inst.persists = false

    return inst
end

return Prefab("lighterfire_shadow", fn, assets)
