
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = 
{
}

local start_inv = {
	"katanas",
	"dppda",
	"dpgun",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpclip",
	"dpbomb",
	"dpbomb",
	"dpbomb",
}

local function onbecamehuman(inst)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "deadpool_speed_mod", 1.2)
end

local function onbecameghost(inst)
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "deadpool_speed_mod", 1.2)
end

local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "deadpool.tex" )
	
	inst:AddTag("deadpool_builder")
end

local master_postinit = function(inst)

	inst.soundsname = "deadpool"
	
	inst.components.health:SetMaxHealth(TUNING.DEADPOOL_BASE_HP)
	inst.components.hunger:SetMax(TUNING.DEADPOOL_HUNGER)
	inst.components.sanity:SetMax(TUNING.DEADPOOL_SANITY)
	
	--inst.components.health:SetMaxHealth(200)
	--inst.components.hunger:SetMax(200)
	--inst.components.sanity:SetMax(150)	
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
	
	-- Health regen
	inst.components.health:StartRegen(TUNING.DEADPOOL_HP_Regen,1)
	
	-- Damage multiplier
    inst.components.combat.damagemultiplier = (TUNING.DEADPOOL_DAMAGE)
	
	--Not afraid of monsters
	inst.components.sanity.neg_aura_mult = 0
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("deadpool", prefabs, assets, common_postinit, master_postinit, start_inv)
