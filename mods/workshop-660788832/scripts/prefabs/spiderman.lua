
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = 
{
}

local start_inv = {
	"spidereggsack",
	"spidereggsack",
	"spidereggsack",
	"spidergland",
	"spidergland",
	"spidergland",
	"spidergland",
	"shield",
}

local MONSTERVISION_COLOURCUBES =
{
    day = "images/colour_cubes/beaver_vision_cc.tex",
    dusk = "images/colour_cubes/beaver_vision_cc.tex",
    night = "images/colour_cubes/beaver_vision_cc.tex",
    full_moon = "images/colour_cubes/beaver_vision_cc.tex",
}

local function onbecamehuman(inst)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "spiderman_speed_mod", 2)
end

local function onbecameghost(inst)
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "spiderman_speed_mod", 2)
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

local function NightVision(inst)
	if not TheWorld.state.isday then
		inst.components.playervision:ForceNightVision(true)
        inst.components.playervision:SetCustomCCTable(MONSTERVISION_COLOURCUBES)
    else
        inst.components.playervision:ForceNightVision(false)
        inst.components.playervision:SetCustomCCTable(nil)
end
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "spiderman.tex" )
	
	inst:AddTag("spiderwhisperer")
	inst:AddTag(UPGRADETYPES.SPIDER.."_upgradeuser")
	
	inst:AddTag("woodcutter")
	inst:AddTag("spiderman_builder")
	inst:WatchWorldState("startnight", NightVision)
	inst:WatchWorldState("startday", NightVision)
end

local master_postinit = function(inst)

	inst.soundsname = "spiderman"
	
	inst.components.health:SetMaxHealth(TUNING.SPIDERMAN_BASE_HP)
	inst.components.hunger:SetMax(TUNING.SPIDERMAN_HUNGER)
	inst.components.sanity:SetMax(TUNING.SPIDERMAN_SANITY)
	
	--inst.components.health:SetMaxHealth(200)
	--inst.components.hunger:SetMax(200)
	--inst.components.sanity:SetMax(150)	
	inst.components.hunger:SetRate(TUNING.SPIDERMAN_HUNGER_RATE)
	
	-- Damage multiplier
    inst.components.combat.damagemultiplier = (TUNING.SPIDERMAN_DAMAGE)
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("spiderman", prefabs, assets, common_postinit, master_postinit, start_inv)
