local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:Enable(true)
    inst.Light:SetIntensity(.6)
    inst.Light:SetColour(237/255, 125/255, 178/255)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(3)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

return Prefab("illya_light", fn)