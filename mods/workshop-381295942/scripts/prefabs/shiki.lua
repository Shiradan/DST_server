
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {
	"knife", "knifethrow"
	
}
local start_inv = {
	-- Custom starting items
	"knife", "knifethrow"
	
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when loading or reviving from ghost (optional)
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 7.5
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)

    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end

-- This initializes for both clients and the host
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "shiki.tex" )
	inst:AddTag("shikispecific")
end


-- This initializes for the host only
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "wendy"
	-- Stats	
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(125)
	inst.components.sanity:SetMax(200)
	inst.components.combat.damagemultiplier = 1.2
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 7.5
	inst.components.temperature.hurtrate = .5
	inst.components.temperature.inherentinsulation = 65
	inst.components.sanity.night_drain_mult = 2
	inst.components.sanity.neg_aura_mult = 0
	
	inst.components.health.SetPenalty = function(self, penalty)
    self.penalty = math.clamp(penalty, 0, 0.5)
	end
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("shiki", prefabs, assets, common_postinit, master_postinit, start_inv)
