
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting items
local start_inv = {
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when loading or reviving from ghost (optional)
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 6
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)

    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end

local mintime = 10

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "archer.tex" )
	inst:AddTag("archerbuilder")
end

local smallScale = 1.2
local medScale = 1.5
local largeScale = 2

local function onkilled(inst, data)
    local victim = data.victim
    if not (victim:HasTag("prey") or
            victim:HasTag("veggie") or
            victim:HasTag("structure")) then
        local delta = victim.components.combat.defaultdamage * 0.25
        inst.components.health:DoDelta(delta, false, "battleborn")
        inst.components.sanity:DoDelta(delta)

        if not victim.components.health.nofadeout and (victim:HasTag("epic") or math.random() < .1) then
            local time = victim.components.health.destroytime or 2
            local x, y, z = victim.Transform:GetWorldPosition()
            local scale = (victim:HasTag("smallcreature") and smallScale)
                        or (victim:HasTag("largecreature") and largeScale)
                        or medScale
        end
    end
end

local function HealthFlux(inst, data)
    local hp = data.newpercent
    if 0.8 < hp then
        inst.components.combat.damagemultiplier = 1.0
    elseif 0.6 < hp and hp <= 0.8 then
        inst.components.combat.damagemultiplier = 1.2
    elseif 0.4 < hp and hp <= 0.6 then
        inst.components.combat.damagemultiplier = 1.3
    elseif 0.2 < hp and hp <= 0.4 then
        inst.components.combat.damagemultiplier = 1.4
    elseif hp <= 0.2 then
        inst.components.combat.damagemultiplier = 1.5
	end
end

local effect_recipes =
{
        "archer_bakuya",
        "archer_celtic",
		"archer_cutlass",
		"archer_excalibur",
		"archer_galientsword",
		"archer_gkatana",
		"archer_gsword",
		"archer_kanshou",
		"archer_katana",
		"archer_kendostick",
		"archer_knife",
		"archer_lawsword",
		"archer_nandao",
		"arhcer_needle",
		"archer_pearlspear",
		"archer_pearlsword",
		"archer_piandao",
		"archer_sandai",
		"archer_sanspear",
		"archer_shusui",
}

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "archer"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(200)
	
	-- Damage multiplier (optional)(Now HealthFlux)
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst.components.health.absorb = 0.25
		
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
	inst:ListenForEvent("killed", onkilled)
	inst:ListenForEvent("healthdelta", HealthFlux)
	
inst.curse_func = function(inst)
                if inst.components.health then
                        inst.components.health:DoDelta(-0.0375 * 0.0001, true, "Curse")
                end
        end
inst.curse_speed = 0.003
 
inst.curse_task = inst:DoPeriodicTask (inst.curse_speed, inst.curse_func )
	
    local old_onenter = inst.sg.sg.states.talk.onenter
    inst.sg.sg.states.talk.onenter = function(inst, noanim)
        old_onenter(inst, noanim)
        inst.sg:SetTimeout(mintime + math.random() * 0.5)
    end
		
local _DoBuild = inst.components.builder.DoBuild
inst.components.builder.DoBuild = function( self, recname, pt, rotation, skin )
        if self.inst.components.sanity.current < 85 then
                return false
        end
		
	-- If you want it only on specific recipes
	for _, v in pairs(effect_recipes) do
			if recname == v then
					local effect = SpawnPrefab("mossling_spin_fx").entity:AddFollower():FollowSymbol(inst.GUID, "swap_body", 0, 0, 0)
			end
	end
	
        return _DoBuild(self, recname, pt, rotation, skin)
end

end

return MakePlayerCharacter("archer", prefabs, assets, common_postinit, master_postinit, start_inv)
