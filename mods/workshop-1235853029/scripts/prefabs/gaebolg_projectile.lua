local assets =
{
	Asset("ANIM", "anim/gaebolg_projectile.zip"),
}

local healthvalue = TUNING.HEALTHVALUE
local hungervalue = TUNING.HUNGERVALUE

local function onattack_gaebolg_projectile(inst, attacker, target)
    if attacker and attacker.components.health and attacker.components.hunger then
        attacker.components.health:DoDelta(healthvalue)
		attacker.components.hunger:DoDelta(hungervalue)
    end

    local atkfx = SpawnPrefab("lavaarena_creature_teleport_smoke_fx_3")
	local atkfxx = SpawnPrefab("lucy_ground_transform_fx")
    if atkfx and atkfxx then
	    local follower = atkfx.entity:AddFollower()
		local follower = atkfxx.entity:AddFollower()
	    follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
			for i, v in ipairs(AllPlayers) do
			v:ShakeCamera(CAMERASHAKE.FULL, .7, .02, .3, inst, 40)
		end
    end
	
    if target and target.brain and target.gaebolg_projectilestun ~= true then
        target.gaebolg_projectilestun = true
        target.brain:Stop()
		if target.components.locomotor then
            target.components.locomotor:Stop()
        end
        target:DoTaskInTime(5, function()
            target.brain:Start()
            target.gaebolg_projectilestun = nil
        end)
    end
end


local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.AnimState:SetBank("gaebolg_projectile")
    inst.AnimState:SetBuild("gaebolg_projectile")
    inst.AnimState:PlayAnimation("idle", true)
	
    if not TheWorld.ismastersim then
        return inst
    end

    -- inst.AnimState:SetBank("projectile")
    -- inst.AnimState:SetBuild("staff_projectile")

    inst:AddTag("projectile")
    
    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(30)
	inst.components.projectile:SetLaunchOffset({x=0, y=2})
	inst.components.projectile:SetHitDist(2)
    -- inst.components.projectile:SetOnHitFn(inst.Remove)
    -- inst.components.projectile:SetOnMissFn(inst.Remove)
	inst.Transform:SetScale(1.8,1.8,1.8)
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetOnAttack(onattack_gaebolg_projectile)
	inst.components.weapon:SetDamage(0)

	-- inst.AnimState:PlayAnimation("fire_spin_loop", true)
	-- inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

	inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
	
	
	
	return inst
end

return Prefab("common/inventory/gaebolg_projectile", fn, assets)