local Gaebolgthrowable = Class(function(self, inst)
    self.inst = inst
    self.damage = 10
    self.attackrange = nil
    self.hitrange = nil
    self.onattack = nil
    self.onprojectilelaunch = nil
    self.projectile = nil

    --Monkey uses these
    self.modes = nil
    self.variedmodefn = nil
end,
nil,
{
})

function Gaebolgthrowable:OnRemoveFromEntity()
    if self.inst.replica.inventoryitem ~= nil then
        self.inst.replica.inventoryitem:SetAttackRange(-1)
    end
end

function Gaebolgthrowable:SetDamage(dmg)
    self.damage = dmg
end

function Gaebolgthrowable:SetRange(attack, hit)
    self.attackrange = attack
    self.hitrange = hit or self.attackrange
end

function Gaebolgthrowable:SetOnAttack(fn)
    self.onattack = fn
end

function Gaebolgthrowable:SetOnProjectileLaunch(fn)
    self.onprojectilelaunch = fn
end

function Gaebolgthrowable:SetProjectile(projectile)
    self.projectile = projectile
end

function Gaebolgthrowable:CanRangedAttack()
    if self.variedmodefn then
        local mode = self.variedmodefn(self.inst)
        if not mode.ranged then
            --determined to use melee mode, return false.
            return false
        end
    end

    return self.projectile ~= nil
end

function Gaebolgthrowable:SetAttackCallback(fn)
    self.onattack = fn
end

function Gaebolgthrowable:OnAttack(attacker, target, projectile)
    if self.onattack then
        self.onattack(self.inst, attacker, target)
    end
    
    if self.inst.components.finiteuses then
	    self.inst.components.finiteuses:Use(self.attackwear or 1)
    end
end

function Gaebolgthrowable:LaunchProjectile(attacker, target)
	if self.projectile then
        if self.onprojectilelaunch then
            self.onprojectilelaunch(self.inst, attacker, target)
        end

	    local proj = SpawnPrefab(self.projectile)
	    if proj then
            proj._gaebolg = self.inst:GetSaveRecord() --#rezecib added to save Gaebolg data for respawning at destination
            if proj.components.projectile then
    	        proj.Transform:SetPosition(attacker.Transform:GetWorldPosition() )
				--#rezecib had to add the line below because projectile refers back to weapon instead
				proj.components.projectile.onhit = self.onattack
    	        proj.components.projectile:Throw(attacker, target, attacker)
            elseif proj.components.complexprojectile then
                proj.Transform:SetPosition( attacker.Transform:GetWorldPosition() )
                proj.components.complexprojectile:Launch(Vector3( target.Transform:GetWorldPosition() ), attacker, self.inst)
            end
            self.inst:Remove() --#rezecib added to remove the Gaebolg
	    end
	end
end

return Gaebolgthrowable