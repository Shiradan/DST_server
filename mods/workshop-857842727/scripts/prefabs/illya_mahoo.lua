
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

        Asset( "ANIM", "anim/illya_mahoo.zip" ),
        Asset( "ANIM", "anim/ghost_illya_mahoo_build.zip" ), --注意注意
		
		Asset( "ATLAS", "images/illya_mahootab.xml" ),
		
		Asset( "ATLAS", "images/z_illya.xml" ),
		Asset( "ATLAS", "images/x_illya.xml" ),
	
}
local prefabs = {}

-- Custom starting items
--此处添加物品
local start_inv = {
	"illya_rubystar",
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when loading or reviving from ghost (optional)
	inst.components.locomotor.walkspeed = 5
	inst.components.locomotor.runspeed = 7
	inst.Transform:SetScale(1, 1, 1)
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)

    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end

local function applyupgrades(inst)

	local max_upgrades = 18
	local upgrades = math.min(inst.level, max_upgrades)

	local hunger_percent = inst.components.hunger:GetPercent()
	local health_percent = inst.components.health:GetPercent()
	local sanity_percent = inst.components.sanity:GetPercent()

	inst.components.hunger.max = math.ceil (80 + (upgrades * 1)) --98
	inst.components.health.maxhealth = math.ceil (50 + (upgrades * 2)) --136
	inst.components.sanity.max = math.ceil (150 + (upgrades * 10)) --227
	if upgrades <= 5 then
		inst.Mag_Power = math.ceil (15 + (upgrades * 7))
	else
		if 5 < upgrades and upgrades <= 11 then
			inst.Mag_Power = math.ceil (15 + (upgrades* 10))
		else
			if  11 < upgrades then
				inst.Mag_Power = math.ceil (15 + (upgrades* 15))
			end
		end
	end

	


	inst.components.hunger:SetPercent(hunger_percent)
	inst.components.health:SetPercent(health_percent)
	inst.components.sanity:SetPercent(sanity_percent)	
end

local function oneat(inst, food) 
    if food and food.components.edible and food.prefab == "durian" or food.prefab == "durian_cooked"  then
        inst.L_xp = inst.L_xp + 1
		if inst.L_xp ==  inst.level + 2 and  inst.level <= 17 then
		inst.L_xp = 0
        inst.level = inst.level + 1
        applyupgrades(inst) 
        inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
		inst.components.talker:Say("level up")
        -- MarkL Can't do this here, need to do it inside the component
        -- todo pax Move upgrade logic elsewhere.  
        --inst.HUD.controls.status.heart:PulseGreen()
        --inst.HUD.controls.status.stomach:PulseGreen()
        --inst.HUD.controls.status.brain:PulseGreen()

        --inst.HUD.controls.status.brain:ScaleTo(1.3,1,.7)
        --inst.HUD.controls.status.heart:ScaleTo(1.3,1,.7)
        --inst.HUD.controls.status.stomach:ScaleTo(1.3,1,.7)
		end
    end
end
local function onsave(inst, data)
	data.L_xp = inst.L_xp
    data.level = inst.level
	data.suffering = inst.suffering
    --data.charge_time = inst.charge_time > 0 and inst.charge_time or nil
end

local function onpreload(inst, data)
	if data then
		if data.level and data.L_xp then
			inst.L_xp = data.L_xp
			inst.level = data.level
			applyupgrades(inst)
			--re-set these from the save data, because of load-order clipping issues
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			if data.hunger and data.hunger.hunger then inst.components.hunger.current = data.hunger.hunger end
			if data.sanity and data.sanity.current then inst.components.sanity.current = data.sanity.current end
			inst.components.health:DoDelta(0)
			inst.components.hunger:DoDelta(0)
			inst.components.sanity:DoDelta(0)
		end
	end
	if inst.components.temperature then
		inst.components.temperature.inherentinsulation = 150
	end 
end
-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "illya_mahoo.tex" )       --主义修改图标
	inst:AddTag("mahoohoujyou")
	inst:AddTag("little")
	inst:AddTag("illya_magi")
	inst:AddTag("illya_mahoo")
	inst.transformed = false 
	inst:AddComponent("keyhandler_illya_mahoo")  --注意注意
    inst.components.keyhandler_illya_mahoo:AddActionListener("illya_mahoo", KEY_Z, "z_skill")
	inst.components.keyhandler_illya_mahoo:AddActionListener("illya_mahoo", KEY_X, "x_skill")
	
	inst:AddComponent("timer")
	inst:ListenForEvent("timerdone", function(inst, data)
	--技能冷却好时

		if data.name == "z_skill" then	
			inst.z_skill = true
		elseif data.name == "x_skill" then
			inst.x_skill = true
		end
	end)
	inst.z_skill_cd = 30
	inst.x_skill_cd = 60
	inst.z_skill_cd2 = 1
	

	if not (inst.z_skill or inst.components.timer:TimerExists("z_skill")) then
	if not (TUNING.illya_status == "mahoo")  then
		inst.components.timer:StartTimer("z_skill", inst.z_skill_cd)
		else
		inst.components.timer:StartTimer("z_skill", inst.z_skill_cd2)
		end
	end
	if not (inst.x_skill or inst.components.timer:TimerExists("x_skill")) then
		inst.components.timer:StartTimer("x_skill", inst.x_skill_cd)
	end
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play

	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(50)
	inst.components.hunger:SetMax(80)
	inst.components.sanity:SetMax(150)
	inst.Transform:SetScale(1, 1, 1)
	inst.soundsname = "illya_mahoo"
	

    inst.components.eater:SetOnEatFn(oneat)
		--回蓝速度
	inst:DoPeriodicTask(15, function()
		if not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
			inst.components.sanity:DoDelta(TUNING.magic_regene + 0.2*math.min(inst.level, 18))

		end
	end)
	inst.components.combat.damagemultiplier = 0.5
	inst.components.health.absorb = 0
	inst.components.temperature.mintemp = -20
	inst.components.temperature.maxtemp = 90
	inst.L_xp = 0
	inst.level = 0
	inst.Mag_Power = 15
	inst.Mag_Power2 = 0
	inst.illya_weapon_ok = 0
	inst.illya_amulet = 0
	applyupgrades(inst)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	inst:ListenForEvent("death", function(inst) inst.transformed = not inst.transformed end)
	inst:ListenForEvent("healthdelta", function(inst, data) 
	local amulet = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
	local amount_L = data.amount
	if inst.illya_amulet == 1  and amount_L < 0 and data.cause ~="battle_ring" then
	amulet.components.armor:SetCondition(10000000)
	--inst.components.health:SetVal(inst.components.health.currenthealth + amount_L)
	local amount_L_c = amount_L * 5
	inst:DoTaskInTime(0.2,inst.components.health:DoDelta(0.2*(1 - inst.components.sanity:GetPercent()) * amount_L_c - amount_L),{cause = "battle_ring"})
	end
	end)
	inst.OnSave = onsave
    inst.OnPreLoad = onpreload
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end

return MakePlayerCharacter("illya_mahoo", prefabs, assets, common_postinit, master_postinit, start_inv)
