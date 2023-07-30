local ThePlayer = GLOBAL.ThePlayer
local TheInput = GLOBAL.TheInput
local TheNet = GLOBAL.TheNet
--
--local cst = GLOBAL.STRINGS.CARNEYSTRINGS
local SpawnPrefab = GLOBAL.SpawnPrefab

AddModRPCHandler(modname, "Check", function(player)
	if not player:HasTag("playerghost") and player.components.okitastatus then
		player.components.talker:Say("lv "..(player.components.okitastatus.level).."  ".."exp "..(math.floor(player.components.okitastatus.exp)).."/"..(player.components.okitastatus.maxexp))
    end
end)



local KEY_K = GLOBAL.KEY_K
AddModRPCHandler(modname, "K", function(player)
	if not player:HasTag("playerghost") and player.components.okitastatus then
		
		--player.components.talker:Say("dd "..(GLOBAL.CONTROL_SECONDARY))
		--SpawnPrefab("seffc").entity:SetParent(player.entity)
	end
end)

AddModRPCHandler(modname, "Dodge", function(player)
	if not player:HasTag("playerghost") and player.components.okitastatus then
		local missactioning = player.components.okitastatus.missactioning
		if missactioning == 0 then
			if not player.sg:HasStateTag("busy") and not player.components.rider:IsRiding() then
				player.AnimState:PlayAnimation("hatdance_pre")
				player.sg.statemem.action = player.bufferedaction
				player.sg:SetTimeout(0.9)
				SpawnPrefab("red_leaves").Transform:SetPosition(player.Transform:GetWorldPosition())
				player.SoundEmitter:PlaySound("music_okita/music_okita/skill1")
				player.components.okitastatus.miss = 1
				player.components.okitastatus.missactioning = 1
				
				--gai
				player.components.okitastatus.criticalbuff = 1
				player:DoTaskInTime(2, function()
					player.components.okitastatus.criticalbuff = 0
				end)
				
				
				
				local level = player.components.okitastatus.level
				if level > 100 then level = 100 end
				player:DoTaskInTime(.35+level/100*.35, function()
					player.components.okitastatus.miss = 0
				end)
				
				player:DoTaskInTime(5, function()
					player.components.okitastatus.missactioning = 0
				end)
			end
		end
	end
end)

AddModRPCHandler(modname, "Charge", function(player)
	if not player:HasTag("playerghost") and player.components.okitastatus then
		if player.components.okitastatus.power == 0 then
	        player.components.okitastatus:powerready()
	    end
	end
end)

local KEY_G = GLOBAL.KEY_G
AddModRPCHandler(modname, "G", function(player)
	if not player:HasTag("playerghost") and player.components.okitastatus then
		local gtimer = player.components.okitastatus.gtimer
		if gtimer == 0 then
			player.SoundEmitter:PlaySound("music_okita/music_okita/skill2")
			player.AnimState:PlayAnimation("emote_pre_sit2")
			SpawnPrefab("red_leaves").Transform:SetPosition(player.Transform:GetWorldPosition())
			player.components.okitastatus.gtimer = 1
			--function in time
			
			player.components.okitastatus.star = 10
			--CD
			player:DoTaskInTime(5, function()
					player.components.okitastatus.gtimer = 0
				end)
			
		end
	
		--SpawnPrefab("seffc").entity:SetParent(player.entity)
	end
end)

local KEY_H = GLOBAL.KEY_H
AddModRPCHandler(modname, "H", function(player)
	if not player:HasTag("playerghost") and player.components.okitastatus then
		local htimer = player.components.okitastatus.htimer
		if htimer == 0 then
			
			player.SoundEmitter:PlaySound("music_okita/music_okita/skill1")
			player.components.okitastatus.htimer = 1
			--function in time
			
			player.components.okitastatus.greenbuff = 0.5
			player.components.talker:Say("greenbuff")
			player:DoTaskInTime(2, function()
					player.components.okitastatus.greenbuff = 0
					player.components.talker:Say("green buffover")
				end)
			
			--CD
			player:DoTaskInTime(5, function()
					player.components.okitastatus.htimer = 0
				end)
			
		end
	end
end)


AddModRPCHandler(modname, "Icicle", function(player)
	if not player:HasTag("playerghost") and player.components.okitastatus then
		player.components.okitastatus:spelldone()
	end
end)

local okita_handlers = {}
AddPlayerPostInit(function(inst)
	inst:DoTaskInTime(0, function()
		if inst == GLOBAL.ThePlayer then
			if inst.prefab == "okita" then
				okita_handlers[0] = TheInput:AddKeyDownHandler(TUNING.CheckKey, function()
					local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
            		local IsHUDActive = screen and screen.name == "HUD"
            		if inst:IsValid() and IsHUDActive then
            			SendModRPCToServer(MOD_RPC[modname]["Check"])
            		end
				end)
				okita_handlers[1] = TheInput:AddKeyDownHandler(KEY_K, function()
					local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
            		local IsHUDActive = screen and screen.name == "HUD"
            		if inst:IsValid() and IsHUDActive then
						SendModRPCToServer(MOD_RPC[modname]["K"])
					end
				end)
				okita_handlers[2] = TheInput:AddKeyDownHandler(TUNING.DodgeKey, function()
					local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
            		local IsHUDActive = screen and screen.name == "HUD"
            		if inst:IsValid() and IsHUDActive then
						SendModRPCToServer(MOD_RPC[modname]["Dodge"])
						if not GLOBAL.ThePlayer:HasTag("playerghost") and GLOBAL.ThePlayer.cmissactioning:value() == 0 then
							if not GLOBAL.ThePlayer:HasTag("busy") and not GLOBAL.ThePlayer.replica.rider._isriding:value() then
								--if GLOBAL.ThePlayer.components.locomotor and GLOBAL.ThePlayer.components.locomotor.wantstomoveforward then
								GLOBAL.ThePlayer.AnimState:PlayAnimation("jumpout")
								--end
								--GLOBAL.ThePlayer.sg.statemem.action = GLOBAL.ThePlayer.bufferedaction
								--GLOBAL.ThePlayer.sg:SetTimeout(.7)
								GLOBAL.ThePlayer:DoTaskInTime(.7, function()
									if GLOBAL.ThePlayer.components.locomotor and GLOBAL.ThePlayer.components.locomotor.wantstomoveforward then
										GLOBAL.ThePlayer.AnimState:PlayAnimation("run_loop", true)
									else
										if not GLOBAL.ThePlayer:HasTag("busy") and not GLOBAL.ThePlayer:HasTag("doing") then
											--GLOBAL.ThePlayer.sg:GoToState("idle")
										end
									end
								end)
							end
						end
					end
				end)
				okita_handlers[3] = TheInput:AddKeyDownHandler(TUNING.ChargeKey, function()
					local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
            		local IsHUDActive = screen and screen.name == "HUD"
            		if inst:IsValid() and IsHUDActive then
            			SendModRPCToServer(MOD_RPC[modname]["Charge"])
            		end
				end)
				okita_handlers[4] = TheInput:AddKeyDownHandler(TUNING.IcicleKey, function()
					local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
            		local IsHUDActive = screen and screen.name == "HUD"
            		if inst:IsValid() and IsHUDActive then
            			SendModRPCToServer(MOD_RPC[modname]["Icicle"])
            		end
				end)
				okita_handlers[5] = TheInput:AddKeyDownHandler(KEY_G, function()
					local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
            		local IsHUDActive = screen and screen.name == "HUD"
            		if inst:IsValid() and IsHUDActive then
						SendModRPCToServer(MOD_RPC[modname]["G"])
					end
				end)
				okita_handlers[6] = TheInput:AddKeyDownHandler(KEY_H, function()
					local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
            		local IsHUDActive = screen and screen.name == "HUD"
            		if inst:IsValid() and IsHUDActive then
						SendModRPCToServer(MOD_RPC[modname]["H"])
					end
				end)
			else
				okita_handlers[0] = nil
				okita_handlers[1] = nil
				okita_handlers[2] = nil
				okita_handlers[3] = nil
				okita_handlers[4] = nil
				okita_handlers[5] = nil
				okita_handlers[6] = nil
			end
		end
	end)
end)