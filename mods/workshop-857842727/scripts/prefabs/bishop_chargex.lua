local assets =
{
    Asset("ANIM", "anim/bishop_chargex.zip"),
}



local function fn() 
--生成子弹
local inst = CreateEntity()
inst.entity:AddTransform() 
inst.entity:AddAnimState() 
inst.entity:AddNetwork() 
MakeInventoryPhysics(inst) 
RemovePhysicsColliders(inst) 
inst.Physics:SetMass(0) 
inst.Transform:SetScale(2, 2, 2)
inst:AddTag("bishop_chargex")
inst:AddTag("projectile") 
inst:AddTag("FX")
    inst.AnimState:SetBank("bishop_chargex")
    inst.AnimState:SetBuild("bishop_chargex")
    inst.AnimState:PlayAnimation("idle")
inst:AddTag("projectile")
inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround) 
inst.AnimState:SetRayTestOnBB(true) 
inst.task = nil
if not TheWorld.ismastersim then return inst end 
inst.owner = nil 
inst.damage = nil 
inst.cannon = nil 
inst.pos = nil 
inst.launch = function() 
local x1, y1, z1 = inst:GetPosition():Get() 
local x2, y2, z2 = inst.pos.x, inst.pos.y, inst.pos.z 
local ydelta = math.abs(y2 - y1) 
local distdelta =  math.sqrt((x1 - x2) * (x1 - x2) + (z1 - z2) * (z1 - z2)) 
inst:ForceFacePoint(x2, y2, z2) 
local speed = 20 
local speed2 = distdelta 
if inst.Physics.SetMotorVelOverride ~= nil 
then inst.Physics:SetMass(1) 
inst.Physics:SetMotorVelOverride(speed2, -speed / distdelta * ydelta / 5 * 4, 0) 
end 
local last_y = 99 
local function stopFn()
local x, y, z = inst:GetPosition():Get()
if y <= 0.1 or math.abs(y - 99) <= 0.1 then 
inst.Physics:ClearMotorVelOverride() 
inst:Hide() 
inst.task:Cancel()
local fram = SpawnPrefab("firesplash_fx")
--fram.entity:SetParent(inst.entity)
fram.Transform:SetPosition(x2, y2, z2)
fram.Transform:SetScale(1.5,1.5,1.5)
local ents = TheSim:FindEntities(x2,y2,z2, 6)
		for k,v in ipairs(ents) do
			--忽视规则模版
			if v and v ~= inst and 
				not (v.components.follower and v.components.follower.leader == inst ) and 
				(TheNet:GetPVPEnabled() or not v:HasTag("player")) and
				not v:HasTag("companion") and 
				not v:HasTag("wall")
			then
				if v.components.health and not v.components.health:IsDead() then
					if v.xiana_task == nil then
						if v.components.health then
							v.components.health:DoDelta(-(25 + inst.damage * 0.5),true)
						end
						if v.components.burnable then
							v.components.burnable:SpawnFX()
							v.xiana_task = v:DoPeriodicTask(0.1, function()
								if v.components.health then
									v.components.health:DoDelta(-75 - inst.damage*0.5)
								end
							end)
							v:DoTaskInTime(0.1, function()
								if v.xiana_task ~= nil then
									v.xiana_task:Cancel()
									v.xiana_task = nil
									if v.components.burnable then
										v.components.burnable:KillFX()
									end
								end
							
							end)
						end	
					end
				end
			end
			
		end	
end 
end 
inst.task = inst:DoPeriodicTask(0.1, function() stopFn() end)
inst:DoTaskInTime(5, function() inst.task:Cancel() inst:Remove() 
--local fram = SpawnPrefab("firesplash_fx")
--fram.entity:SetParent(inst.entity)
--fram.Transform:SetPosition(x2, y2, z2)
--fram.Transform:SetScale(1,1,1) 
end)
end 
inst.persists = false
return inst 
end





return Prefab("bishop_chargex", fn, assets)