local assets =
{
	Asset("ANIM", "anim/greatmeal.zip"),
    Asset("ATLAS", "images/inventoryimages/greatmeal.xml"),
    Asset("IMAGE", "images/inventoryimages/greatmeal.tex"),
}

local prefabs =
{
"gilgamesh_cold_redwine",
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
	
	inst.AnimState:SetBank("greatmeal")
	inst.AnimState:SetBuild("greatmeal")
	inst.AnimState:PlayAnimation("idle")

	--inst:AddTag("drink")
	inst:AddTag("meat")
	--inst:AddTag("cookable")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = 80
	inst.components.edible.hungervalue = 80
	inst.components.edible.sanityvalue = 80
	inst.components.edible.temperaturedelta = 20
	inst.components.edible.temperatureduration = 10

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "greatmeal"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/greatmeal.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = 10

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(999)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "gilgamesh_cold_redwine"

	--inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
end

return Prefab( "common/inventory/gilgamesh_great_meal", fn, assets, prefabs )