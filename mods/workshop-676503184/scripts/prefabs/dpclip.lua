local assets=
{
	Asset("ANIM", "anim/dpclip.zip"),
	Asset("ATLAS", "images/inventoryimages/dpclip.xml"),
    Asset("IMAGE", "images/inventoryimages/dpclip.tex"),
}

local prefabs =
{

}


local function fncommon(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
	
    
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("stackable")	 
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
    inst:AddComponent("inspectable")
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dpclip.xml"

	return inst
end
local function fndpclip(Sim)
	local inst = fncommon(Sim)
	    
    inst.AnimState:SetBank("dpclip")--("bullet")
    inst.AnimState:SetBuild("dpclip")
    inst.AnimState:PlayAnimation("idle")    
    
    if not TheWorld.ismastersim then
        return inst
    end
	
	return inst
end


return Prefab( "common/inventory/dpclip", fndpclip, assets)
