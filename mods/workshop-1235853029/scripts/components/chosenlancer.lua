local function IsValidOwner(inst, owner)
    return owner:HasTag("lanceruser")
end

local function OwnerAlreadyHasChosenLancer(inst, owner)
    local equip = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    return equip ~= inst
        and equip ~= nil
        and equip.components.chosenlancer ~= nil
        and equip
        or owner.components.inventory:FindItem(function(item)
                return item.components.chosenlancer ~= nil and item ~= inst
            end)
end

local function OnCheckOwner(inst, self)
    self.checkownertask = nil
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner == nil or owner.components.inventory == nil then
        return
    elseif not IsValidOwner(inst, owner) then
        self:Drop()
        inst:PushEvent("axerejectedowner", owner)
    else
        local other = OwnerAlreadyHasChosenLancer(inst, owner)
        if other ~= nil then
            self:Drop()
            other:PushEvent("axerejectedotheraxe", inst)
        elseif owner:HasTag("player") then
            self:LinkToPlayer(owner)
        end
    end
end

local function OnChangeOwner(inst, owner)
    local self = inst.components.chosenlancer
    if self.currentowner == owner then
        return
    elseif self.currentowner ~= nil and self.oncontainerpickedup ~= nil then
        inst:RemoveEventCallback("onputininventory", self.oncontainerpickedup, self.currentowner)
        self.oncontainerpickedup = nil
    end

    if self.checkownertask ~= nil then
        self.checkownertask:Cancel()
        self.checkownertask = nil
    end

    self.currentowner = owner

    if owner == nil then
        return
    elseif owner.components.inventoryitem ~= nil then
        self.oncontainerpickedup = function()
            if self.checkownertask ~= nil then
                self.checkownertask:Cancel()
            end
            self.checkownertask = inst:DoTaskInTime(0, OnCheckOwner, self)
        end
        inst:ListenForEvent("onputininventory", self.oncontainerpickedup, owner)
    end
    self.checkownertask = inst:DoTaskInTime(0, OnCheckOwner, self)
end

local ChosenLancer = Class(function(self, inst)
    self.inst = inst

    self.revert_prefab = "axe"
    self.revert_uses = nil
    self.revert_fx = nil
    self.revert_time = TUNING.LUCY_REVERT_TIME
    self.transform_fx = nil

    self.player = nil --player link even if the item is dropped
    self.userid = nil --userid even if player link disconnects
    self.currentowner = nil --inventoryitem owner
    self.oncontainerpickedup = nil
    self.checkownertask = nil
    self.waittask = nil
    self.waittotime = nil

    self.onplayerdied = function() self:WaitForPlayer(nil, 3) end
    self.onplayerremoved = function() self:WaitForPlayer(self.userid) end
    self.onplayerchosenlancer = function() self:Revert() end
    self.onplayerjoined = function(world, player)
        if player.userid == self.userid then
            if IsValidOwner(inst, player) and OwnerAlreadyHasChosenLancer(inst, player) == nil then
                self:LinkToPlayer(player)
            else
                --If he is not woodie anymore or already has a Lucy,
                --then most likely c_despawned or died in Wilderness
                self:Revert()
            end
        end
    end

    inst:ListenForEvent("onputininventory", OnChangeOwner)
    inst:ListenForEvent("ondropped", OnChangeOwner)
end)

local function OnEndWait(inst, self)
    self.waittask = nil
    self.waittotime = nil
    self:Revert()
end

function ChosenLancer:WaitForPlayer(userid, delay)
    self:LinkToPlayer(nil)
    self.userid = userid
    if self.waittask ~= nil then
        self.waittask:Cancel()
        if userid == nil then
            self.inst:RemoveEventCallback("ms_playerjoined", self.onplayerjoined, TheWorld)
        end
    elseif userid ~= nil then
        self.inst:ListenForEvent("ms_playerjoined", self.onplayerjoined, TheWorld)
    end
    delay = delay or self.revert_time
    self.waittask = self.inst:DoTaskInTime(delay, OnEndWait, self)
    self.waittotime = GetTime() + delay
end

function ChosenLancer:StopWaitingForPlayer()
    if self.waittask == nil then
        return
    end
    self.waittask:Cancel()
    self.waittask = nil
    self.waittotime = nil
    if self.userid ~= nil then
        self.userid = nil
        self.inst:RemoveEventCallback("ms_playerjoined", self.onplayerjoined, TheWorld)
    end
end

function ChosenLancer:LinkToPlayer(player)
    self:StopWaitingForPlayer()

    if self.player == player then
        return
    elseif self.player ~= nil then
        self.inst:RemoveEventCallback("onremove", self.onplayerremoved, self.player)
        self.inst:RemoveEventCallback("chosenlancer", self.onplayerchosenlancer, self.player)
    end

    self.player = player
    if player == nil then
        self.userid = nil
        self.inst:PushEvent("axepossessedbyplayer", nil)
        return
    end
    self.userid = player.userid

    player:PushEvent("chosenlancer", self.inst)
    self.inst:ListenForEvent("onremove", self.onplayerremoved, player)
    self.inst:ListenForEvent("chosenlancer", self.onplayerchosenlancer, player)
    self.inst:PushEvent("axepossessedbyplayer", player)
end

function ChosenLancer:Drop()
    local owner = self.inst.components.inventoryitem:GetGrandOwner()
    if owner ~= nil and owner.components.inventory ~= nil then
        owner.components.inventory:DropItem(self.inst, true, true)
    end
end

function ChosenLancer:Revert()
    local axe = SpawnPrefab(self.revert_prefab)
    if axe == nil then
        return self.inst
    elseif self.revert_uses ~= nil and axe.components.finiteuses ~= nil then
        axe.components.finiteuses:SetUses(math.max(1, self.revert_uses))
    end

    local container = self.inst.components.inventoryitem ~= nil and self.inst.components.inventoryitem:GetContainer() or nil
    if container == nil then
        local x, y, z = self.inst.Transform:GetWorldPosition()
        self.inst:Remove()
        axe.Transform:SetPosition(x, y, z)
        if self.revert_fx ~= nil then
            local fx = SpawnPrefab(self.revert_fx)
            if fx ~= nil then
                fx.Transform:SetPosition(x, y, z)
            end
        end
    elseif self.inst.components.equippable ~= nil and self.inst.components.equippable:IsEquipped() then
        self.inst:Remove()
        container:Equip(axe)
        if self.revert_fx ~= nil then
            local fx = SpawnPrefab(self.revert_fx)
            if fx ~= nil then
                fx.entity:AddFollower()
                fx.Follower:FollowSymbol(container.inst.GUID, "swap_object", 50, -25, 0)
            end
        end
    else
        local slot = self.inst.components.inventoryitem:GetSlotNum()
        self.inst:Remove()
        container:GiveItem(axe, slot)
    end
    return axe
end

function ChosenLancer:OnSave()
    local data =
    {
        prefab = self.revert_prefab ~= "axe" and self.revert_prefab or nil,
        uses = self.revert_uses,
        userid = self.userid,
        waittimeremaining = self.waittotime ~= nil and self.waittotime - GetTime() or nil,
    }
    return next(data) ~= nil and data or nil
end

function ChosenLancer:OnLoad(data)
    if data ~= nil then
        self.revert_prefab = data.prefab or self.revert_prefab
        self.revert_uses = data.uses or self.revert_uses
        if self.player == nil
            and (data.waittimeremaining ~= nil
                or (data.userid ~= nil and data.userid ~= self.userid)) then
            self:LinkToPlayer(nil)
            self:WaitForPlayer(data.userid, data.waittimeremaining ~= nil and math.max(0, data.waittimeremaining) or nil)
        end
    end
end

function ChosenLancer:GetDebugString()
    return "held: "..tostring(self.currentowner)
        .." player: "..tostring(self.player)
        ..string.format(" timeout: %2.2f", self.waittotime ~= nil and self.waittotime - GetTime() or 0)
end

return ChosenLancer
