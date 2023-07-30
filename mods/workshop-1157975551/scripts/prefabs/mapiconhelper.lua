local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddMiniMapEntity()

    inst:AddTag("CLASSIFIED")

	inst:AddTag("NOBLOCK")
    inst:AddTag("NOCLICK")

	inst.persists = false

	return inst
end

return Prefab("mapiconhelper", fn)
