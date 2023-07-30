local assets=
{
    Asset("ANIM", "anim/gilgamesh_axe.zip"),
    Asset("ANIM", "anim/swap_gilgamesh_axe.zip"),

    Asset("ATLAS", "images/inventoryimages/swap_gilgamesh_axe.xml"),
    Asset("IMAGE", "images/inventoryimages/swap_gilgamesh_axe.tex"),
}



local function OnEquip(inst,owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_gilgamesh_axe", "symbol")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function OnUnequip(inst,owner)
	owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform() -- 添加变换组件
    inst.entity:AddAnimState() -- 添加动画组件
    inst.entity:AddNetwork() -- 添加网络组件

    MakeInventoryPhysics(inst) -- 设置物品拥有一般物品栏物体的物理特性

    inst.AnimState:SetBank("gilgamesh_axe")
    inst.AnimState:SetBuild("gilgamesh_axe")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("tool")
 	inst:AddTag("sharp")
 

    if not TheWorld.ismastersim then
        return inst
    end
    inst.entity:SetPristine()

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(45)
    inst.components.weapon:SetRange(4,4)
    --inst.components.weapon:SetOnAttack(axe_attack)

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.CHOP, 2)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "swap_gilgamesh_axe"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/swap_gilgamesh_axe.xml"

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1000)
    inst.components.finiteuses:SetUses(1000)
    inst.components.finiteuses:SetOnFinished(inst.Remove)
    inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, 1)


inst:AddComponent("inspectable")

return inst

end
STRINGS.NAMES.GILGAMESH_AXE = "乌鲁克战斧"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GILGAMESH_AXE = "王很喜欢的近战武器。"

return  Prefab("common/inventory/gilgamesh_axe", fn, assets) 