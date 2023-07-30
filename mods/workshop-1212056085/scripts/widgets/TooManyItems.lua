local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local TextButton = require "widgets/textbutton"
local Text = require "widgets/text"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Menu = require "widgets/menu"

local TMI_inventorybar = require "widgets/TMI_inventorybar"

local function SendCommand(fnstr)
	local x, y, z = TheSim:ProjectScreenPos(TheSim:GetPosition())
	local is_valid_time_to_use_remote = TheNet:GetIsClient() and TheNet:GetIsServerAdmin()
	if is_valid_time_to_use_remote then
		TheNet:SendRemoteExecute(fnstr, x, z)
	else
		ExecuteConsoleCommand(fnstr)
	end
end

local TooManyItems = Class(Widget, function(self)
	Widget._ctor(self, "TooManyItems")
	self.IsTooManyItemsMenuShow =false

	self.root = self:AddChild(Widget("ROOT"))
	self.root:SetVAnchor(ANCHOR_MIDDLE)
	self.root:SetHAnchor(ANCHOR_MIDDLE)
	self.root:SetPosition(0,0,0)
	self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)

	self.shield = self.root:AddChild( Image("images/ui.xml", "black.tex") )
	self.shield:SetScale(1,1,1)
	self.shield:SetPosition(-345,-50,0)
	self.shield:SetSize(350, 480)
	self.shield:SetTint(1,1,1,0.6)

	self.inv = self.shield:AddChild(TMI_inventorybar())
	self.inv:SetPosition(-127, 175, 0)

	self.cancelbutton = self.shield:AddChild(ImageButton("images/button_icons.xml", "delete.tex", "delete.tex", "delete.tex"))
	self.cancelbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.EMPTYBACKPACK)
	self.cancelbutton:SetPosition(110, -220, 0)
	self.cancelbutton:SetNormalScale(0.13)
	self.cancelbutton:SetFocusScale(0.15)
	self.cancelbutton:SetImageNormalColour(1,0.9,0.9,0.9)
	self.cancelbutton:SetImageFocusColour(1,0.1,0.1,0.9)
	self.cancelbutton:SetImageSelectedColour(1,0,0,0.9)
	self.cancelbutton:SetOnClick( function() SendCommand('local inventory = ThePlayer and ThePlayer.components.inventory or nil local backpack = inventory and inventory:GetOverflowContainer() or nil local backpackSlotCount = backpack and backpack:GetNumSlots() or 0 for i = 1, backpackSlotCount do local item = backpack:GetItemInSlot(i) or nil inventory:RemoveItem(item, true) end') end)

	self.cancelbutton = self.shield:AddChild(ImageButton("images/close.xml", "close.tex", "close.tex", "close.tex"))
	self.cancelbutton:SetTooltip(STRINGS.UI.OPTIONS.CLOSE)
	self.cancelbutton:SetPosition(155, -220, 0)
	self.cancelbutton:SetNormalScale(0.5)
	self.cancelbutton:SetFocusScale(0.6)
	self.cancelbutton:SetOnClick( function() self:Close() end)

	self.healthbutton = self.shield:AddChild(ImageButton("images/healthmeter.xml", "healthmeter.tex", "healthmeter.tex", "healthmeter.tex"))
	self.healthbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.HEALTH)
	self.healthbutton:SetPosition(-130, -185, 0)
	self.healthbutton:SetNormalScale(0.5)
	self.healthbutton:SetFocusScale(0.6)
	self.healthbutton:SetOnClick( function() self:HealthSet() end)

	self.sanitybutton = self.shield:AddChild(ImageButton("images/sanity.xml", "sanity.tex", "sanity.tex", "sanity.tex"))
	self.sanitybutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.SANITY)
	self.sanitybutton:SetPosition(-90, -185, 0)
	self.sanitybutton:SetNormalScale(0.5)
	self.sanitybutton:SetFocusScale(0.6)
	self.sanitybutton:SetOnClick( function() self:SanitySet() end)

	self.hungerbutton = self.shield:AddChild(ImageButton("images/hunger.xml", "hunger.tex", "hunger.tex", "hunger.tex"))
	self.hungerbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.HUNGER)
	self.hungerbutton:SetPosition(-50, -185, 0)
	self.hungerbutton:SetNormalScale(0.5)
	self.hungerbutton:SetFocusScale(0.6)
	self.hungerbutton:SetOnClick( function() self:HungerSet() end)

	self.moisturebutton = self.shield:AddChild(ImageButton("images/wetness_meter.xml", "wetness_meter.tex", "wetness_meter.tex", "wetness_meter.tex"))
	self.moisturebutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.WET)
	self.moisturebutton:SetPosition(-130, -220, 0)
	self.moisturebutton:SetNormalScale(0.5)
	self.moisturebutton:SetFocusScale(0.6)
	self.moisturebutton:SetOnClick( function() self:MoistureSet() end)

	self.temperaturebutton = self.shield:AddChild(ImageButton("images/thermal_measurer_build.xml", "thermal_measurer_build.tex", "thermal_measurer_build.tex", "thermal_measurer_build.tex"))
	self.temperaturebutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.TEMPERATURE)
	self.temperaturebutton:SetPosition(-90, -220, 0)
	self.temperaturebutton:SetNormalScale(0.5)
	self.temperaturebutton:SetFocusScale(0.6)
	self.temperaturebutton:SetOnClick( function() self:TemperatureSet() end)

	self.beavernessbutton = self.shield:AddChild(ImageButton("images/logmeter.xml", "logmeter.tex", "logmeter.tex", "logmeter.tex"))
	self.beavernessbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.LOGMETER)
	self.beavernessbutton:SetPosition(-50, -220, 0)
	self.beavernessbutton:SetNormalScale(0.5)
	self.beavernessbutton:SetFocusScale(0.6)
	self.beavernessbutton:SetOnClick( function() self:BeavernessSet() end)

	self.godmodebutton = self.shield:AddChild(ImageButton("images/godmode.xml", "godmode.tex", "godmode.tex", "godmode.tex"))
	self.godmodebutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.GODMODE)
	self.godmodebutton:SetPosition(5, -185, 0)
	self.godmodebutton:SetNormalScale(0.5)
	self.godmodebutton:SetFocusScale(0.6)
	self.godmodebutton:SetOnClick( function() self:GodMode() end)

	self.creativemodebutton = self.shield:AddChild(ImageButton("images/creativemode.xml", "creativemode.tex", "creativemode.tex", "creativemode.tex"))
	self.creativemodebutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.CREATIVEMODE)
	self.creativemodebutton:SetPosition(60, -185, 0)
	self.creativemodebutton:SetNormalScale(0.5)
	self.creativemodebutton:SetFocusScale(0.6)
	self.creativemodebutton:SetOnClick( function() self:CreativeMode() end)

	self.debugbutton = self.shield:AddChild(ImageButton("images/debug.xml", "debug.tex", "debug.tex", "debug.tex"))
	self.debugbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.BUTTON.DEBUGMENU)
	self.debugbutton:SetPosition(60, -220, 0)
	self.debugbutton:SetNormalScale(0.5)
	self.debugbutton:SetFocusScale(0.6)
	self.debugbutton:SetOnClick( function() self:DebugMenu() end)

	self.debugshield = self.root:AddChild( Image("images/ui.xml", "black.tex") )
	self.debugshield:SetScale(1,1,1)
	self.debugshield:SetPosition(55, -195, 0)
	self.debugshield:SetSize(450, 190)
	self.debugshield:SetTint(1,1,1,0.6)
	self.debugshield:Hide()
	self.debugshield.IsDebugMenuShow =false

	self.season = self.debugshield:AddChild(Text(NEWFONT, 30, STRINGS.UI.SERVERLISTINGSCREEN.SEASONFILTER))
	self.season:SetPosition(-160, 75, 0)

	self.springbutton = self.debugshield:AddChild(TextButton())
	self.springbutton:SetFont(NEWFONT)
	self.springbutton:SetText(STRINGS.UI.SERVERLISTINGSCREEN.SEASONS.SPRING)
	self.springbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SEASON.SPRINGTIP)
	self.springbutton:SetPosition(-60, 75, 0)
	self.springbutton:SetTextSize(24)
	self.springbutton:SetColour(0.9,0.8,0.6,1)
	self.springbutton:SetOnClick( function() SendCommand('TheWorld:PushEvent("ms_setseason", "spring")') end)

	self.summerbutton = self.debugshield:AddChild(TextButton())
	self.summerbutton:SetFont(NEWFONT)
	self.summerbutton:SetText(STRINGS.UI.SERVERLISTINGSCREEN.SEASONS.SUMMER)
	self.summerbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SEASON.SUMMERTIP)
	self.summerbutton:SetPosition(20, 75, 0)
	self.summerbutton:SetTextSize(24)
	self.summerbutton:SetColour(0.9,0.8,0.6,1)
	self.summerbutton:SetOnClick( function() SendCommand('TheWorld:PushEvent("ms_setseason", "summer")') end)

	self.autumnbutton = self.debugshield:AddChild(TextButton())
	self.autumnbutton:SetFont(NEWFONT)
	self.autumnbutton:SetText(STRINGS.UI.SERVERLISTINGSCREEN.SEASONS.AUTUMN)
	self.autumnbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SEASON.AUTUMNTIP)
	self.autumnbutton:SetPosition(100, 75, 0)
	self.autumnbutton:SetTextSize(24)
	self.autumnbutton:SetColour(0.9,0.8,0.6,1)
	self.autumnbutton:SetOnClick( function() SendCommand('TheWorld:PushEvent("ms_setseason", "autumn")') end)

	self.winterbutton = self.debugshield:AddChild(TextButton())
	self.winterbutton:SetFont(NEWFONT)
	self.winterbutton:SetText(STRINGS.UI.SERVERLISTINGSCREEN.SEASONS.WINTER)
	self.winterbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SEASON.WINTERTIP)
	self.winterbutton:SetPosition(180, 75, 0)
	self.winterbutton:SetTextSize(24)
	self.winterbutton:SetColour(0.9,0.8,0.6,1)
	self.winterbutton:SetOnClick( function() SendCommand('TheWorld:PushEvent("ms_setseason", "winter")') end)

	self.timecontrol = self.debugshield:AddChild(Text(NEWFONT, 30, STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.TEXT))
	self.timecontrol:SetPosition(-160, 45, 0)

	self.nextbutton = self.debugshield:AddChild(TextButton())
	self.nextbutton:SetFont(NEWFONT)
	self.nextbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.NEXT)
	self.nextbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.NEXTTIP)
	self.nextbutton:SetPosition(-60, 45, 0)
	self.nextbutton:SetTextSize(24)
	self.nextbutton:SetColour(0.9,0.8,0.6,1)
	self.nextbutton:SetOnClick( function() SendCommand('TheWorld:PushEvent("ms_nextphase")') end)

	self.skip1daybutton = self.debugshield:AddChild(TextButton())
	self.skip1daybutton:SetFont(NEWFONT)
	self.skip1daybutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.ODAY)
	self.skip1daybutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.ODAYTIP)
	self.skip1daybutton:SetPosition(20, 45, 0)
	self.skip1daybutton:SetTextSize(24)
	self.skip1daybutton:SetColour(0.9,0.8,0.6,1)
	self.skip1daybutton:SetOnClick( function() SendCommand('c_skip(1)') end)

	self.skip5daybutton = self.debugshield:AddChild(TextButton())
	self.skip5daybutton:SetFont(NEWFONT)
	self.skip5daybutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.FDAYS)
	self.skip5daybutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.FDAYSTIP)
	self.skip5daybutton:SetPosition(100, 45, 0)
	self.skip5daybutton:SetTextSize(24)
	self.skip5daybutton:SetColour(0.9,0.8,0.6,1)
	self.skip5daybutton:SetOnClick( function() SendCommand('c_skip(5)') end)

	self.skip10daybutton = self.debugshield:AddChild(TextButton())
	self.skip10daybutton:SetFont(NEWFONT)
	self.skip10daybutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.TDAYS)
	self.skip10daybutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME.TDAYSTIP)
	self.skip10daybutton:SetPosition(180, 45, 0)
	self.skip10daybutton:SetTextSize(24)
	self.skip10daybutton:SetColour(0.9,0.8,0.6,1)
	self.skip10daybutton:SetOnClick( function() SendCommand('c_skip(10)') end)

	self.speedcontrol = self.debugshield:AddChild(Text(NEWFONT, 30, STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.TEXT))
	self.speedcontrol:SetPosition(-160, 15, 0)

	self.slowbutton = self.debugshield:AddChild(TextButton())
	self.slowbutton:SetFont(NEWFONT)
	self.slowbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.SLOW)
	self.slowbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.SLOWTIP)
	self.slowbutton:SetPosition(-60, 15, 0)
	self.slowbutton:SetTextSize(24)
	self.slowbutton:SetColour(0.9,0.8,0.6,1)
	self.slowbutton:SetOnClick( function() SendCommand('c_speedmult(0.6)') end)

	self.normalspeedbutton = self.debugshield:AddChild(TextButton())
	self.normalspeedbutton:SetFont(NEWFONT)
	self.normalspeedbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.NORMAL)
	self.normalspeedbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.NORMALTIP)
	self.normalspeedbutton:SetPosition(20, 15, 0)
	self.normalspeedbutton:SetTextSize(24)
	self.normalspeedbutton:SetColour(0.9,0.8,0.6,1)
	self.normalspeedbutton:SetOnClick( function() SendCommand('c_speedmult(1)') end)

	self.fastbutton = self.debugshield:AddChild(TextButton())
	self.fastbutton:SetFont(NEWFONT)
	self.fastbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.FAST)
	self.fastbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.FASTTIP)
	self.fastbutton:SetPosition(100, 15, 0)
	self.fastbutton:SetTextSize(24)
	self.fastbutton:SetColour(0.9,0.8,0.6,1)
	self.fastbutton:SetOnClick( function() SendCommand('c_speedmult(2)') end)

	self.flybutton = self.debugshield:AddChild(TextButton())
	self.flybutton:SetFont(NEWFONT)
	self.flybutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.FLY)
	self.flybutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED.FLYTIP)
	self.flybutton:SetPosition(180, 15, 0)
	self.flybutton:SetTextSize(24)
	self.flybutton:SetColour(0.9,0.8,0.6,1)
	self.flybutton:SetOnClick( function() SendCommand('c_speedmult(4)') end)

	self.weathercontrol = self.debugshield:AddChild(Text(NEWFONT, 30, STRINGS.TOO_MANY_ITEMS.UI.DEBUG.WEATHER.TEXT))
	self.weathercontrol:SetPosition(-150, -15, 0)

	self.lightningstrikebutton = self.debugshield:AddChild(TextButton())
	self.lightningstrikebutton:SetFont(NEWFONT)
	self.lightningstrikebutton:SetText(STRINGS.UI.CUSTOMIZATIONSCREEN.LIGHTNING)
	self.lightningstrikebutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.WEATHER.LIGHTNINGTIP)
	self.lightningstrikebutton:SetPosition(-30, -15, 0)
	self.lightningstrikebutton:SetTextSize(24)
	self.lightningstrikebutton:SetColour(0.9,0.8,0.6,1)
	self.lightningstrikebutton:SetOnClick( function() SendCommand('TheWorld:PushEvent("ms_sendlightningstrike", Vector3(ThePlayer.Transform:GetWorldPosition()))') end)

	self.pushprecipitationbutton = self.debugshield:AddChild(TextButton())
	self.pushprecipitationbutton:SetFont(NEWFONT)
	self.pushprecipitationbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.WEATHER.WATER)
	self.pushprecipitationbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.WEATHER.WATERTIP)
	self.pushprecipitationbutton:SetPosition(80, -15, 0)
	self.pushprecipitationbutton:SetTextSize(24)
	self.pushprecipitationbutton:SetColour(0.9,0.8,0.6,1)
	self.pushprecipitationbutton:SetOnClick( function() SendCommand('TheWorld:PushEvent("ms_forceprecipitation", true)') end)

	self.stopprecipitationbutton = self.debugshield:AddChild(TextButton())
	self.stopprecipitationbutton:SetFont(NEWFONT)
	self.stopprecipitationbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.WEATHER.NOWATER)
	self.stopprecipitationbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.WEATHER.NOWATERTIP)
	self.stopprecipitationbutton:SetPosition(180, -15, 0)
	self.stopprecipitationbutton:SetTextSize(24)
	self.stopprecipitationbutton:SetColour(0.9,0.8,0.6,1)
	self.stopprecipitationbutton:SetOnClick( function() SendCommand('TheWorld:PushEvent("ms_forceprecipitation", false)') end)

	self.charactercontrol = self.debugshield:AddChild(Text(NEWFONT, 30, STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.TEXT))
	self.charactercontrol:SetPosition(-180, -45, 0)

	self.killbutton = self.debugshield:AddChild(TextButton())
	self.killbutton:SetFont(NEWFONT)
	self.killbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.KILL)
	self.killbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.KILLTIP)
	self.killbutton:SetPosition(-105, -45, 0)
	self.killbutton:SetTextSize(24)
	self.killbutton:SetColour(0.9,0.8,0.6,1)
	self.killbutton:SetOnClick( function() SendCommand('ThePlayer:PushEvent("death")') end)

	self.rebirthbutton = self.debugshield:AddChild(TextButton())
	self.rebirthbutton:SetFont(NEWFONT)
	self.rebirthbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTERREBIRTH)
	self.rebirthbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.REBIRTHTIP)
	self.rebirthbutton:SetPosition(-50, -45, 0)
	self.rebirthbutton:SetTextSize(24)
	self.rebirthbutton:SetColour(0.9,0.8,0.6,1)
	self.rebirthbutton:SetOnClick( function() SendCommand('ThePlayer:PushEvent("respawnfromghost")') end)

	self.despawnbutton = self.debugshield:AddChild(TextButton())
	self.despawnbutton:SetFont(NEWFONT)
	self.despawnbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.DESPAWN)
	self.despawnbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.DESPAWNTIP)
	self.despawnbutton:SetPosition(20, -45, 0)
	self.despawnbutton:SetTextSize(24)
	self.despawnbutton:SetColour(0.9,0.8,0.6,1)
	self.despawnbutton:SetOnClick( function() SendCommand('c_despawn()') end)

	self.gatherbutton = self.debugshield:AddChild(TextButton())
	self.gatherbutton:SetFont(NEWFONT)
	self.gatherbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.GATHER)
	self.gatherbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.GATHERTIP)
	self.gatherbutton:SetPosition(95, -45, 0)
	self.gatherbutton:SetTextSize(24)
	self.gatherbutton:SetColour(0.9,0.8,0.6,1)
	self.gatherbutton:SetOnClick( function() SendCommand('local x,y,z = ThePlayer.Transform:GetWorldPosition() for k,v in pairs(AllPlayers) do v.Transform:SetPosition(x,y,z) end') end)

	self.unlocktechbutton = self.debugshield:AddChild(TextButton())
	self.unlocktechbutton:SetFont(NEWFONT)
	self.unlocktechbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.UNLOCKTECH)
	self.unlocktechbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER.UNLOCKTECHTIP)
	self.unlocktechbutton:SetPosition(180, -45, 0)
	self.unlocktechbutton:SetTextSize(24)
	self.unlocktechbutton:SetColour(0.9,0.8,0.6,1)
	self.unlocktechbutton:SetOnClick( function() SendCommand('ThePlayer.components.builder:UnlockRecipesForTech({SCIENCE = 2, MAGIC = 2})') end)

	self.servercontrol = self.debugshield:AddChild(Text(NEWFONT, 30, STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.TEXT))
	self.servercontrol:SetPosition(-180, -75, 0)

	self.resetbutton = self.debugshield:AddChild(TextButton())
	self.resetbutton:SetFont(NEWFONT)
	self.resetbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.RESET)
	self.resetbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.RESETTIP)
	self.resetbutton:SetPosition(-100, -75, 0)
	self.resetbutton:SetTextSize(24)
	self.resetbutton:SetColour(0.9,0.8,0.6,1)
	self.resetbutton:SetOnClick( function() SendCommand('c_reset(true)') end)

	self.regenerateworldbutton = self.debugshield:AddChild(TextButton())
	self.regenerateworldbutton:SetFont(NEWFONT)
	self.regenerateworldbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.REGENERATE)
	self.regenerateworldbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.REGENERATETIP)
	self.regenerateworldbutton:SetPosition(-20, -75, 0)
	self.regenerateworldbutton:SetTextSize(24)
	self.regenerateworldbutton:SetColour(0.9,0.8,0.6,1)
	self.regenerateworldbutton:SetOnClick( function() SendCommand('c_regenerateworld()') end)

	self.rollbackbutton = self.debugshield:AddChild(TextButton())
	self.rollbackbutton:SetFont(NEWFONT)
	self.rollbackbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.ROLLBACK)
	self.rollbackbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.ROLLBACKTIP)
	self.rollbackbutton:SetPosition(60, -75, 0)
	self.rollbackbutton:SetTextSize(24)
	self.rollbackbutton:SetColour(0.9,0.8,0.6,1)
	self.rollbackbutton:SetOnClick( function() SendCommand('c_rollback()') end)

	self.savebutton = self.debugshield:AddChild(TextButton())
	self.savebutton:SetFont(NEWFONT)
	self.savebutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.SAVE)
	self.savebutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.SAVETIP)
	self.savebutton:SetPosition(120, -75, 0)
	self.savebutton:SetTextSize(24)
	self.savebutton:SetColour(0.9,0.8,0.6,1)
	self.savebutton:SetOnClick( function() SendCommand('c_save()') end)

	self.shutdownbutton = self.debugshield:AddChild(TextButton())
	self.shutdownbutton:SetFont(NEWFONT)
	self.shutdownbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.SHUTDOWN)
	self.shutdownbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER.SHUTDOWNTIP)
	self.shutdownbutton:SetPosition(180, -75, 0)
	self.shutdownbutton:SetTextSize(24)
	self.shutdownbutton:SetColour(0.9,0.8,0.6,1)
	self.shutdownbutton:SetOnClick( function() if TheNet:GetIsClient() then SendCommand('if TheNet:GetIsServer() and TheNet:GetServerIsDedicated() then c_shutdown(true) end') end end)

end)

function TooManyItems:HealthSet()
	local fnstr = "c_sethealth(1)"
	SendCommand(fnstr)
end

function TooManyItems:SanitySet()
	local fnstr = "c_setsanity(1)"
	SendCommand(fnstr)
end

function TooManyItems:HungerSet()
	local fnstr = "c_sethunger(1)"
	SendCommand(fnstr)
end

function TooManyItems:MoistureSet()
	local fnstr = "c_setmoisture(0)"
	SendCommand(fnstr)
end

function TooManyItems:TemperatureSet()
	local fnstr = "c_settemperature(20)"
	SendCommand(fnstr)
end

function TooManyItems:BeavernessSet()
	local fnstr = "c_setbeaverness(1)"
	SendCommand(fnstr)
end

function TooManyItems:GodMode()
	local fnstr = "c_supergodmode()"
	SendCommand(fnstr)
end

function TooManyItems:CreativeMode()
	local fnstr = "ThePlayer.components.builder:GiveAllRecipes()"
	SendCommand(fnstr)
end

function TooManyItems:DebugMenu()
	if self.debugshield.IsDebugMenuShow then
		self.debugshield:Hide()
		self.debugshield.IsDebugMenuShow =false
	else
		self.debugshield:Show()
		self.debugshield.IsDebugMenuShow =true
	end
end

function TooManyItems:Close()
	self:Hide()
	self.IsTooManyItemsMenuShow =false
end

function TooManyItems:OnControl(control, down)
	if TooManyItems._base.OnControl(self,control, down) then
		return true
	end

	if not down then
		if control == CONTROL_PAUSE or control == CONTROL_CANCEL then
			self:Close()
		end
	end

	return true
end

return TooManyItems
