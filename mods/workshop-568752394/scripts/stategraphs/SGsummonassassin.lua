require("stategraphs/commonstates")

local actionhandlers = {
	ActionHandler(ACTIONS.EAT, "eat"),
	ActionHandler(ACTIONS.CHOP, "chop")
}

local events = {
	CommonHandlers.OnStep(),
	CommonHandlers.OnLocomote(true, false),
	CommonHandlers.OnDeath(),
	EventHandler("attacked", function(inst)
		if not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") then
			inst.sg:GoToState("hit")
		end
	end),
	EventHandler("doattack", function(inst)
		if not inst.components.health:IsDead() then
			inst.sg:GoToState("attack")
		end
	end),
	EventHandler("doaction", function(inst, data) 
		if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then
			if data.action == ACTIONS.CHOP then
				inst.sg:GoToState("chop", data.target)
			end
		end
	end)
}

local function DropAndSwitch(inst)
    local swordslot = inst.sword.replica.equippable:EquipSlot()
    local inventory = inst.components.inventory
    local currentitem = inventory:GetEquippedItem(swordslot)
    inventory:DropItem(currentitem)
    inventory:Equip(inst.sword)
end

local states = {
	State {
		name= "idle",
		tags = {"idle"},
		onenter = function(inst)
			inst.Physics:Stop()
			if TheWorld.state.phase == "night" then
				inst.AnimState:PlayAnimation("idle_loop")
			elseif TheWorld.state.temperature < TUNING.FROSTY_BREATH then
				inst.AnimState:PlayAnimation("idle_shiver_loop")
			else 
				inst.AnimState:PlayAnimation("idle_loop")
			end
		end,
		events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end)
		}     
	},
    State {
		name = "death",
		tags = {"busy"},
		onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/death") 
			inst.AnimState:PlayAnimation("death")
			inst.Physics:Stop()
			RemovePhysicsColliders(inst)            
			inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
		end
    },
	State {
		name = "run_start",
		tags = {"moving", "running", "canrotate"},
		onenter = function(inst)
			inst.components.locomotor:RunForward()
			inst.AnimState:PlayAnimation("run_pre")
			inst.sg.mem.foosteps = 0
		end,
		events = {   
			EventHandler("animover", function(inst)
				inst.sg:GoToState("run")
			end)       
		},
		timeline = {
			TimeEvent(4*FRAMES, function(inst)
				PlayFootstep(inst)
				DoFoleySounds(inst)
			end)
		}
	},
    State {
		name = "run",
		tags = {"moving", "running", "canrotate"},
		onenter = function(inst) 
			inst.components.locomotor:RunForward()
			inst.AnimState:PlayAnimation("run_loop")
		end,
		timeline = {
			TimeEvent(7*FRAMES, function(inst)
				inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
				PlayFootstep(inst, inst.sg.mem.foosteps < 5 and 1 or .6)
				DoFoleySounds(inst)
			end),
			TimeEvent(15*FRAMES, function(inst)
				inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
				PlayFootstep(inst, inst.sg.mem.foosteps < 5 and 1 or .6)
				DoFoleySounds(inst)
			end)
		},
		events = {   
			EventHandler("animover", function(inst)
				inst.sg:GoToState("run")
			end)  
		}
	},
	State {
		name = "run_stop",
		tags = {"canrotate", "idle"},
		onenter = function(inst) 
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("run_pst")
		end,
		events = {   
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle") 
			end),        
		},
	},
	State {
		name = "attack",
		tags = {"attack"},
		onenter = function(inst)
			--inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
			inst.components.combat:StartAttack()
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("atk")
		inst:DoTaskInTime(1, DropAndSwitch)
		end,
		timeline = {
			TimeEvent(13*FRAMES, function(inst) 
				inst.components.combat:DoAttack() 
			end),
		},
		events = {
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle") 
			end),
		},
	},
	State {
		name = "chop",
		tags = {"chopping"},
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("atk")
			inst.components.combat:StartAttack()
			print ("chopped once!")
		end,
		timeline = {
			TimeEvent(13*FRAMES, function(inst) 
				inst:PerformBufferedAction() 
			end),
		},
		events = {
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle") 
			end),
		},
	},
	State {
		name = "eat",
		tags = {"busy"},
		onenter = function(inst)
			inst.Physics:Stop()            
			inst.AnimState:PlayAnimation("eat")
		end,
		events = {
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle") 
			end),
		},
	},
	State {
		name = "hit",
		tags = {"busy"},
		onenter = function(inst)
			inst:InterruptBufferedAction()
			inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")        
			inst.AnimState:PlayAnimation("hit")    
			inst.Physics:Stop()            
		end,
		events = {
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle") 
			end),
		},
		timeline = {
			TimeEvent(3*FRAMES, function(inst)
				inst.sg:RemoveStateTag("busy")
			end),
		},
	}
}

CommonStates.AddWalkStates(states, {
	walktimeline = {
		TimeEvent(0*FRAMES, PlayFootstep),
		TimeEvent(12*FRAMES, PlayFootstep),
	},
})

CommonStates.AddRunStates(states, {
	runtimeline = {
		TimeEvent(0*FRAMES, PlayFootstep),
		TimeEvent(10*FRAMES, PlayFootstep),
	},
})

CommonStates.AddSimpleState(states, "refuse", "hungry", {"busy"})

--CommonStates.AddIdle(states,"idle2")
--CommonStates.AddSimpleState(states,"hit", "hit", {"busy"})
--CommonStates.AddFrozenStates(states)
--CommonStates.AddSimpleActionState(states,"pickup", "pig_pickup", 10*FRAMES, {"busy"})
--CommonStates.AddSimpleActionState(states, "gohome", "pig_pickup", 4*FRAMES, {"busy"})

return StateGraph("summonassassin", states, events, "idle", actionhandlers)
