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

STRINGS.NAMES.GILGAMESH_NOTICE_EN = "King's Diary"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GILGAMESH_NOTICE_EN = "Instructions of Gilgamesh\n*At the begining of the game,you will get the King's Key in you inventory or you can make it according to the recipe *\n*Take the key, right-click, and you will summon all the gates of babylon in the key*\n*and you can press the key X to recover gates*\n*take the gates focus the key,and right click put them into the key*\n*Warning:make sure to press X before go into the Cave*"
return  Prefab("common/inventory/gilgamesh_notice_en", fn, assets, prefabs) 