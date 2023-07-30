local assets=
{
	Asset("ANIM", "anim/gate_of_babylon.zip"),
	Asset("ANIM", "anim/bakuya.zip"),
}

local prefabs = {
	"archer",
	--"archer_bakuya",
	"caster_ring_fx",
	"keyofbabylon",
	
}


-----------------重定位目标？猪哥说的，不懂----------------
local function RetargetFn(inst)
--[[	local kingtarget = nil
	kingtarget = FindEntity(inst, 30, function(guy)
		return guy:HasTag("monster") 
		
	end)



	return kingtarget]]
end

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)     
end

-------------------------------------------------------------

------------------猪哥吊炸天的碰撞系统--------------------------
local function oncollide(inst, other)
	if not other then
		return
	else
		if not other:IsValid() then
			return
		end
		----遇到障碍物就跳跃
		if inst.components.health and not inst.components.health:IsDead() and not (other:HasTag("shadowboss") or other:HasTag("projectile") or other:HasTag("character")) then
			if not inst.sg:HasStateTag("attack") then
			end
		end
	end
end

------------------------------------------------------------------------------
------------------攻击的特殊效果------------------------------------------------------
local function EquipWeapon(inst)
    if inst.components.inventory and not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
        local weapon = CreateEntity()
        --[[Non-networked entity]]
        weapon.entity:AddTransform()
        weapon:AddComponent("weapon")
        weapon.components.weapon:SetDamage(inst.components.combat.defaultdamage)
        weapon.components.weapon:SetRange(inst.components.combat.attackrange, inst.components.combat.attackrange+4)
        weapon.components.weapon:SetProjectile("jsssword")
        weapon:AddComponent("inventoryitem")
        weapon.persists = false
        weapon.components.inventoryitem:SetOnDroppedFn(weapon.Remove)
        weapon:AddComponent("equippable")
        
        inst.components.inventory:Equip(weapon)
    end
end

local function onattack(inst,data)
    local rand = math.random()
    local victim = data.target
  	local leader = inst.components.follower.leader

	--local gold = SpawnPrefab("goldnugget")
        if victim then
	        local x,y,z = victim:GetPosition():Get()
	            SpawnPrefab("collapse_big").Transform:SetPosition(x,y,z)
	           

		    end
		                      


	local target = data.target
	inst.components.combat:ShareTarget(target, 40, function(dude)
		return dude:HasTag("gate_of_babylon") and dude.components.follower.leader == inst.components.follower.leader
	end, 20)

end

local function OnAttacked(inst, data)
	inst.components.talker:Say("*Under Attack*")
	local attacker = data.attacker
	if not attacker:HasTag("gilgamesh") and attacker:HasTag("gate_of_babylon") then
    inst.components.combat:SetTarget(attacker)
    inst.components.combat:ShareTarget(attacker, 40, function(dude)
		return dude:HasTag("gate_of_babylon") and dude.components.follower.leader == inst.components.follower.leader
	end, 20)
end
end

local function onpickedfn(inst, picker)
    inst:Remove()
end



------------------------创建实体--------------------------------------
---------------------------------------------------------------------
local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()

	--inst.entity:AddSoundEmitter()
------------------物理系统-----------------------------------------------
	local phys = inst.entity:AddPhysics()
	phys:SetMass(100)
    phys:SetCapsule(.5, 1.5)
    phys:SetFriction(0)
    phys:SetDamping(5)
    phys:SetCollisionGroup(COLLISION.CHARACTERS)
    phys:ClearCollisionMask()
	phys:CollidesWith(COLLISION.GROUND)
	phys:CollidesWith(COLLISION.OBSTACLES)
    phys:CollidesWith(COLLISION.SMALLOBSTACLES)
	phys:CollidesWith(COLLISION.CHARACTERS)
---------------------------------------------------------------------
	inst.DynamicShadow:SetSize(1, 1)
--------------------------------------------------------------------------	
	inst.Transform:SetFourFaced()
	inst.Transform:SetScale(1, 1, 1)

	inst.AnimState:SetBank("gate_of_babylon")
	inst.AnimState:SetBuild("gate_of_babylon")
	inst.AnimState:PlayAnimation("idle_loop",true)
	--inst.Transform:SetScale(3, 3, 3)
--[[	inst.AnimState:Show("HAT")
	inst.AnimState:Hide("HAT_HAIR")
	inst.AnimState:Show("HAIR_NOHAT")
	inst.AnimState:Hide("HAIR")

]]

----------------添加标签-------------------------------------
	inst:AddTag("gate_of_babylon")
	inst:AddTag("king")
	--inst:AddTag("")   --备用
------------------------------------------------------------------
------------------作用不明的代码---------------------------
inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end 

----------------------碰撞-------------------------------------------
    inst.Physics:SetCollisionCallback(oncollide)
----------------------------------------------------------------

----	基本属性设置
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed= 4
    inst.components.locomotor.runspeed = 4
	inst.components.locomotor.fasteronroad = true
	inst.components.locomotor:SetTriggersCreep(false)


	inst:SetStateGraph("SGgate_of_babylon")
	local brain = require "brains/gate_of_babylonbrain"		
    inst:SetBrain(brain)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(180)
	--inst.components.health:StartRegen(30, 1)
	inst.components.health.fire_damage_scale = 0

	--inst.components.health:SetAbsorptionAmount(.3)

	inst:AddComponent("inventory")
    inst:DoTaskInTime(1, EquipWeapon)

    inst:AddComponent("talker")

-----------------------------------------------------------------------	
	MakeMediumBurnableCharacter(inst, "torso")----????这是什么
------------------------------------------------------------------
-----------------战斗设置--------------------------------------
	inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(35)						
    inst.components.combat:SetAttackPeriod(1.1)
    inst.components.combat:SetRange(40)
    inst.components.combat.hiteffectsymbol = "torso"
  --  inst.components.combat:SetRetargetFunction(2, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)

    --攻击特效
	inst:ListenForEvent("onattackother", onattack)

	----	监听事件
    inst:ListenForEvent("attacked", OnAttacked)

    inst:AddComponent("inspectable")
	inst.components.inspectable:SetDescription("")


    inst:AddComponent("pickable")
    inst.components.pickable:SetUp("caibao", 1)
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.quickpick = true


-------------------------------------------------------------
    inst:AddComponent("follower")
    
	return inst
end
	
return Prefab("gate_of_babylon", fn, assets, prefabs)