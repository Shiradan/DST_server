local Text = require "widgets/text"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"

local ItemTile = Class(Widget, function(self, invitem, whichlistuse)
	Widget._ctor(self, "ItemTile")
	self.item = invitem

	local DEFAULT_ATLAS = "images/inventoryimages.xml"

	local name = tostring(invitem)
	local atlas = softresolvefilepath("images/inventoryimages/"..name..".xml") or softresolvefilepath("images/"..name..".xml") or DEFAULT_ATLAS
	local image = name .. ".tex"

	if whichlistuse == 7 then
		self.image = self:AddChild(Image(atlas, image, "blueprint.tex"))
	else
		self.image = self:AddChild(Image(DEFAULT_ATLAS, image, "blueprint.tex"))
	end


end)

function ItemTile:OnControl(control, down)
	self:UpdateTooltip()
	return false
end

function ItemTile:UpdateTooltip()
	local str = self:GetDescriptionString()
	self:SetTooltip(str)
end

function ItemTile:GetDescriptionString()

	local str = ""

	if self.item ~= nil and self.item ~= "" then
		local itemtip = string.upper(TrimString( self.item ))
		if STRINGS.NAMES[itemtip] ~= nil and STRINGS.NAMES[itemtip] ~= "" then
				str = STRINGS.NAMES[itemtip]
		end
	end

	if self.item == "moose" then
		str = STRINGS.NAMES.MOOSE2
	elseif self.item == "mooseegg" then
		str = STRINGS.NAMES.MOOSEEGG2
	end

	if str == "" then
		str = self.item
	end

	return str
end

function ItemTile:OnGainFocus()
	self:UpdateTooltip()
end

return ItemTile
