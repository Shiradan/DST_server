local function oncurrentlevel(self,level) self.inst.clevel:set(level) end
local function oncurrentexp(self,exp) self.inst.cexp:set(exp) end
local function oncurrentmiss(self,miss) self.inst.cmiss:set(miss) end
local function oncurrentmissactioning(self,missactioning) self.inst.cmissactioning:set(missactioning) end
local function oncurrentnp(self,np) self.inst.cnp:set(np) end
--
-- local function oncurrentstar(self,star) self.inst.pstar:set(star) end
-- local function oncurrentnp(self,np) self.inst.pnp:set(np) end


local okitastatus = Class(function(self, inst)
    self.inst = inst
    self.level = 0
    self.exp = 0
    self.expold = 0
    self.expmod = 1
    self.maxexp = 0
	-- star & np
	self.star = 0
	self.np = 0
	self.baoju = 1
	self.teji = 0
	self.baojuatk = 0
	--gai
	self.criticalbuff = 0
	self.gtimer = 0
	self.htimer = 0
	self.greenbuff = 0
	
    self.miss = 0
    self.missactioning = 0
    self.power = 0
    self.spelling = 0
    self.damagemod = 1
    self.speedwalk = TUNING.WILSON_WALK_SPEED * 1.25
    self.speedrun = TUNING.WILSON_RUN_SPEED * 1.25
end,
nil,
{
    level = oncurrentlevel,
	--
	-- star = oncurrentstar,
	-- np = oncurrentnp,
	
    exp = oncurrentexp,
    miss = oncurrentmiss,
    missactioning = oncurrentmissactioning,
})

function okitastatus:OnSave()
    local data = {
        level = self.level,
        exp = self.exp,
		np = self.np,
    }
    return data
end

function okitastatus:OnLoad(data)
    self.level = data.level or 0
    self.exp = data.exp or 0
	self.np = data.np or 0
end



function okitastatus:DoDeltaExp(delta)
    if delta > 0 then
        self.expold = self.exp
        self.exp = self.exp + delta*self.expmod
    else
        self.expold = self.exp
        self.exp = self.exp + delta
    end
    self.inst:PushEvent("DoDeltaExpOkita")
end

function okitastatus:powerready()
	self.inst:PushEvent("powerready")
end

function okitastatus:spelldone()
	self.inst:PushEvent("spelldone")
end

return okitastatus