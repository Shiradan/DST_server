local assets =
{
    Asset("ANIM", "anim/illya_rubystar.zip"),
    Asset("ANIM", "anim/illya_rubystar_swap.zip"),
    Asset("ATLAS", "images/illya_rubystar.xml"),
	Asset("IMAGE", "images/illya_rubystar.tex"),
}

local prefabs =
{
    "ice_projectile",
}


	local function OnEquip(inst, owner)
	if owner.prefab == "illya_mahoo" then
		inst.Light:Enable(true)
		owner.components.combat:SetAreaDamage(8, 1)
        owner.AnimState:OverrideSymbol("swap_object", "illya_rubystar_swap", "swap_cane")
        owner.components.combat.damagemultiplier = 1
		owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
		owner.illya_weapon_ok = 1
		if not(owner.Mag_Power == nil) then
		owner.Mag_Power2 = owner.Mag_Power2 + 200
		end
	else
	owner:DoTaskInTime(0, function()
            local inv = owner.components.inventory 
            if inv then
                inv:GiveItem(inst)
            end
            local talker = owner.components.talker 
            if talker then
                talker:Say("I cannot use !")
            end
        end)
    end
    end
 
local function OnUnequip(inst, owner)
	inst.Light:Enable(false)
	owner.components.combat:SetAreaDamage(nil, nil)
	--owner.components.combat.damagemultiplier = 0.5
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
	owner.illya_weapon_ok = 0
	if not(owner.Mag_Power == nil) then
	owner.Mag_Power2 = owner.Mag_Power2 - 200
	end
	local amulet = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
	if owner.illya_amulet == 1 then
	owner.components.combat.damagemultiplier = 0.7
	else
	owner.components.combat.damagemultiplier = 0.5
	end
end

local function onlightning(staff, caster, target)
	if caster.components.sanity ~= nil and caster.components.sanity.current >= 70 then
		caster.components.sanity:DoDelta(- 70)
				else
		caster.components.health:DoDelta(- 16, true)
		end

	if target.components.health and caster.Mag_Power then
		target.components.health:DoDelta(- (caster.Mag_Power + caster.Mag_Power2) * 0.4 - 20)
	end
--	target.AnimState:SetMultColour(125/255,125/255,125/255,1)
	--staff.components.finiteuses:Use(1)
	SpawnPrefab("lightning").Transform:SetPosition(target.Transform:GetWorldPosition())


end
local function SpawnIceFx(inst, target, pt)
    if not inst then return end
    
    inst.SoundEmitter:PlaySound("dontstarve/creatures/deerclops/swipe")
    
    local numFX = math.random(15,20)
    local pos = inst:GetPosition()
    local targetPos = target and target:GetPosition() or pt
    local vec = targetPos - pos
    vec = vec:Normalize()
    local dist = pos:Dist(targetPos)
    local angle = inst:GetAngleToPoint(targetPos:Get())

    for i = 1, numFX do
        inst:DoTaskInTime(math.random() * 0.25, function(inst)
            local prefab = "icespike_fx_"..math.random(1,4)
            local fx = SpawnPrefab(prefab)
            if fx then
                local x = GetRandomWithVariance(0, 1)
                local z = GetRandomWithVariance(0, 1)
                local offset = (vec * math.random(dist * 0.25, dist)) + Vector3(x,0,z)
                fx.Transform:SetPosition((offset+pos):Get())
                
                --冰柱伤害
                local x,y,z = fx.Transform:GetWorldPosition()
                
                --每根冰柱的伤害半径
                local r = 1
                
                --每根冰柱的伤害
                local dmg = 25 + (inst.Mag_Power + inst.Mag_Power2)*0.3
                
                local ents = TheSim:FindEntities(x,y,z,r)
                for k, v in pairs(ents) do
                
                    ----发招忽略队友
                    if v and v.components.health and not v.components.health:IsDead() and v.components.combat and
                        v ~= inst and
                        not (v.components.follower and v.components.follower.leader == inst ) and 
                        (TheNet:GetPVPEnabled() or not v:HasTag("player"))
                    then
                    
                        --如果开启智能敌对则用Zg_GetAttacked, 因为智能敌对的伤害数据走向不经过官方的GetAttacked
                        if v.components.combat.Zg_GetAttacked then
                            v.components.combat:Zg_GetAttacked( inst, dmg)
                        else
                            v.components.combat:GetAttacked( inst, dmg )
                        end
                        
                        if v.components.freezable then
                            v.components.freezable:AddColdness(2)
                            v.components.freezable:SpawnShatterFX()
                        end
                        
                    end
                end
                
            end
        end)
    end
end
local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)
	inst.AnimState:SetBank("cane")
	inst.AnimState:SetBuild("illya_rubystar")
	inst.AnimState:PlayAnimation("idle")
	inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		return inst
	end
	--[[inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(20)
	inst.components.finiteuses:SetUses(20)
	if inst.components.finiteuses.current < 0 then
       inst.components.finiteuses.current = 0
    end]]
	--inst.components.finiteuses:SetOnFinished(inst.Remove)
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/illya_rubystar.xml"
	inst.components.inventoryitem.imagename = "illya_rubystar"
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(OnEquip)
	inst.components.equippable:SetOnUnequip(OnUnequip)
	inst:AddComponent("inspectable")
		local light = inst.entity:AddLight()--光 
	light:Enable(true) 
	light:SetRadius(2) --范围
	light:SetIntensity(0.8) --光亮度
	light:SetColour(255/255,255/255,192/255) 
	light:SetFalloff(0.33)--亮度衰减，越小越好。不可为0
	inst:AddComponent("weapon")
	inst.components.weapon:SetOnAttack(onlightning)
	inst.components.weapon:SetDamage(1)
	inst.components.weapon:SetRange(20, 25)
	inst.components.weapon:SetProjectile("bishop_charge")
	
	    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", function(inst, data)
        if data.name == "_icespike" then    
            inst._icespike = true
        end
    end)
    ----设置冷却时间
    local _icespike_cd = 20
    ----开始是技能是就绪的
    inst._icespike = true
    if not ( inst._icespike or inst.components.timer:TimerExists( "_icespike" ) ) then
        inst.components.timer:StartTimer( "_icespike", _icespike_cd )
    end

    inst:AddComponent("spellcaster")
    inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canonlyuseonrecipes = true
    inst.components.spellcaster.canonlyuseonlocomotors = true
    inst.components.spellcaster.canonlyuseonworkable = true
    inst.components.spellcaster.canonlyuseoncombat = true
    inst.components.spellcaster.quickcast = true
    
    inst.components.spellcaster:SetSpellFn( function(staff, target, pos)
        local owner = inst.components.inventoryitem.owner
        if owner then
            if inst._icespike == true then
                --技能本身
                SpawnIceFx(owner, target, pos)
                --消耗代价
                if owner.components.hunger then
                    owner.components.hunger:DoDelta(-3)
                end
                if owner.components.sanity and owner.components.sanity.current >= 30 then
                    owner.components.sanity:DoDelta(-30)
					else
					owner.components.health:DoDelta(- 10, true)
                end
                --进入冷却
                inst._icespike = false
                if not ( inst._icespike or inst.components.timer:TimerExists( "_icespike" ) ) then
                    inst.components.timer:StartTimer( "_icespike", _icespike_cd )
                end
            else
                local timeleft = inst.components.timer:GetTimeLeft("_icespike")
                timeleft = math.ceil(timeleft * 10) / 10
                --说出为什么不能发
                if owner.components.talker then
                    owner.components.talker:Say("Remaining "..timeleft.." s")
                end
                --技能发不出来, 那么就是普通攻击了
                if owner.components.combat then
                    owner.components.combat:DoAttack(target)
                end
                
            end
        end
    end)
    return inst
end

return Prefab("common/inventory/illya_rubystar4", fn, assets, prefabs)
