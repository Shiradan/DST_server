
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
 --   Asset("ANIM","anim/archer.zip"),
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {
	"keyofbabylon",
	"gilgamesh_notice_ch",
	--"gilgamesh_axe",
}

-- Custom starting items
local start_inv = {
"key_of_babylon",
"gilgamesh_notice_ch",
--"gilgamesh_axe",

}

local gilgamesh = require "gilgamesh"
local PingA_Range = gilgamesh.GetModConfigData("PingA_Range",true)

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when loading or reviving from ghost (optional)
	
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end

local function onattack(inst,data)
	local target = inst.components.combat.target
    	if target ~=nil and not target:HasTag("gilgamesh_target") then
        	target:AddTag("gilgamesh_target") 
        	inst.components.talker:Say("标记敌人！")
    end
end

local function onharvested(inst, data)--收割的函数 
	if data ~= nil then	
		inst.components.inventory:GiveItem(SpawnPrefab("goldnugget",1))
	end
end

local function setSkillCooldown(inst)
	if inst:HasTag("attack_cd") then 
    	inst.components.talker:Say("魔力回路尚在冷却。")----cd中，直接跳出循环
    	return false
	else 
    	inst:AddTag("attack_cd")
    	inst:DoTaskInTime(8,function()--取消cd
			if inst:HasTag("attack_cd") then
				inst:RemoveTag("attack_cd")
				inst.components.talker:Say("魔力回路已完成。")
			end
		end)
  	end
return true
end

local function gate_attack_anim_fn(inst,victim)--召唤王财特效的函数
	local gate_attack =SpawnPrefab("gate_of_babylon_attack_fx")	
	gate_attack.Transform:SetPosition(inst:GetPosition():Get())
    gate_attack:FacePoint(victim:GetPosition())
end


local function gate_attacking(inst,target)
	local damage = 15
	if target.components.combat ~= nil and not (target.components.health ~= nil and target.components.health:IsDead()) then
    --如果目标有战斗组件 并且 （目标生命不为空 并且 目标死了）为假
   		target.components.combat:GetAttacked(inst,damage,nil)
   		gate_attack_anim_fn(inst,target)    
  	end
end

local function weapon_summoning(inst,victim)
  	local weapon_of_gilgamesh = {--注意召唤的武器一定要有耐久，同时数组的长度也要注意
  		"spear_wathgrithr",
  		"nightsword",
  		"batbat",
  		"ruins_bat",
  	}
  	local number_w_o_g = 4 -- 吉尔伽美什宝具的数量
  	local weapon_summon = SpawnPrefab(weapon_of_gilgamesh[math.random(number_w_o_g)]) --随机召唤宝库的武器
--召唤一个神奇的武器
	weapon_summon.Transform:SetPosition(victim:GetPosition():Get())
	--if weapon_summon.components.finiteuses then --确保武器耐久不为空
	weapon_summon.components.finiteuses:SetUses(2) --把召唤出来的武器设置耐久为2
	--end
	inst:DoTaskInTime(30,function() --45秒后删除生成的武器
	    SpawnPrefab("collapse_small").Transform:SetPosition(weapon_summon:GetPosition():Get())
	    weapon_summon:Remove()
	end
	)
	SpawnPrefab("collapse_big").Transform:SetPosition(victim:GetPosition():Get())
end


local function gate_searching(inst,number)
	local result = false
	local range =40
	local pos =Vector3(inst.Transform:GetWorldPosition())
	local ents = TheSim:FindEntities(pos.x,pos.y,pos.z,range)

	for k,v in pairs(ents) do--迭代器 k是key v是value
		if v:HasTag("gilgamesh_target") then
			gate_attacking(inst,v)
			
			if number >=8 then 
				weapon_summoning(inst,v)
			end
			SpawnPrefab("collapse_small").Transform:SetPosition(v:GetPosition():Get())
			result = true
		end
	end
	return result
end

local function gate_of_babylon_attack_fn(inst)
	local time = 10
	local period = 0.5

	if setSkillCooldown(inst) then
		for i=1,time do
		------这里放主体函数--------
			--print(i)
			inst:DoTaskInTime(period*(i-math.random()),function()
				--延时
				gate_searching(inst,i)
				--if not gate_searching(inst,i) == true then
					--inst.components.talker:Say("无有效目标")
					--return true
				--end
			end)--内部函数结束
		end -- for 循环 end
	end -- if setSkillCooldown end
end




-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "gilgamesh.tex" )
	inst:AddTag("gilgameshbuilder")
	inst:AddTag("gilgamesh")
-------------------------------------------
	inst:AddComponent("keyhandler")
	--inst.components.keyhandler:AddActionListener("gilgamesh",KEY_X,"gate_retreat")
	inst.components.keyhandler:AddActionListener("gilgamesh",KEY_C,"gate_of_babylon_attack")
	--inst.components.keyhandler:AddActionListener("gilgamesh",KEY_R,"ranger_switch")

	--AddModRPCHandler("gilgamesh","gate_retreat",gate_retreat_fn)
	AddModRPCHandler("gilgamesh","gate_of_babylon_attack",gate_of_babylon_attack_fn)
--	AddModRPCHandler("gilgamesh","ranger_switch",ranger_switch_fn)

end



local effect_recipes =
{
        "gate_of_babylon",

}




local master_postinit = function(inst)
	inst.Transform:SetScale(1.3, 1.3, 1.3)

 	if PingA_Range =="far" then
 	inst.components.health:SetMaxHealth(60)
	inst.components.hunger:SetMax(80)
	inst.components.sanity:SetMax(220)
 	inst.components.combat:SetRange(18,18)
    end

    if PingA_Range =="normal" then
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(80)
	inst.components.sanity:SetMax(260)
	inst.components.combat:SetRange(3,3)
	end
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE *0.5)

    inst.components.sanity.night_drain_mult=0.709
    inst.components.sanity.neg_aura_mult=0
    inst.components.combat.min_attack_period =0.1
    inst.components.locomotor.walkspeed = (6)
	inst.components.locomotor.runspeed = (8)
    inst.components.combat:SetDefaultDamage(2)
  --  inst.components.combat:SetOnHit(gilgamesh_hit_fn)

   

	--inst.components.health.absorb = 0.25

	inst:ListenForEvent("onattackother", onattack)
	inst:ListenForEvent("harvestsomething", onharvested) 
  	inst:ListenForEvent("picksomething", onharvested) 
  	inst:ListenForEvent("fishingcollect", onharvested) 
  	inst:ListenForEvent("finishedwork", onharvested) 
		
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
---------------------------------------------



end

return MakePlayerCharacter("gilgamesh", prefabs, assets, common_postinit, master_postinit, start_inv)
