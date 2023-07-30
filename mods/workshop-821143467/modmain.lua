local DST = GLOBAL.TheSim:GetGameID() == "DST"
if not DST then return end
if DST and GLOBAL.TheNet:IsDedicated() then return end

local require = GLOBAL.require

local PersistentData = require "persistentdata"
local PersistentWormholes = require "widgets/persistentwormholes"

local Vector3 = GLOBAL.Vector3
local FindEntity = GLOBAL.FindEntity

local DISPLAY_NUMBERS = GetModConfigData("DISPLAY_NUMBERS")

local ImagesPath
if DISPLAY_NUMBERS == true then
	ImagesPath = "images/mod_wormhole_num"
else
	ImagesPath = "images/mod_wormhole_base"
end

GLOBAL.MOD_WORMHOLE_ICONS = {}
GLOBAL.MOD_WORMHOLE_ICONS.SCALE = GetModConfigData("SCALE")
GLOBAL.MOD_WORMHOLE_ICONS.IMAGES_PATH = ImagesPath

Assets = 
{
	Asset("IMAGE", ImagesPath .. ".tex"),
	Asset("ATLAS", ImagesPath .. ".xml"),
}
AddMinimapAtlas(ImagesPath .. ".xml")

local WORMHOLE_NUM = 10
local INDEX = 1
local MarkedWormholesPositions = {}

-------------------------------------------------------------------------------------------------------------------------------------

local UniqueID = "mod_wormholeicons"
local DataContainer = PersistentData(UniqueID)

local function SaveMarkedWormholesPositions()
	local s_list = {}
	for i,v in ipairs(MarkedWormholesPositions) do
		s_list[i] = {x = v.x, y = v.y, z = v.z}
	end
	DataContainer:SetValue("world_" .. GLOBAL.TheWorld.meta.seed, s_list)
	
	
	DataContainer:Save()
	-- Saved!
end

local function LoadMarkedWormholesPositions()
	DataContainer:Load()
	
	
	local s_list = DataContainer:GetValue("world_" .. GLOBAL.TheWorld.meta.seed)
	if s_list then
		for i,v in ipairs(s_list) do
			MarkedWormholesPositions[i] = Vector3(v.x, v.y, v.z)
			INDEX = math.floor(i/2) + 1
		end
	end
	-- Loaded!
end


AddClassPostConstruct("screens/mapscreen", function(self)
	
	self.persistentwormholes = self:AddChild(PersistentWormholes())
	
	--[[local oldOffset = self.minimap.Offset
	self.minimap.Offset = function(mapwidget, dx, dy, ...)
		oldOffset(mapwidget, dx, dy, ...)
		self.persistentwormholes:Offset(dx, dy, ...)
	end]]--
	
	local oldOnZoomIn = self.minimap.OnZoomIn
	self.minimap.OnZoomIn = function(...)
		self.persistentwormholes.old_zoom = GLOBAL.TheWorld.minimap.MiniMap:GetZoom()
		oldOnZoomIn(self.minimap, ...)
		self.persistentwormholes:OnZoomIn(...)
	end
	
	local oldOnZoomOut = self.minimap.OnZoomOut
	self.minimap.OnZoomOut = function(...)
		self.persistentwormholes.old_zoom = GLOBAL.TheWorld.minimap.MiniMap:GetZoom()
		oldOnZoomOut(self.minimap, ...)
		self.persistentwormholes:OnZoomOut(...)
	end
	
	if not GLOBAL.TheWorld:HasTag("cave") then
		for i,v in ipairs(MarkedWormholesPositions) do
			self.persistentwormholes:AddWormhole(i, MarkedWormholesPositions[i])
		end
	end
end)

AddSimPostInit(function(inst)
	LoadMarkedWormholesPositions()
end)

-----------------------------------------------------------------------------------------------------------------------

local function SetMinimapIcon(inst, index)
	if inst.MiniMapEntity == nil then 
		inst.entity:AddMiniMapEntity() 
		inst.AnimState:SetLayer(LAYER_BACKGROUND)
		inst.AnimState:SetSortOrder(3)
	end
	
	inst.MiniMapEntity:SetIcon("wormhole_" .. index .. ".tex")
end

local function IsWormhole(inst)
	return inst and inst.prefab == "wormhole" or false
end

local function GetWormholeFromPos(pos)
	local ents = GLOBAL.TheSim:FindEntities(pos.x, pos.y, pos.z, 1)
	for i, v in ipairs(ents) do
		if IsWormhole(v) then
			return v
		end
	end
end

local function IsSameWormhole(wormhole, pos)
	return wormhole == GetWormholeFromPos(pos)
end

local function IsWormholeMarked(wormhole)
	for _, pos in pairs(MarkedWormholesPositions) do
		if IsSameWormhole(wormhole, pos) then
			-- Wormhole is marked
			return true
		end
	end
	-- Wormhole isn't marked
	return false
end


local function IsWormholeAvailable(guy)
	return guy and IsWormhole(guy) and IsWormholeMarked(guy) == false or false
end

local function LookForExit(inst)
	local worm_exit = FindEntity(inst, 5,IsWormholeAvailable)
	
	if worm_exit then
		SetMinimapIcon(worm_exit, INDEX)
		INDEX = INDEX + 1
		table.insert(MarkedWormholesPositions, worm_exit:GetPosition())
		SaveMarkedWormholesPositions()
		inst.look_for_wormhole:Cancel()
		inst.look_for_wormhole = nil
	end
end

local function StopLookingForExit(inst)
	if inst.look_for_wormhole then
		inst.look_for_wormhole:Cancel()
		inst.look_for_wormhole = nil
		inst.MiniMapEntity:SetIcon("wormhole.png") -- Reset the icon to default
		
		table.remove(MarkedWormholesPositions)
		SaveMarkedWormholesPositions()
	end
end

local function GetIndexValue(inst)
	for k, v in pairs(MarkedWormholesPositions) do
		if IsSameWormhole(inst, v) then
			return math.ceil(k/2)
		end
	end
	return nil
end


AddPrefabPostInit("wormhole", function(inst)
	inst:DoTaskInTime(0.1, function(inst)
		if IsWormholeMarked(inst) then
			-- Setting previously marked wormhole minimap icon
			SetMinimapIcon(inst, GetIndexValue(inst))
		end
	end)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	
end)


AddStategraphPostInit("wilson_client", function(sg)

	local old_onenter = sg.states.jumpin.onenter
	
	sg.states.jumpin.onenter = function(inst)
		if INDEX <= WORMHOLE_NUM then 
			local worm_entrance = FindEntity(inst, 5, IsWormholeAvailable)
			
			if worm_entrance then
				SetMinimapIcon(worm_entrance, INDEX)
				table.insert(MarkedWormholesPositions, worm_entrance:GetPosition())
				SaveMarkedWormholesPositions()
			
				inst.look_for_wormhole = inst:DoPeriodicTask(0.5, LookForExit)
				inst:DoTaskInTime(8, StopLookingForExit)
			end
		end
		
		return old_onenter(inst)
	end
	
end)
