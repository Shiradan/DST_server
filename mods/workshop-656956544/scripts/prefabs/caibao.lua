local assets=
{
Asset("ANIM", "anim/caibao.zip"),--这个是放在地上的动画文件
--Asset("ANIM", "anim/swap_keyofbabylon_build.zip"), --这个是手上动画
Asset("ATLAS", "images/inventoryimages/caibao.xml"),--物品栏图标的xml
Asset("IMAGE", "images/inventoryimages/caibao.tex"),--物品栏图标的图片
}

local prefabs =
{
    "gate_of_babylon"
}

local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("caibao")
    inst.AnimState:SetBuild("caibao")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("treasures")
    --inst:AddTag("flute")

 
    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()
    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize =40

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "caibao"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/caibao.xml"

    MakeHauntableLaunch(inst)

    STRINGS.NAMES.CAIBAO = "王的财宝"
    return inst
end


return  Prefab("common/inventory/caibao", fn, assets, prefabs) 