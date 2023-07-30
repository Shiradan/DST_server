local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),		
	Asset( "ANIM", "anim/casteryoung.zip" ),
}
local prefabs = {}

-- Custom starting items
local start_inv = {

	"casterstaff",
}

local function updatestats(inst)
	local percent = inst.components.hunger:GetPercent()
	local scale = 1
	
	local moreregen_scale = 1.25
	local minregen_scale = .75
	
	
	if inst.strength == "minregen" then
		local minregen_start = (-.5)	
		local minregen_percent = math.min(minregen_start)
		inst.components.health.absorb = 0.15

		
	elseif inst.strength == "medregen" then
		inst.components.health.absorb = 0.20
		
	elseif inst.strength == "moreregen" then
		local moreregen_start = (.5)
		local moreregen_percent = math.max(moreregen_start)
		inst.components.health.absorb = 0.25
		
	end
end

local function onhungerchange(inst, data)
	if inst.sg:HasStateTag("nomorph") or
        inst:HasTag("playerghost") or
        inst.components.health:IsDead() then
        return
    end
	
	if  inst.components.hunger.current >= 100 then
		if inst.strength == "medregen" then
			inst.strength = "moreregen"
			inst.components.talker:Say("Mm. Let's have some fun.")
		elseif inst.strength == "minregen" then
			inst.strength = "moreregen"
			inst.components.talker:Say("Mm. Let's have some fun.")
		else
			inst.strength = "moreregen"
		end
		
	
		

	elseif  inst.components.hunger.current >= 50 then
        if inst.strength == "moreregen" then
			inst.strength = "medregen"
			inst.components.talker:Say("Just a little bit more energy...")
		elseif inst.strength == "minregen" then
			inst.strength = "medregen"
			inst.components.talker:Say("Just a little bit more energy...")
		else
			inst.strength = "medregen"
		end
	
	
	else
        if inst.strength == "medregen" then
			inst.strength = "minregen"
			inst.components.talker:Say("I require more mana.")
		elseif inst.strength == "moreregen" then
			inst.strength = "minregen"
			inst.components.talker:Say("I require more mana.")
		else
			inst.strength = "minregen"
		end
	
		
	end
			
	updatestats(inst)
end

local function onnewstate(inst)
    if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
        inst._wasnomorph = not inst._wasnomorph
        if not inst._wasnomorph then
            onhungerchange(inst)
        end
    end
end

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when loading or reviving from ghost (optional)
		inst.AnimState:Show("HAIR_HAT")
		inst.components.locomotor.walkspeed = 4
		inst.components.locomotor.runspeed = 6
		
    if inst._wasnomorph == nil then
        inst.strength = "medregen"
        inst._wasnomorph = inst.sg:HasStateTag("nomorph")
        inst.talksoundoverride = nil
        inst.hurtsoundoverride = nil
        inst:ListenForEvent("hungerdelta", onhungerchange)
        inst:ListenForEvent("newstate", onnewstate)
        onhungerchange(inst, nil, true)
    end
end

local function onnewstate(inst)
    if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
        inst._wasnomorph = not inst._wasnomorph
        if not inst._wasnomorph then
            onhungerchange(inst)
        end
    end
end

local function onbecameghost(inst)
    if inst._wasnomorph ~= nil then
        inst.strength = "medregen"
        inst._wasnomorph = nil
        inst.talksoundoverride = nil
        inst.hurtsoundoverride = nil
        inst:RemoveEventCallback("hungerdelta", onhungerchange)
        inst:RemoveEventCallback("newstate", onnewstate)
    end
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)

    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
    inst.AnimState:Show("HAIR_HAT")
end

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "caster.tex" )
	inst:AddTag("caster_builder")
	inst:AddTag("specialassassinowner")
	inst:AddTag("insomniac")
	inst:AddTag("casterspecific")
	inst.transformed = false 
	inst:AddComponent("keyhandler")
    inst.components.keyhandler:AddActionListener("caster", TUNING.CASTER.KEY, "MAGICAL")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "wendy"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(350)
	
	inst.components.health.SetPenalty = function(self, penalty)
    self.penalty = math.clamp(penalty, 0, 0.25)
	end
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1
	
	inst.components.builder.ancient_bonus = 4
	inst.components.builder.magic_bonus = 3
	
	inst:AddComponent("reader")
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst:ListenForEvent("hungerdelta", onhungerchange)
	
    inst:ListenForEvent("equip", function(inst, data)
        print("I'm wearing something.")
        inst.AnimState:ClearOverrideSymbol("swap_hat")
    end)
	
    inst:ListenForEvent("unequip", function(inst, data)
        print("I'm wearing something.")
        inst.AnimState:Show("HAIR_HAT")
    end)
		
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end

return MakePlayerCharacter("caster", prefabs, assets, common_postinit, master_postinit, start_inv)
