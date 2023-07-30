local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    -- Non-networked entity
 
    inst:AddComponent("lootdropper")
 
    return inst
end
 
return Prefab("lancerlootbag", fn)