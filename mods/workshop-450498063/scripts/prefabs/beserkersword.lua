local assets = {
	Asset("ANIM", "anim/beserkersword.zip"),
	Asset("ANIM", "anim/swap_beserkersword.zip"),

	Asset("ATLAS", "images/inventoryimages/beserkersword.xml"),
	Asset("IMAGE", "images/inventoryimages/beserkersword.tex")
}

local function OnEquip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_beserkersword", "swap_beserkersword")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function OnUnequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end

local function storeincontainer(inst, container)
    if container ~= nil and container.components.container ~= nil then
        inst:ListenForEvent("onputininventory", inst._oncontainerownerchanged, container)
        inst:ListenForEvent("ondropped", inst._oncontainerownerchanged, container)
        inst._container = container
    end
end

local function unstore(inst)
    if inst._container ~= nil then
        inst:RemoveEventCallback("onputininventory", inst._oncontainerownerchanged, inst._container)
        inst:RemoveEventCallback("ondropped", inst._oncontainerownerchanged, inst._container)
        inst._container = nil
    end
end

local function topocket(inst, owner)
    if inst._container ~= owner then
        unstore(inst)
        storeincontainer(inst, owner)
    end
end

local function toground(inst)
    unstore(inst)
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("beserkersword")
	inst.AnimState:SetBuild("beserkersword")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("sharp")
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst._container = nil
	
    inst._oncontainerownerchanged = function(container)
        topocket(inst, container)
    end

    inst._oncontainerremoved = function()
        unstore(inst)
    end
	
	inst:AddComponent("chosenillya")
    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(OnEquip)
	inst.components.equippable:SetOnUnequip(OnUnequip)
		
	inst:AddComponent("inspectable")
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(1.5*30*16*1)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "twigs"
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "beserkersword"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/beserkersword.xml"

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(100)

	return inst
end

return Prefab("common/inventory/beserkersword", fn, assets)
