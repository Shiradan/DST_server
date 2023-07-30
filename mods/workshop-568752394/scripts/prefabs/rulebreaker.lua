local assets=
{
    Asset("ANIM", "anim/rulebreaker.zip"),
    Asset("ANIM", "anim/swap_rulebreaker.zip"),
  
    Asset("ATLAS", "images/inventoryimages/rulebreaker.xml"),
    Asset("IMAGE", "images/inventoryimages/rulebreaker.tex"),
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

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_rulebreaker", "swap_rulebreaker")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end
  
local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

--Part of the Eyebone Testing
local SPAWN_DIST = 30

local function GetSpawnPoint(pt)
    local theta = math.random() * 2 * PI
    local radius = SPAWN_DIST
    local offset = FindWalkableOffset(pt, theta, radius, 12, true)
    return offset ~= nil and (pt + offset) or nil
end

local function SpawnAssassin(inst)
    if not inst.owner then
        print("Error: Eyebone has no linked player!")
        return
    end
    --print("assassin_eyebone - SpawnAssassin")
  
    local pt = inst:GetPosition()
    --print("    near", pt)
          
    local spawn_pt = GetSpawnPoint(pt)
    if spawn_pt ~= nil then
        --print("    at", spawn_pt)
        local assassin = SpawnPrefab("summonassassin")
        if assassin ~= nil then
            assassin.Physics:Teleport(spawn_pt:Get())
            assassin:FacePoint(pt:Get())
            if inst.owner then
                inst.owner.assassin = assassin
            end
            return assassin
        end
  
    --else
        -- this is not fatal, they can try again in a new location by picking up the bone again
        --print("assassin_eyebone - SpawnAssassin: Couldn't find a suitable spawn point for assassin")
    end
end

local StartRespawn

local function StopRespawn(inst)
    --print("dogoo_assassin - StopRespawn")
    if inst.respawntask ~= nil then
        inst.respawntask:Cancel()
        inst.respawntask = nil
        inst.respawntime = nil
    end
end

local function RebindAssassin(inst, assassin)
    assassin = assassin or (inst.owner and inst.owner.assassin)
    if assassin ~= nil then
        if inst.owner then
            assassin.components.named:SetName(inst.owner.name.."'s Assassin")
        end
        inst.AnimState:PlayAnimation("idle", true)
        inst:ListenForEvent("death", function()
            if inst.owner then
                inst.owner.assassin = nil
            end
            StartRespawn(inst, TUNING.CHESTER_RESPAWN_TIME)
        end, assassin)
  
        if assassin.components.follower.leader ~= inst then
            assassin.components.follower:SetLeader(inst)
        end
        return true
    end
end

local function RespawnAssassin(inst)
    --print("assassin_eyebone - RespawnAssassin")
    StopRespawn(inst)
    RebindAssassin(inst, (inst.owner and inst.owner.assassin) or SpawnAssassin(inst))
end

StartRespawn = function(inst, time)
    StopRespawn(inst)
  
    time = time or 0
    inst.respawntask = inst:DoTaskInTime(time, RespawnAssassin)
    inst.respawntime = GetTime() + time
    inst.AnimState:PlayAnimation("dead", true)
end

local function StopRespawn(inst)
    --print("assassin_eyebone - StopRespawn")
    if inst.respawntask ~= nil then
        inst.respawntask:Cancel()
        inst.respawntask = nil
        inst.respawntime = nil
    end
end

local function FixAssassin(inst)
    inst.fixtask = nil
    --take an existing assassin if there is one
          
        if inst.components.inventoryitem.owner ~= nil then
            local time_remaining = 0
            local time = GetTime()
            if inst.respawntime and inst.respawntime > time then
                time_remaining = inst.respawntime - time        
            end
            StartRespawn(inst, time_remaining)
        end
    end

local function OnPutInInventory(inst)
    if inst.fixtask == nil then
        inst.fixtask = inst:DoTaskInTime(1, FixAssassin)
    end
end

local function OnSave(inst, data)
    --print("assassin_eyebone - OnSave")
    --data.EyeboneState = inst.EyeboneState
    if inst.respawntime ~= nil then
        local time = GetTime()
        if inst.respawntime > time then
            data.respawntimeremaining = inst.respawntime - time
        end
    end
end

local function OnLoad(inst, data)
    if data == nil then
        return
    end
    
    if data.respawntimeremaining ~= nil then
        inst.respawntime = data.respawntimeremaining + GetTime()
    end
end

local function GetStatus(inst)
    --print("smallbird - GetStatus")
    if inst.respawntask ~= nil then
        return "WAITING"
    end
end

local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("rulebreaker")
    inst.AnimState:SetBuild("rulebreaker")
    inst.AnimState:PlayAnimation("idle")
 
    inst:AddTag("sharp")
    inst:AddTag("_named")
 
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.persists = false
 
    inst.entity:SetPristine()
	
	inst._container = nil
	
    inst._oncontainerownerchanged = function(container)
        topocket(inst, container)
    end

    inst._oncontainerremoved = function()
        unstore(inst)
    end
	
	inst:AddComponent("chosencaster")
    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
     
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(45)
	  
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus
    inst.components.inspectable:RecordViews()
    inst.components.inspectable.nameoverride = "assassin_eyebone"
      
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.imagename = "rulebreaker"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/rulebreaker.xml"
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
	
    inst:AddComponent("leader")
    inst:AddComponent("named")
	
    inst.fixtask = inst:DoTaskInTime(1, FixAssassin)
    inst.RebindAssassin = RebindAssassin
	      
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.inventoryitem.keepondeath = true
		     
    return inst
end
return  Prefab("common/inventory/rulebreaker", fn, assets, prefabs) 