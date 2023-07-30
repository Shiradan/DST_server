local assets=
{
	Asset("ATLAS", "images/inventoryimages/gilgamesh_notice.xml"),
    Asset("IMAGE", "images/inventoryimages/gilgamesh_notice.tex"),
}

local function OnDropped(inst)
    inst.AnimState:PlayAnimation("book_tentacles")
end

local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("books")
    inst.AnimState:SetBuild("books")
    inst.AnimState:PlayAnimation("book_tentacles")

    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()

    inst:AddComponent("inspectable")
      
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "gilgamesh_notice"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/gilgamesh_notice.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    return inst
end

return  Prefab("common/inventory/gilgamesh_notice_ch", fn, assets, prefabs) 
