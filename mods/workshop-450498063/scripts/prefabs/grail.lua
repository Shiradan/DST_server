local assets =
{
	Asset("ANIM", "anim/grail.zip"),
    Asset("ATLAS", "images/inventoryimages/grail.xml"),
	Asset("IMAGE", "images/inventoryimages/grail.tex"),
}

local prefabs = 
{
}

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

-- Still does nothing. Dunno what it should do...
local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddMiniMapEntity()
    MakeInventoryPhysics(inst)

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
	inst:AddTag("grail")
	
    inst.MiniMapEntity:SetIcon("grail.tex")
    inst.MiniMapEntity:SetPriority(5)
	
    if not TheWorld.ismastersim then
        return inst
    end
		
	inst.entity:SetPristine() 
	
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
    
    inst.AnimState:SetBank("grail")
    inst.AnimState:SetBuild("grail")
    inst.AnimState:PlayAnimation("idle", false)
	
    MakeHauntableLaunch(inst)
    inst:AddComponent("inspectable")
				
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "grail"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/grail.xml"
	
    return inst
end

return Prefab( "common/inventory/grail", fn, assets) 