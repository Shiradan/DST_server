local ItemSlot = require "widgets/itemslot"

local function SendCommand(fnstr)
	local x, y, z = TheSim:ProjectScreenPos(TheSim:GetPosition())
	local is_valid_time_to_use_remote = TheNet:GetIsClient() and TheNet:GetIsServerAdmin()
	if is_valid_time_to_use_remote then
		TheNet:SendRemoteExecute(fnstr, x, z)
	else
		ExecuteConsoleCommand(fnstr)
	end
end

local InvSlot = Class(ItemSlot, function(self, num, atlas, bgim, owner, container)
	ItemSlot._ctor(self, atlas, bgim, owner)
	self.owner = owner
	self.container = container
	self.num = num
end)

function InvSlot:OnControl(control, down)
	if InvSlot._base.OnControl(self, control, down) then return true end

	if down then

		if control == CONTROL_ACCEPT then
			self:Click(false)
		elseif control == CONTROL_SECONDARY then
			self:Click(true)
		end

		return true
	end

end

function InvSlot:Click(stack_mod)
	local character = ThePlayer
	local slot_number = self.num
	local container = self.container
	local container_item = container[slot_number]

	if container_item then
		if self.owner.whichlistuse == 7 then
			local fnstr = 'local x,y,z = ThePlayer.Transform:GetWorldPosition() DebugSpawn("'..container_item..'").Transform:SetPosition(x,y,z)'
			SendCommand(fnstr)
			print(container_item)
		else
			if stack_mod then
				local fnstr = "c_give("..'"'..container_item..'",'..TooManyItems_TMI_R_CLICK_NUM..")"
				SendCommand(fnstr)
			else
				local fnstr = "c_give("..'"'..container_item..'",'..TooManyItems_TMI_L_CLICK_NUM..")"
				SendCommand(fnstr)
			end
		end
		TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/click_object")
	end

end

return InvSlot
