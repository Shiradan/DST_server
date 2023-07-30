if GLOBAL.TheNet:GetIsServer() and GLOBAL.TheNet:GetServerIsDedicated() then return end
if GLOBAL.TheNet:GetIsClient() and not GLOBAL.TheNet:GetIsServerAdmin() then return end

Assets =
{
	Asset("IMAGE", "images/healthmeter.tex"),
	Asset("ATLAS", "images/healthmeter.xml"),
	Asset("IMAGE", "images/sanity.tex"),
	Asset("ATLAS", "images/sanity.xml"),
	Asset("IMAGE", "images/hunger.tex"),
	Asset("ATLAS", "images/hunger.xml"),
	Asset("IMAGE", "images/logmeter.tex"),
	Asset("ATLAS", "images/logmeter.xml"),
	Asset("IMAGE", "images/wetness_meter.tex"),
	Asset("ATLAS", "images/wetness_meter.xml"),
	Asset("IMAGE", "images/thermal_measurer_build.tex"),
	Asset("ATLAS", "images/thermal_measurer_build.xml"),
	Asset("ATLAS", "images/close.xml"),
	Asset("IMAGE", "images/close.tex"),
	Asset("ATLAS", "images/creativemode.xml"),
	Asset("IMAGE", "images/creativemode.tex"),
	Asset("ATLAS", "images/godmode.xml"),
	Asset("IMAGE", "images/godmode.tex"),
	Asset("ATLAS", "images/debug.xml"),
	Asset("IMAGE", "images/debug.tex"),
}

---------------Load Cofig
local function GetConfig(s,default)
	local c=GetModConfigData(s)
	if c==nil then
		c=default
	end
	if type(c)=="table" then
		c=c.option_data
	end
	return c
end

GLOBAL.TooManyItems_KEYBOARD_TOGGLE_KEY = GetConfig("KEYBOARD_TOGGLE_KEY", 116)
GLOBAL.TooManyItems_TMI_L_CLICK_NUM = GetConfig("TMI_L_CLICK_NUM", 1)
GLOBAL.TooManyItems_TMI_R_CLICK_NUM = GetConfig("TMI_R_CLICK_NUM", 10)

_G=GLOBAL
STRINGS = _G.STRINGS
STRINGS.TOO_MANY_ITEMS = {}
STRINGS.TOO_MANY_ITEMS.UI = {}
STRINGS.TOO_MANY_ITEMS.UI.BUTTON = {}
STRINGS.TOO_MANY_ITEMS.UI.DEBUG = {}
STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SEASON = {}
STRINGS.TOO_MANY_ITEMS.UI.DEBUG.TIME = {}
STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SPEED = {}
STRINGS.TOO_MANY_ITEMS.UI.DEBUG.WEATHER = {}
STRINGS.TOO_MANY_ITEMS.UI.DEBUG.CHARACTER = {}
STRINGS.TOO_MANY_ITEMS.UI.DEBUG.SERVER = {}
STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR = {}
STRINGS.TOO_MANY_ITEMS.UI.SEARCHBAR = {}
STRINGS.TOO_MANY_ITEMS.UI.SEARCH = {}
modimport("Stringslocalization.lua")

local function IsDefaultScreen()
	if GLOBAL.TheFrontEnd:GetActiveScreen() and GLOBAL.TheFrontEnd:GetActiveScreen().name and type(GLOBAL.TheFrontEnd:GetActiveScreen().name) == "string" and GLOBAL.TheFrontEnd:GetActiveScreen().name == "HUD" then
		return true
	else
		return false
	end
end

local TMI = GLOBAL.require "widgets/TooManyItems"

local function ShowTMIMenu()
	-- Useless.
	--if GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and GLOBAL.ThePlayer.HUD:IsChatInputScreenOpen() then return end

	if GLOBAL.ThePlayer and type(GLOBAL.ThePlayer) == "table" and GLOBAL.ThePlayer.HUD and type(GLOBAL.ThePlayer.HUD) == "table" and IsDefaultScreen() then
		if (controls or controls.containerroot) and controls.TMI then
			if controls.TMI.IsTooManyItemsMenuShow then
				controls.TMI:Hide()
				controls.TMI.IsTooManyItemsMenuShow = false
			else
				controls.TMI:Show()
				controls.TMI.IsTooManyItemsMenuShow = true
			end
		else
			print("[TooManyItems] Menu can not show!")
			return
		end
	end

end

local function AddTMI(self)
	controls = self -- this just makes controls available in the rest of the modmain's functions

	if controls then
		if controls.containerroot then
			controls.TMI = controls.containerroot:AddChild(TMI())
		else
			controls.TMI = controls:AddChild(TMI())
		end
	else
		print("[TooManyItems] AddClassPostConstruct errors!")
		return
	end

	controls.TMI:Hide()
	controls.TMI.IsTooManyItemsMenuShow = false

end

AddClassPostConstruct( "widgets/controls", AddTMI )
GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.TooManyItems_KEYBOARD_TOGGLE_KEY, ShowTMIMenu)
