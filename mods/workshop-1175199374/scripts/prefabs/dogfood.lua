local assets=
{
	Asset("ANIM", "anim/dogfood.zip"),
	Asset("ATLAS", "images/inventoryimages/dogfood.xml"),
}


local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("dogfood")
    anim:SetBuild("dogfood")
    anim:PlayAnimation("idle")
    
	inst.entity:AddNetwork()
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dogfood.xml"	
	
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = 10
	
	inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.DOGFOOD
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0
    inst.components.edible.sanityvalue = 0
	
	
    
    return inst
end

return Prefab( "common/inventory/dogfood", fn, assets,prefabs) 









