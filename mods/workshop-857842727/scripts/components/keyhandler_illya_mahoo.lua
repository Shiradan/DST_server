local function ignore( self )
	self.ignore_ = not self.ignore_
end

local keyhandler_illya_mahoo = Class(function(self, inst)
	self.inst = inst
	self.paused = false
	self.ignore_ = false
	self.ignore_event = net_event(self.inst.GUID, "ignore")
	self.handler = TheInput:AddKeyHandler(function(key, down) self:OnRawKey(key, down) end )
	
	self.inst:ListenForEvent( "gamepaused", function(inst, paused) self.paused = paused end )
	self.inst:ListenForEvent( "ignore", function(inst)
		ignore( inst.components.keyhandler_illya_mahoo )
	end)
end)

function keyhandler_illya_mahoo:StartIgnoring()
	self.ignore_event:push()
end

function keyhandler_illya_mahoo:StopIgnoring()
	self.ignore_event:push()
end

function keyhandler_illya_mahoo:OnRawKey(key, down)
	local player = ThePlayer
	if player ~= nil then
  		if (key and not down) and not self.paused and not self.ignore_ then
      			player:PushEvent("keyup", {inst = self.inst, player = player, key = key})
		elseif key and down and not self.paused and not self.ignore_ then
      			player:PushEvent("keydown", {inst = self.inst, player = player, key = key})
		end
  	end
end

function keyhandler_illya_mahoo:AddActionListener(Namespace, Key, Action, Event)
	if Event == nil then
		self.inst:ListenForEvent("keyup", function(inst, data)
			if data.inst == ThePlayer then
				if data.key == Key then
					--print("1")
					local skilltable = 
					{
						["z_skill"] = "z_skill",
						["x_skill"] = "x_skill",
					}
					
					local cdtable = 
					{
						["z_skill"] = data.inst.z_skill_cd,
						["x_skill"] = data.inst.x_skill_cd,
					}

					if (
							--√ªÀ¿
							ThePlayer.components.health and not ThePlayer.components.health:IsDead() or
							
							--≤ª «πÌªÍ
							not ThePlayer:HasTag("playerghost")
							
						) and 
						not (ThePlayer.sg and ThePlayer.sg:HasStateTag("tent")) and 
						not (ThePlayer.sg and ThePlayer.sg:HasStateTag("skill")) and ThePlayer[ skilltable[Action] ] == true 
		
						
					then
					
						--print("2")
						ThePlayer[ skilltable[Action] ] = false
						if not ( ThePlayer[ skilltable[Action] ] or ThePlayer.components.timer:TimerExists( skilltable[Action] ) ) then
							ThePlayer.components.timer:StartTimer( skilltable[Action], cdtable[Action] )
						end
				
						local x,y,z = ( TheInput:GetWorldPosition() or Vector3(0,0,0) ):Get()
						if TheWorld.ismastersim then
							ThePlayer:PushEvent("keyaction"..Namespace..Action, 
							{ Namespace = Namespace, Action = Action, Fn = MOD_RPC_HANDLERS[Namespace][MOD_RPC[Namespace][Action].id], x = x, y = y, z = z})
						else
							
							SendModRPCToServer( MOD_RPC[Namespace][Action], x,y,z)
						end
					else
						--print("222")	
					end
						
				end
			end	
		end)
	elseif Event ~= nil then
		self.inst:ListenForEvent(string.lower(Event), function(inst, data)
			if data.inst == ThePlayer then
				if data.key == Key then
					if TheWorld.ismastersim then
						ThePlayer:PushEvent("keyaction"..Namespace..Action, 
						{ Namespace = Namespace, Action = Action, Fn = MOD_RPC_HANDLERS[Namespace][MOD_RPC[Namespace][Action].id]})
						--print("3")
					else
						SendModRPCToServer( MOD_RPC[Namespace][Action])
						--print("4")
					end
				end
			end	
		end)
	end

	if TheWorld.ismastersim then
		self.inst:ListenForEvent("keyaction"..Namespace..Action, function(inst, data)
			if not data.Action == Action and not data.Namespace == Namespace then
				return
			end

          		data.Fn(inst, data.x, data.y, data.z)
				--print("5")
		end, self.inst) 
	end
end

return keyhandler_illya_mahoo