local Mag_Power = Class(function(self,inst)
	self.inst = inst
	self.currentpower = 0
	end,
	nil,
	)
function Mag_Power:OnSave()   
    return
    {
        Mag_Power = self.currenthealth,
    }
end

function Mag_Power:OnLoad(data)
	self.currentpower = data.Mag_Power
end

return Mag_Power