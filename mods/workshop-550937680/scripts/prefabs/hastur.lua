
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {

        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),

        Asset( "ANIM", "anim/hastur.zip" ),
        Asset( "ANIM", "anim/ghost_hastur_build.zip" ),
}
local prefabs = {}

-- Custom starting items
local start_inv = {
	"nightsword",
}

local smallScale = 1.0
local medScale = 1.5
local largeScale = 2.0

local function onkill(inst, data)
	if data.afflicter == inst 
		and not data.inst:HasTag("veggie") 
		and not data.inst:HasTag("structure") then
		local delta = (data.inst.components.combat.defaultdamage) * 0.25
 		if data.inst:HasTag("player") then delta = TUNING.WILSON_HEALTH * 0.15 end
		inst.components.health:DoDelta(delta, false, "battleborn")
        inst.components.sanity:DoDelta(delta)

	inst.components.hunger:DoDelta(delta * 2)

        if math.random() < .1 and not data.inst.components.health.nofadeout then
        	local time = data.inst.components.health.destroytime or 2
        	inst:DoTaskInTime(time, function()
        		local s = medScale
        		if data.inst:HasTag("smallcreature") then
        			s = smallScale
    			elseif data.inst:HasTag("largecreature") then
    				s = largeScale
    			end
    		end)
        end

	end
end


-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when loading or reviving from ghost (optional)
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 6
	inst.Light:Enable(true)
	inst.Light:SetRadius(5)
	inst.Light:SetFalloff(.2)
	inst.Light:SetIntensity(.2)
	inst.AnimState:OverrideMultColour(1, 1, 1, 0.7)
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)

    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "hastur.tex" )
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "hastur"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(200)
	inst.components.sanity:SetMax(150)
	inst.Light:Enable(true)
	inst.Light:SetRadius(5)
	inst.Light:SetFalloff(.2)
	inst.Light:SetIntensity(.2)
	inst.Light:SetColour(255/255,250/255,205/255)
	inst.AnimState:OverrideMultColour(1, 1, 1, 0.7)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1.25
	inst.components.health:SetAbsorptionAmount(.25)
	inst:AddComponent("healthRegen")
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	--Nudey Beach
	inst:ListenForEvent("equip", function()
		inst.AnimState:ClearOverrideSymbol("swap_hat")
		inst.AnimState:Show("hair")
		inst.AnimState:ClearOverrideSymbol("swap_body")
	end)
	
	--Unique Sanity Stuff
	inst.components.sanity.night_drain_mult = ( TUNING.WENDY_SANITY_MULT * -3 ) --Regen Sanity At Night
	inst.components.sanity.dapperness = (-TUNING.DAPPERNESS_MED) --Leak Sanity at day
	inst.components.eater:SetDiet({FOODGROUP.HORRIBLE})
	inst:ListenForEvent("entity_death", function(wrld, data) onkill(inst, data) end, TheWorld)
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end

return MakePlayerCharacter("hastur", prefabs, assets, common_postinit, master_postinit, start_inv)
