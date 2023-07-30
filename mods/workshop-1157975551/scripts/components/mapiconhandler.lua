local Handler = Class(function(self, inst)
    self.inst = inst
    self.helper = SpawnPrefab("mapiconhelper")

    local pos = inst:GetPosition()
    self.old_pos = pos
    self.helper.Transform:SetPosition(pos.x, pos.y, pos.z)

    self.inst:StartUpdatingComponent(self)
end)

function Handler:OnRemoveEntity()
    self.inst:StopUpdatingComponent(self)
    self.helper:Remove()
end

function Handler:OnUpdate(dt)
    if (self.inst.components.inventoryitem and self.inst.components.inventoryitem:IsHeld()) then
		self.helper.Transform:SetPosition(999999, 999999, 0)
	else
		local pos = self.inst:GetPosition()
		local old_pos = self.old_pos

		if pos.x ~= old_pos.x or pos.y ~= old_pos.y or pos.z ~= old_pos.z then
			self.old_pos = pos
			self.helper.Transform:SetPosition(pos.x, pos.y, pos.z)
		end
	end
end

return Handler
