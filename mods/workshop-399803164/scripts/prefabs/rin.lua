
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

local prefabs = {
	"amulet",
	"firestaff",
	"redgem",
	"bluegem",
	"purplegem",
	"orangegem",
	"greengem",
	"yellowgem",
	"thulecite",
}


	local start_inv = {
	-- Custom starting items
	"amulet",
	"gandr",
	"papyrus",
	"papyrus",
}

-- This initializes for both clients and the host
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "rin.tex" )	

	inst:AddTag("ancient_builder")
	inst:AddTag("bookbuilder")
	inst:AddTag("insomniac")
	inst:AddTag("rinspecific")
end

-- This initializes for the host only
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "willow"

	-- Stats	
	inst:AddComponent("reader")
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(125)
	inst.components.sanity:SetMax(250)
	
	inst.components.health.SetPenalty = function(self, penalty)
    self.penalty = math.clamp(penalty, 0, 0.25)
	end
	
	inst.components.builder.ancient_bonus = 4
	
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)
		
end

return MakePlayerCharacter("rin", prefabs, assets, common_postinit, master_postinit, start_inv)
