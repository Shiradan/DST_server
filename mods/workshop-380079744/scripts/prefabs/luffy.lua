
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
	Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset( "ANIM", "anim/luffysecondgear.zip" ),
}
local prefabs = {"luffyhat",
}

local start_inv = {
	-- Custom starting items
	"luffyhat",
}

-- This initializes for both clients and the host
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "luffy.tex" )
	inst:AddTag("nofiredamagefromlightning")
	inst:AddTag("luffyspecific")
	inst.transformed = false 
	inst:AddComponent("keyhandler")
    inst.components.keyhandler:AddActionListener("luffy", TUNING.LUFFY.KEYTWO, "SECOND")
end

-- This initializes for the host only
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "wilson"
	-- Stats	
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(300)
	inst.components.sanity:SetMax(150)
	inst.components.health.fire_damage_scale = 2
	inst.components.combat:SetDefaultDamage(50)
	
	-- No damage with weapons
	local _od = inst.components.combat.CalcDamage
	inst.components.combat.CalcDamage = function(self, target, weapon, multiplier)
		if weapon ~= nil then
			multiplier = 0.5
		end
		return _od(self, target, weapon, multiplier)
	end
	
	inst.components.eater.Eat_orig = inst.components.eater.Eat
function inst.components.eater:Eat( food )
	if self:CanEat(food) then
		if food.components.edible.sanityvalue < 0 then
		food.components.edible.sanityvalue = 0
	end
		if food.components.edible.healthvalue < 0 then
		food.components.edible.healthvalue = 10
	end
end
return inst.components.eater:Eat_orig(food)
end

end

return MakePlayerCharacter("luffy", prefabs, assets, common_postinit, master_postinit, start_inv)
