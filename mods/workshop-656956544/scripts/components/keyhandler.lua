local pausescreen = {"ChatInputScreen","MapScreen","ConsoleScreen"}  
local function ignore( self ) self.ignore_ = not self.ignore_ end  
local KeyHandler = Class(function(self, inst) 
	self.inst = inst 
	self.paused = false 
	self.ignore_ = false 
	self.ignore_event = net_event(self.inst.GUID, "ignore") 
	self.handler = TheInput:AddKeyHandler(function(key, down) 
		self:OnRawKey(key, down) end)  
	self.inst:ListenForEvent("gamepaused", function(inst, paused) 
		self.paused = paused end) 
	self.inst:ListenForEvent("ignore", function(inst) ignore(inst.components.keyhandler) end) end) 

	 function KeyHandler:StartIgnoring() self.ignore_event:push() end  

	 function KeyHandler:StopIgnoring() self.ignore_event:push() end  

	 function KeyHandler:OnRawKey(key, down) 

	 local player = ThePlayer 
	 if player ~= nil then   
	 	if (key and not down) and not self.paused and not self.ignore_ then       
	 		player:PushEvent("keyup",
	 			{inst = self.inst, player = player, key = key}) elseif key and down and not self.paused and not self.ignore_ 
	 		then       player:PushEvent("keydown", {inst = self.inst, player = player, key = key}) 
	 		end   
	 	end 
	 end  

	 function KeyHandler:AddActionListener(Namespace, Key, Action, Event, Client) 
	 	if Event == nil then self.inst:ListenForEvent("keyup", function(inst, data) 
	 		local screen = TheFrontEnd:GetActiveScreen() 
	 		if screen ~= nil and table.contains(pausescreen,screen.name) 
	 			then 
	 				return 
	 			end if data.inst == ThePlayer then if data.key == Key 
	 				then if not ThePlayer:HasTag("playerghost") 
	 					and not (ThePlayer.components.health and ThePlayer.components.health:IsDead()) 
	 					then 
	 						local mouseover = TheInput:GetWorldEntityUnderMouse() or nil 
	 						local x,y,z = (TheInput:GetWorldPosition() or Vector3(0,0,0)):Get() 
	 						if Client ~= nil 
	 						then  Client(self.inst, x, y, z) 
	 						end 
	 						if TheWorld.ismastersim then 
	 							ThePlayer:PushEvent("keyaction"..Namespace..Action, {Namespace = Namespace, Action = Action, Fn = MOD_RPC_HANDLERS[Namespace][MOD_RPC[Namespace][Action].id], x = x, y = y, z = z, mouseover = mouseover}) 
	 						else SendModRPCToServer(MOD_RPC[Namespace][Action], x, y, z, mouseover) end end end end end) 
	 elseif Event ~= nil 
	 	then self.inst:ListenForEvent(string.lower(Event), function(inst, data) 
	 		if data.inst == ThePlayer 
	 			then if data.key == Key 
	 				then if TheWorld.ismastersim 
	 					then ThePlayer:PushEvent("keyaction"..Namespace..Action, 
	 						{ Namespace = Namespace, Action = Action, Fn = MOD_RPC_HANDLERS[Namespace][MOD_RPC[Namespace][Action].id]}) 
	 					else SendModRPCToServer(MOD_RPC[Namespace][Action]) end end end end) 
	 end if TheWorld.ismastersim 
	 then self.inst:ListenForEvent("keyaction"..Namespace..Action, function(inst, data) 
	 	if not data.Action == Action and not data.Namespace == Namespace 
	 		then 
	 			return end           
	 			data.Fn(inst, data.x, data.y, data.z, data.mouseover) end, self.inst)  
	end end  

	return KeyHandler