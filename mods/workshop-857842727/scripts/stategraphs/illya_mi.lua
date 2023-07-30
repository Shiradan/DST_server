local illya_skill = GLOBAL.State { 
name = "illya_skill",
tags = {"abouttoattack", "notalking", "autopredict", "illya_skill"},
onenter = function(inst ,pos)
inst.components.playercontroller:Enable(false)
inst:ForceFacePoint(TheInput:GetWorldPosition()) 
inst.AnimState:PlayAnimation("fishing_idle")
inst.components.locomotor:Stop() 
inst.sg:SetTimeout(50 * _G.FRAMES) 
end,
timeline ={
_G.TimeEvent(6 * _G.FRAMES, 
function(inst) 
local angle = inst.Transform:GetRotation() * _G.DEGREES 
local fin_x, fin_y, fin_z = 1.5 * math.cos(angle), 0, -1.5 * math.sin(angle) 
	local cannon = GLOBAL.SpawnPrefab("bishop_chargel")
	--cannon.Transform:SetRotation(inst.Transform:GetRotation())
	local x0, y0, z0 = inst:GetPosition():Get()
	cannon.Transform:SetPosition(x0 + fin_x, 1 ,z0 + fin_z )
	cannon.Transform:SetScale(2,2,2)
inst.AnimState:PlayAnimation("fishing_pst") 
inst.AnimState:OverrideSymbol("", "", "") 
inst:DoTaskInTime(1.5, function() cannon:Remove()
end)
end),
_G.TimeEvent(10 * _G.FRAMES, 
function(inst) 
inst.AnimState:SetPercent("fishing_pst", 0.38) 
end),
_G.TimeEvent(40 * _G.FRAMES, 
function(inst)
inst.AnimState:PlayAnimation("give_pst") 
end),
},
ontimeout = function(inst)
inst.sg:GoToState("idle")
end,
onexit = function(inst)
inst.components.playercontroller:Enable(true)
end,
}

AddStategraphState("wilson", illya_skill)
AddStategraphState("wilson_client", illya_skill)
