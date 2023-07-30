local MakePlayerCharacter = require "prefabs/player_common"
--人物都加

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset("SOUNDPACKAGE","sound/music_okita.fev"),
	Asset("SOUND","sound/music_okita.fsb"),
	Asset( "ANIM", "anim/player_teleport.zip" ),
    Asset( "ANIM", "anim/wilson_fx.zip" ),
    Asset( "ANIM", "anim/player_one_man_band.zip" ),
    Asset( "ANIM", "anim/shadow_hands.zip" ),
    Asset( "SOUND", "sound/sfx.fsb" ),
    Asset( "SOUND", "sound/wilson.fsb" ),
    Asset( "ANIM", "anim/beard.zip" ),
	Asset("ANIM", "anim/staffs.zip"),
	--要引用的素材，声音文件，动画文件等
}

--要加载使用的本地预制物（prefab）
local prefabs = {
	"okitasword","symbol","pred",
}

-- Custom starting items
-- 初始自带物品
local start_inv = {
	"spear","dogfood","dogfood","dogfood","dogfood","dogfood",
}


local function value(inst) 
	--等级
	local lv = inst.components.okitastatus.level

    --饥饿判定
	local hunger_percent = inst.components.hunger:GetPercent()
	inst.components.hunger.max = 100 + lv*1.5
	inst.components.hunger:SetPercent(hunger_percent)

	--脑力判定
	local sanity_percent = inst.components.sanity:GetPercent()
	inst.components.sanity.max = 100 + lv*1.5
	inst.components.sanity:SetPercent(sanity_percent)
	
	--血量判定
	local health_percent = inst.components.health:GetPercent()
	inst.components.health.maxhealth = 60 + lv*2
	inst.components.health:SetPercent(health_percent)

	--最高exp判定
	inst.components.okitastatus.maxexp = lv * 100 + 100

	--速度计算
	inst.components.locomotor.walkspeed = inst.components.okitastatus.speedwalk
	inst.components.locomotor.runspeed = inst.components.okitastatus.speedrun
end


--升级function
local function levelup(inst)
	inst.components.okitastatus.level = inst.components.okitastatus.level + 1
	--gai
	inst.SoundEmitter:PlaySound("music_okita/music_okita/levelup")
	inst.components.talker:Say("Master~ ! Level UP!")
	value(inst)
	inst.components.health:DoDelta(inst.components.health.maxhealth/5)
end


--杀怪function
local function onkilledother(inst, data)
    local victim = data.victim
	--杀怪得经验
	if victim.components.freezable or victim:HasTag("monster") and victim.components.health then
		local value = math.ceil(victim.components.health.maxhealth)
		inst.components.okitastatus:DoDeltaExp(value)
	end
	--杀怪掉狗粮功能
	if victim.components.lootdropper then
		if victim.components.freezable or victim:HasTag("monster") then
		    if math.random(1, 90) <= inst.components.okitastatus.level then
				--prefab.components.lootdropper:AddChanceLoot('dogfood',1)
				-- victim.components.lootdropper:AddChanceLoot('dogfood',1)
				-- victim.components.lootdropper:DropLoot()
				local food  = SpawnPrefab("dogfood")
				food.Transform:SetPosition(victim.Transform:GetWorldPosition())
	        end
		end
	end
end

--人物基本都写的
local function onbecamehuman(inst)
	value(inst)
end

--人物基本都写的
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end

--吃东西升级 吃什么 调用经验升级方法
local function oneat(inst, food) 
	if food and food.components.edible then
		if food.prefab == "dogfood"
			or food.prefab == "drumstick_cooked"
			then
			inst.components.okitastatus:DoDeltaExp(1000)
			inst.components.talker:Say("exp:1000++")
			inst.components.sanity:DoDelta(20)
		end
	end
end

--经验方法
local function DoDeltaExpOkita(inst)
	if inst.components.okitastatus.exp >= inst.components.okitastatus.maxexp then
		levelup(inst)
		local expnew = inst.components.okitastatus.exp - inst.components.okitastatus.maxexp
		inst.components.okitastatus.exp = 0
		if expnew > 0 then
			inst.components.okitastatus:DoDeltaExp(expnew)
		end
	end
end




--色卡模式
local function powerready(inst)
	--手上没东西返回
	if not inst.components.inventory.equipslots[EQUIPSLOTS.HANDS] then 
		return
	end
	local item = inst.components.inventory.equipslots[EQUIPSLOTS.HANDS].prefab
	--东西不是专属的剑返回
	if item == "okitasword" then
	
		inst.components.okitastatus.power = 1
		--随机数指定5色卡 和各自效果
		--red
		local num = math.random(1,5)
		if num == 1 or num ==2 then 
		
		inst.okitafx = SpawnPrefab("pred")
		inst.okitafx.Transform:SetPosition(inst.Transform:GetWorldPosition())
		
		inst.powerfx = SpawnPrefab("lighterfire_red")
		inst.powerfx.entity:AddFollower()
	    inst.powerfx.Follower:FollowSymbol(inst.GUID, "swap_object", 0, -360, 0)
		inst.SoundEmitter:PlaySound("music_okita/music_okita/hit3")
		
		local startest = math.random(0,9)
			if startest<inst.components.okitastatus.star then
				inst.components.combat.damagemultiplier = 2.8 + inst.components.okitastatus.level*5/200 + inst.components.okitastatus.criticalbuff
				inst.components.okitastatus.star = 0
				inst.components.talker:Say("critical!")
			else
				inst.components.combat.damagemultiplier = 1.4 + inst.components.okitastatus.level*5/200  --100
				inst.components.okitastatus.star = 0
			end
		end

		if num == 3 then 
		
		inst.okitafx = SpawnPrefab("pblue")
		inst.okitafx.Transform:SetPosition(inst.Transform:GetWorldPosition())
		
		inst.powerfx = SpawnPrefab("lighterfire_green")
		inst.powerfx.entity:AddFollower()
	    inst.powerfx.Follower:FollowSymbol(inst.GUID, "swap_object", 0, -360, 0)
		inst.SoundEmitter:PlaySound("music_okita/music_okita/hit1")
		
		local startest = math.random(0,9)
			if startest<inst.components.okitastatus.star then
				inst.components.combat.damagemultiplier = 2.4 + inst.components.okitastatus.level*5/200 + inst.components.okitastatus.criticalbuff
				inst.components.okitastatus.star = 0
				inst.components.okitastatus.np = inst.components.okitastatus.np + 8.7
				inst.components.talker:Say("critical!".."np:"..(inst.components.okitastatus.np).."%")
			else
				inst.components.combat.damagemultiplier = 1.2  --80
				inst.components.okitastatus.np = inst.components.okitastatus.np + 4.35
				inst.components.talker:Say("np"..":"..(inst.components.okitastatus.np).."%")
				inst.components.okitastatus.star = 0
			end
				
		end
		
		--green
		if num == 5 or num == 4 then 
		inst.okitafx = SpawnPrefab("pgreen")
		inst.okitafx.Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst.powerfx = SpawnPrefab("lighterfire_shadow")
		inst.powerfx.entity:AddFollower()
	    inst.powerfx.Follower:FollowSymbol(inst.GUID, "swap_object", 0, -360, 0)
		inst.SoundEmitter:PlaySound("music_okita/music_okita/hit2")
		--star
		local starnum = math.random(3,10)
		inst.components.okitastatus.star = starnum
		
		
			if inst.components.okitastatus.star ~= 0 then
				local startest = math.random(0,9)
				if startest<inst.components.okitastatus.star then
					local starnum = math.random(3,10)
					--inst.components.okitastatus.star = math.ceil(2*starnum,10)
					if 2*starnum<10 then 
					inst.components.okitastatus.star = 2*starnum
					else
					inst.components.okitastatus.star = 10
					end
					inst.components.combat.damagemultiplier = (2+inst.components.okitastatus.level*5/200 + inst.components.okitastatus.criticalbuff)*(1+ inst.components.okitastatus.greenbuff)
					inst.components.talker:Say("Critical!".."star:"..(inst.components.okitastatus.star))
				else
					inst.components.talker:Say("star"..":"..(inst.components.okitastatus.star))
					inst.components.combat.damagemultiplier = (1+inst.components.okitastatus.level*5/200) *(1+ inst.components.okitastatus.greenbuff)
				end
			end
		end
		

	end

end



local function hitother(inst)
	--baojuhit
	if inst.components.okitastatus.power == 1 and inst.components.okitastatus.baojuatk == 1 and inst.components.combat.target and inst.components.combat.target:IsValid() then
		if inst.components.rider:IsRiding() then return end
		inst.components.okitastatus.power = 0
		inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
	    SpawnPrefab("lightning_rod_fx").Transform:SetPosition(inst.components.combat.target.Transform:GetWorldPosition())
		SpawnPrefab("lightning_rod_fx").Transform:SetPosition(inst.components.combat.target.Transform:GetWorldPosition())
		SpawnPrefab("lightning_rod_fx").Transform:SetPosition(inst.components.combat.target.Transform:GetWorldPosition())
	    inst.powerfx:Remove()
		
		if inst.okitafx ~=nil then 
		inst.okitafx:Remove()
		end
		
			inst.freshfx = SpawnPrefab("lightning_rod_fx")
		    inst.freshfx.Transform:SetPosition(inst.Transform:GetWorldPosition())
		    inst.spellfx1 = SpawnPrefab("positronbeam_front")
		    inst.spellfx2 = SpawnPrefab("lightning_rod_fx")
		    inst.spellfx3 = SpawnPrefab("lightning_rod_fx")
		    inst.spellfx4 = SpawnPrefab("lightning_rod_fx")
		    inst.spellfx5 = SpawnPrefab("lightning_rod_fx")
		    inst.spellfx1.entity:SetParent(inst.freshfx.entity)
		    inst.spellfx2.entity:SetParent(inst.freshfx.entity)
		    inst.spellfx3.entity:SetParent(inst.freshfx.entity)
		    inst.spellfx4.entity:SetParent(inst.freshfx.entity)
		    inst.spellfx5.entity:SetParent(inst.freshfx.entity)
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.components.combat.damagemultiplier = 1
		inst:DoTaskInTime(2.5, function()
		inst.freshfx:Remove()
		end)
		if inst.components.hunger.current <= 0 then
        	inst.components.health:DoDelta(-2)
        end
		inst.components.okitastatus.baojuatk = 0
		inst.components.hunger:DoDelta(-2)			
	end
	

	if inst.components.okitastatus.power == 1 and inst.components.combat.target and inst.components.combat.target:IsValid() then
		if inst.components.rider:IsRiding() then return end
		inst.components.okitastatus.power = 0
		inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
	    SpawnPrefab("pphit").Transform:SetPosition(inst.components.combat.target.Transform:GetWorldPosition())
	    inst.powerfx:Remove()
	    --inst.fxout = SpawnPrefab("deer_fire_burst") "firesplash_fx"
		inst.fxout = SpawnPrefab("pstar")
		inst.fxout.entity:SetParent(inst.entity)
		inst.fxout.entity:AddFollower()
    	inst.fxout.Follower:FollowSymbol(inst.GUID, "swap_body", 0, 0, 0)
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.components.combat.damagemultiplier = 1
		if inst.components.hunger.current <= 0 then
        	inst.components.health:DoDelta(-2)
        end
		inst.components.hunger:DoDelta(-2)			
	end
	
end

local function unequip(inst,data)
	if inst.components.okitastatus.power == 1 and data.eslot == EQUIPSLOTS.HANDS then
		inst.powerfx:Remove()
		inst.fxout = SpawnPrefab("deer_fire_burst")
		inst.fxout.entity:SetParent(inst.entity)
		inst.fxout.entity:AddFollower()
    	inst.fxout.Follower:FollowSymbol(inst.GUID, "swap_body", 0, 0, 0)
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.components.okitastatus.power = 0
		inst.components.combat.damagemultiplier = 1
	end
end

local function deletefx(inst)
	if inst.freshfx then
		SpawnPrefab("lightning").Transform:SetPosition(inst.freshfx.Transform:GetWorldPosition())
		SpawnPrefab("explode_small").Transform:SetPosition(inst.freshfx.Transform:GetWorldPosition())
		inst.freshfx:Remove()
	end
end



local function spelldone(inst,data)
	inst:DoTaskInTime(0.1, function()
	if not inst.components.inventory.equipslots[EQUIPSLOTS.HANDS] then 
		return
	end
	local item = inst.components.inventory.equipslots[EQUIPSLOTS.HANDS].prefab
	if item ~= "okitasword" then
		return
	end
	if inst.components.okitastatus.np > 99 then 
		inst.components.okitastatus.baoju =1
		inst.components.okitastatus.np = 0
	end
	
	if inst.components.okitastatus.baoju == 0 then
		return
	end
	if inst.powerfx ~=nil then
		inst.powerfx:Remove()
	end
	
		inst.components.okitastatus.baoju = 0
		inst.components.okitastatus.power = 1
		inst.components.okitastatus.teji = 1 
		
		inst.freshfx = SpawnPrefab("okitasymbol")
		inst.freshfx.Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst.freshfx:ListenForEvent("onremove", deletefx, inst)
		
		inst.SoundEmitter:PlaySound("music_okita/music_okita/symbolop")
		inst.powerfx = SpawnPrefab("lighterfire_blue")
		inst.powerfx.entity:AddFollower()
	    inst.powerfx.Follower:FollowSymbol(inst.GUID, "swap_object", 0, -300, 0)		
		--inst.components.combat.damagemultiplier = inst.components.okitastatus.level*5/200 + 1.25
		inst.components.combat.damagemultiplier = (inst.components.okitastatus.level+10)*(1+ inst.components.okitastatus.greenbuff)  --100
		
    end)
end

local function OnDeath(inst)
	if inst.components.okitastatus.spelling == 1 then
		spelldone(inst)
	end
end

local function UpdateTemperature(inst)
	if TheWorld.state.temperature < 40 then
		inst.components.temperature:SetModifier("ctemp", 10)
	else
		inst.components.temperature:SetModifier("ctemp", 0)
	end
end

local common_postinit = function(inst)
	inst.clevel = net_shortint(inst.GUID,"clevel")
	inst.cexp = net_shortint(inst.GUID,"cexp")
	inst.cmiss = net_shortint(inst.GUID,"cmiss")
	inst.cmissactioning = net_shortint(inst.GUID,"cmissactioning")
	inst.cnp = net_shortint(inst.GUID,"cnp")

	inst.MiniMapEntity:SetIcon( "okita.tex" )
	inst.soundsname = "willow"
	inst:AddTag("okita")
end

local master_postinit = function(inst)
	inst.components.eater:SetOnEatFn(oneat)

	inst:AddComponent("okitastatus")
	--
	inst.entity:AddSoundEmitter()
	inst:AddTag("pyromaniac")
	
	--加食物
	table.insert(inst.components.eater.preferseating, FOODTYPE.DOGFOOD)
    table.insert(inst.components.eater.caneat, FOODTYPE.DOGFOOD)
	 inst:AddTag(FOODTYPE.DOGFOOD.."_eater")
	
	inst.components.health:SetMaxHealth(60)
	inst.components.hunger:SetMax(100)
	inst.components.sanity:SetMax(100)
	inst.components.hunger.hungerrate = TUNING.WILSON_HUNGER_RATE
	inst:DoPeriodicTask(60, UpdateTemperature)
	
	
    inst.components.combat.damagemultiplier = 1
    inst.components.health.absorb = -.25
	
	inst.components.locomotor.walkspeed = inst.components.okitastatus.speedwalk
	inst.components.locomotor.runspeed = inst.components.okitastatus.speedrun

	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
	--weapon_F
	--inst:DoPeriodicTask(60, AddFireFx)
	

	inst:ListenForEvent("killed", onkilledother)
    inst:ListenForEvent("onhitother", hitother)
    inst:ListenForEvent("DoDeltaExpOkita", DoDeltaExpOkita)
    --inst:ListenForEvent("locomote", onwalk)
    inst:ListenForEvent("powerready", powerready)
    inst:ListenForEvent("unequip", unequip)
    inst:ListenForEvent("spelldone", spelldone)
    inst:ListenForEvent("ms_becomeghost", OnDeath)
    inst:ListenForEvent("death", OnDeath)

	value(inst)
	
	--
	
	inst.components.combat.oldAttacked = inst.components.combat.GetAttacked
	function inst.components.combat:GetAttacked(...)
		if inst.components and inst.components.okitastatus and inst.components.okitastatus.miss == 1 then
			local fx = SpawnPrefab("shadow_shield3")
			
    		fx.entity:SetParent(inst.entity)
    		fx.entity:AddFollower()
	    	fx.Follower:FollowSymbol(inst.GUID, "swap_body", 0, 0, 0)
			inst.components.okitastatus.miss = 0
		else
			return inst.components.combat:oldAttacked(...)
		end
		
	end
	
	
	
end

return MakePlayerCharacter("okita", prefabs, assets, common_postinit, master_postinit, start_inv)