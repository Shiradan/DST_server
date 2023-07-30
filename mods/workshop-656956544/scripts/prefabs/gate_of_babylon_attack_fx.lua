local assets =
{
    Asset("ANIM", "anim/gate_of_babylon_attack_fx.zip"),
}

local function GateAttackAnim(proxy)
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.Transform:SetFromProxy(proxy.GUID)
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("gate_of_babylon_attack_fx")
    inst.AnimState:SetBuild("gate_of_babylon_attack_fx")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetFinalOffset(-1)

    --inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
   -- inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

    inst:ListenForEvent("animover", inst.Remove)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    --Dedicated server does not need to spawn the local fx
    if not TheNet:IsDedicated() then
        --Delay one frame so that we are positioned properly before starting the effect
        --or in case we are about to be removed
        inst:DoTaskInTime(0, GateAttackAnim)
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst:DoTaskInTime(4, inst.Remove)

    return inst
end

return Prefab("gate_of_babylon_attack_fx", fn, assets) 
