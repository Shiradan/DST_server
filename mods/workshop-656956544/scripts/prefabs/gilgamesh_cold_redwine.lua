local assets =
{
	Asset("ANIM", "anim/redwine.zip"),
    Asset("ATLAS", "images/inventoryimages/redwine.xml"),
    Asset("IMAGE", "images/inventoryimages/redwine.tex"),
}

local prefabs =
{
"ice",
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("redwine")
	inst.AnimState:SetBuild("redwine")
	inst.AnimState:PlayAnimation("idle")

	--inst:AddTag("drink")
	--inst:AddTag("preparedfood")
	inst:AddTag("cookable")

	if not TheWorld.ismastersim then
		return inst
	end

		inst.entity:SetPristine()

	inst:AddComponent("edible")
	--inst.components.edible.foodtype = "DRINK"
	inst.components.edible.healthvalue = 5
	inst.components.edible.hungervalue = 15
	inst.components.edible.sanityvalue = 37.5
	inst.components.edible.temperaturedelta = -10
	inst.components.edible.temperatureduration = 10

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "redwine"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/redwine.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = 20

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(9999)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "ice"

	--inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
end

return Prefab( "common/inventory/gilgamesh_cold_redwine", fn, assets, prefabs )