local assets=
{
Asset("ANIM", "anim/enkidu_dx.zip"),--这个是放在地上的动画文件
--Asset("ANIM", "anim/swap_enkidu_dx.zip"),
--Asset("ANIM", "anim/swap_keyofbabylon_build.zip"), --这个是手上动画
Asset("ATLAS", "images/inventoryimages/enkidu.xml"),--物品栏图标的xml
Asset("IMAGE", "images/inventoryimages/enkidu.tex"),--物品栏图标的图片
Asset("ATLAS", "images/inventoryimages/enkidu_dx2.xml"),--物品栏图标的xml
Asset("IMAGE", "images/inventoryimages/enkidu_dx2.tex"),--物品栏图标的图片
}

local PHYSICS_RADIUS = .2

local prefabs =
{
    "gilgamesh",
   --"gate_of_babylon",
}

--LootTables = {"goldnugget",}

local function Default_PlayAnimation(inst, anim, loop)
    inst.AnimState:PlayAnimation(anim, loop)
end

local function Default_PushAnimation(inst, anim, loop)
    inst.AnimState:PushAnimation(anim, loop)
end

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst)
    if not inst:HasTag("burnt") then
        inst:_PlayAnimation("hit")
      --  if inst.components.prototyper.on then
    --        inst:_PushAnimation(isgifting(inst) and "proximity_gift_loop" or "proximity_loop", true)
    --    else
        inst:_PushAnimation("idle", false)
        end
   -- end
end



local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end


local function onbuilt(inst, data)
    inst:_PlayAnimation("hit")
    inst:_PushAnimation("idle", false)
        --inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_"..soundprefix.."_place")
               
end

local function fn()
  
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    -- inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1, 3)

    inst.AnimState:SetBank("enkidu_dx")
    inst.AnimState:SetBuild("enkidu_dx")
    inst.AnimState:PlayAnimation("idle")


    inst:AddTag("structure")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY

    --inst:AddComponent("inventoryitem")
   -- inst.components.inventoryitem.imagename = "enkidu"
   -- inst.components.inventoryitem.atlasname = "images/inventoryimages/enkidu.xml"

    inst:ListenForEvent("onbuilt", onbuilt)

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(20)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
   -- MakeSnowCovered(inst)

   -- MakeLargeBurnable(inst, nil, nil, true)
    --MakeLargePropagator(inst)

    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    --inst:ListenForEvent("ms_addgiftreceiver", refreshonstate)
    --inst:ListenForEvent("ms_removegiftreceiver", refreshonstate)
    --inst:ListenForEvent("ms_giftopened", ongiftopened)

    inst._PlayAnimation = Default_PlayAnimation
    inst._PushAnimation = Default_PushAnimation

    return inst
end


return  Prefab("enkidu_dx", fn, assets, prefabs), 
        MakePlacer("enkidu_dx_placer", "enkidu_dx", "enkidu_dx", "idle")