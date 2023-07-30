local assets =
{
	Asset("ANIM","anim/myfx.zip")
}

local function fn()


local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("myfx")
    inst.AnimState:SetBuild("myfx")
    inst.AnimState:PlayAnimation("green")

    inst.SoundEmitter:PlaySound("dontstarve/wilson/forcefield_LP", "loop")
	
	inst:AddTag("NOCLICK")
	inst:AddTag("FX")
	
    inst.entity:SetPristine()
	
	inst:DoTaskInTime(1, inst.Remove)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst

-- local inst = CreateEntity() --以下这三句都是默认要添加的，这里就不解释那么多了
-- local trans = inst.entity:AddTransform()
-- local anim = inst.entity:AddAnimState()

-- anim:SetBank("symbol_Tobi")-----前面两句是指定mori的图片边界和材质，在特效中作用不大，只是必写。
-- anim:SetBuild("symbol_Tobi")
-- anim:PlayAnimation("idle")----这一句说的是这个预设物一生成，就自动播放mori1这个动画（记得前面我们给动画命名的名字么？）

-- inst:DoTaskInTime(1, inst.Remove)--这句话说的是预设物在生成1秒之后移除。如果没有这一句，在播放完特效动画后，这个预设物会留在地图上。

-- return inst
end

return Prefab("pgreen", fn, assets)