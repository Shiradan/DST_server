require "util"
local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local TextButton = require "widgets/textbutton"
local TextEdit = require "widgets/textedit"

local SearchScreen = Class(Screen, function(self, owner)
	Screen._ctor(self, "SearchScreen")
	self.owner = owner
	self.runtask = nil
	self:DoInit()
end)

function SearchScreen:OnBecomeActive()
	SearchScreen._base.OnBecomeActive(self)
	self.owner.searchhelptip:Hide()
	self.chat_edit:SetFocus()
	self.chat_edit:SetEditing(true)
	TheFrontEnd:LockFocus(true)
end

function SearchScreen:OnBecomeInactive()
	SearchScreen._base.OnBecomeInactive(self)

	if self.runtask ~= nil then
		self.runtask:Cancel()
		self.runtask = nil
	end
end

function SearchScreen:OnControl(control, down)
	if self.runtask ~= nil or SearchScreen._base.OnControl(self, control, down) then return true end

	--jcheng: don't allow debug menu stuff going on right now
	if control == CONTROL_OPEN_DEBUG_CONSOLE then
		return true
	end

	if not down and (control == CONTROL_CANCEL ) then
		self:Close()
		return true
	end
end

function SearchScreen:OnRawKey(key, down)
	if self.runtask ~= nil or SearchScreen._base.OnRawKey(self, key, down) then return true end

	if down then return end

	return true
end

function SearchScreen:Run()
	local chat_string = self.chat_edit:GetString()
	if chat_string == "" then
		self.owner:ShowItems()
		self.owner.searchhelptiptext:SetString("")
		self.owner.searchhelptip:SetColour(0.9,0.8,0.6,1)
		self.owner.searchhelptip:SetOverColour(0.9,0.8,0.6,1)
	else
		self.owner:SearchItemsinList(string.lower(TrimString(chat_string)))
		self.owner.searchhelptiptext:SetString(chat_string)
		self.owner.searchhelptip:SetColour(0.9,0.8,0.6,0)
		self.owner.searchhelptip:SetOverColour(0.9,0.8,0.6,0)
	end

end

function SearchScreen:Close()
	--SetPause(false)
	self.owner.searchhelptip:Show()
	TheInput:EnableDebugToggle(true)
	TheFrontEnd:PopScreen(self)
end

local function DoRun(inst, self)
	self.runtask = nil
	self:Run()
	self:Close()
end

function SearchScreen:OnTextEntered()
	if self.runtask ~= nil then
		self.runtask:Cancel()
	end
	self.runtask = self.inst:DoTaskInTime(0, DoRun, self)
end

function SearchScreen:DoInit()
	--SetPause(true,"console")
	TheInput:EnableDebugToggle(false)

	local label_width = 200
	local label_height = 50
	local label_offset = 450

	local space_between = 30
	local height_offset = -270

	local fontsize = 30

	local edit_width = 850
	local chat_type_width = 150
	local edit_bg_padding = 100

	self.root = self:AddChild(Widget("chat_input_root"))
	self.root:SetHAnchor(ANCHOR_MIDDLE)
	self.root:SetVAnchor(ANCHOR_MIDDLE)
	self.root = self.root:AddChild(Widget(""))
	self.root:SetPosition(0,0,0)

	self.chat_edit = self.root:AddChild( TextEdit( NEWFONT, 32, "" ) )--DEFAULTFONT, fontsize, "" ) )
	self.chat_edit:SetPosition(-395, 180, 0)
	self.chat_edit:SetIdleTextColour(0.9,0.8,0.6,1)
	self.chat_edit:SetEditTextColour(1,1,1,1)
	self.chat_edit:SetEditCursorColour(1,1,1,1)
	self.chat_edit:SetRegionSize( 250, 36 )
	self.chat_edit:SetHAlign(ANCHOR_LEFT)
	self.chat_edit.OnTextEntered = function() self:OnTextEntered() end
	self.chat_edit:SetPassControlToScreen(CONTROL_CANCEL, true)
	self.chat_edit:SetPassControlToScreen(CONTROL_MENU_MISC_2, true) -- toggle between say and whisper
	self.chat_edit:SetForceEdit(true)
	self.chat_edit:SetTextLengthLimit(200)

end

return SearchScreen
