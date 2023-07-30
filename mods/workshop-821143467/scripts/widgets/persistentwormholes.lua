local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Easing = require "easing"

local PersistentWormholes = Class(Widget, function(self)
    Widget._ctor(self, "PersistentWormholes")
	self.owner = ThePlayer

	self.root = self:AddChild(Widget("root"))
	
	self.wormholes = {}
	
	self.offset = {x=0, y=0}
	
	self.repeat_time = 0
	
	self.old_zoom = nil
    
	self.lastpos = nil
	self:StartUpdating()
end)

function PersistentWormholes:AddWormhole(index, pos)
	local icon = self.root:AddChild(Image(MOD_WORMHOLE_ICONS.IMAGES_PATH .. ".xml", "wormhole_" .. math.ceil(index/2) .. ".tex"))
	
	self.wormholes[index] = {icon = icon, pos = pos}
end

-- ####################################################################################################
-- WorldPosToScreenPos and most of the positioning logic based on the mod Waypoint by Nc5xb3
-- ####################################################################################################

function PersistentWormholes:UpdateFromControls(dt)
	
	-- From mapwidget.lua
	if TheInput:IsControlPressed(CONTROL_PRIMARY) then
		local pos = TheInput:GetScreenPosition()
		if self.lastpos then
			local scale = 0.25
			local dx = scale * ( pos.x - self.lastpos.x )
			local dy = scale * ( pos.y - self.lastpos.y )
			self:Offset( dx, dy )
		end
		
		self.lastpos = pos
	else
		self.lastpos = nil
	end
	
	-- From mapscreen.lua
	local s = -100 -- now per second, not per repeat

    if TheInput:IsControlPressed(CONTROL_MOVE_LEFT) then
        self:Offset(-s * dt, 0)
    elseif TheInput:IsControlPressed(CONTROL_MOVE_RIGHT)then
        self:Offset(s * dt, 0)
    end

    if TheInput:IsControlPressed(CONTROL_MOVE_DOWN)then
        self:Offset(0, -s * dt)
    elseif TheInput:IsControlPressed(CONTROL_MOVE_UP)then
        self:Offset(0, s * dt)
    end
end

function PersistentWormholes:OnUpdate(dt)
	if not self.shown then return end
	
	self:UpdateFromControls(dt)

	-- Update position of all map icons 
	for i,v in ipairs(self.wormholes) do
		local wp = v.pos
		local sx,sy = self:WorldPosToScreenPos(wp.x,wp.z)
		v.icon:SetPosition(sx,sy,1/self:GetZoom())
		v.icon:SetScale(MOD_WORMHOLE_ICONS.SCALE - Easing.outQuint(self:GetZoom() - 1, 0, 1, 19) * .75 * MOD_WORMHOLE_ICONS.SCALE)
	end
end

function PersistentWormholes:WorldPosToScreenPos(x,z)
	-- Instead of using TheInput:GetScreenPosition (which is affected by camera smoothing)
	-- TheCamera is used for sharp correct coordinates
	local c = TheCamera.targetpos
	-- Calculate the offset of the target from camera (note: the numbers are angled!)
	local ox = x - c.x
	local oz = z - c.z
	-- Angle offset to correctly translate world angle to screen angle (better if using games constant somewhere)
	local angle = TheCamera:GetHeadingTarget()*DEGREES + PI
	-- Calculate distance and angle
	local wd = math.sqrt(ox*ox + oz*oz)/self:GetZoom()*4.5
	--print("zoom", TheWorld.minimap.MiniMap:GetZoom())
	local wa = math.atan2(ox, oz) + angle
	-- Covert to screen + offset corrdinates
	local screenWidth, screenHeight = TheSim:GetScreenSize()
	local cx = screenWidth*.5 + self.offset.x*4.5
	local cy = screenHeight*.5 + self.offset.y*4.5
	local sx = cx - wd*math.cos(wa)
	local sz = cy + wd*math.sin(wa)
	return sx, sz
end


function PersistentWormholes:GetZoom()
	return TheWorld.minimap.MiniMap:GetZoom()
end

function PersistentWormholes:Offset(dx, dy, ...)
	self.offset.x = self.offset.x + dx
	self.offset.y = self.offset.y + dy
end

function PersistentWormholes:OnShow(...)
	self.offset.x = 0
	self.offset.y = 0
end

-- Handled from MapScreen (hooked from modmain, 70-75)
function PersistentWormholes:OnZoomIn(...)
	local new_zoom = self:GetZoom()
	if self.shown then
		self.offset.x = self.offset.x*self.old_zoom/new_zoom
		self.offset.y = self.offset.y*self.old_zoom/new_zoom
		self.old_zoom = new_zoom
	end
end

-- Handled from MapScreen (hooked from modmain, 77-82)
function PersistentWormholes:OnZoomOut(...)
	local new_zoom = self:GetZoom()
	if self.shown and self.old_zoom < 20 then
		self.offset.x = self.offset.x*self.old_zoom/new_zoom
		self.offset.y = self.offset.y*self.old_zoom/new_zoom
		self.old_zoom = new_zoom
	end
end

return PersistentWormholes
