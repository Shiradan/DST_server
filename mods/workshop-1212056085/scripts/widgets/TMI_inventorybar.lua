local TileBG = require "widgets/tilebg"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local Text = require "widgets/text"
local AnimButton = require "widgets/animbutton"
local TextButton = require "widgets/textbutton"
local ImageButton = require "widgets/imagebutton"

local TMI_InvSlot = require "widgets/TMI_Invslot"
local TMI_ItemTile = require "widgets/TMI_Itemtile"
local SearchScreen = require "screens/searchscreen"

local HUD_ATLAS = "images/hud.xml"
local NUM_COLUMS = 7
local MAX_ROWS = 8
local MAXSLOTS = NUM_COLUMS * MAX_ROWS

require "itemlist"

local Inv = Class(Widget, function(self, owner)
	Widget._ctor(self, "TMI_Inventory")
	self.whichlistuse = 0
	self.owner = owner
	self.base_scale = .6
	self.selected_scale = .8
	self:SetScale(self.base_scale)

	self.sideshield = self:AddChild( Image("images/ui.xml", "black.tex") )
	self.sideshield:SetTint(1,1,1,0)
	self.sideshield:SetScale(1,1,1)
	self.sideshield:SetPosition(-57, -266, 0)
	self.sideshield:SetSize(40, 600)

	self.sideAbutton = self.sideshield:AddChild(TextButton())
	self.sideAbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.A)
	self.sideAbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.TIPA)
	self.sideAbutton:SetFont(NEWFONT)
	self.sideAbutton:SetColour(0.9,0.8,0.6,1)
	self.sideAbutton:SetPosition(0, 300, 0)
	self.sideAbutton:SetTextSize(40)
	self.sideAbutton:SetOnClick( function() self:NormalItems() end)

	self.sideFbutton = self.sideshield:AddChild(TextButton())
	self.sideFbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.F)
	self.sideFbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.TIPF)
	self.sideFbutton:SetFont(NEWFONT)
	self.sideFbutton:SetColour(0.9,0.8,0.6,1)
	self.sideFbutton:SetPosition(0, 210, 0)
	self.sideFbutton:SetTextSize(40)
	self.sideFbutton:SetOnClick( function() self:FoodsItems() end)

	self.sideRbutton = self.sideshield:AddChild(TextButton())
	self.sideRbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.R)
	self.sideRbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.TIPR)
	self.sideRbutton:SetFont(NEWFONT)
	self.sideRbutton:SetColour(0.9,0.8,0.6,1)
	self.sideRbutton:SetPosition(0, 110, 0)
	self.sideRbutton:SetTextSize(40)
	self.sideRbutton:SetOnClick( function() self:ResourcesItems() end)

	self.sideWbutton = self.sideshield:AddChild(TextButton())
	self.sideWbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.W)
	self.sideWbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.TIPW)
	self.sideWbutton:SetFont(NEWFONT)
	self.sideWbutton:SetColour(0.9,0.8,0.6,1)
	self.sideWbutton:SetPosition(0, 10, 0)
	self.sideWbutton:SetTextSize(40)
	self.sideWbutton:SetOnClick( function() self:WeaponsItems() end)

	self.sideTbutton = self.sideshield:AddChild(TextButton())
	self.sideTbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.T)
	self.sideTbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.TIPT)
	self.sideTbutton:SetFont(NEWFONT)
	self.sideTbutton:SetColour(0.9,0.8,0.6,1)
	self.sideTbutton:SetPosition(0, -90, 0)
	self.sideTbutton:SetTextSize(40)
	self.sideTbutton:SetOnClick( function() self:ToolsItems() end)

	self.sideCbutton = self.sideshield:AddChild(TextButton())
	self.sideCbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.C)
	self.sideCbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.TIPC)
	self.sideCbutton:SetFont(NEWFONT)
	self.sideCbutton:SetColour(0.9,0.8,0.6,1)
	self.sideCbutton:SetPosition(0, -190, 0)
	self.sideCbutton:SetTextSize(40)
	self.sideCbutton:SetOnClick( function() self:ClothesItems() end)

	self.sideObutton = self.sideshield:AddChild(TextButton())
	self.sideObutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.G)
	self.sideObutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.TIPG)
	self.sideObutton:SetFont(NEWFONT)
	self.sideObutton:SetColour(0.9,0.8,0.6,1)
	self.sideObutton:SetPosition(0, -290, 0)
	self.sideObutton:SetTextSize(40)
	self.sideObutton:SetOnClick( function() self:GiftsItems() end)

	self.sideBbutton = self.sideshield:AddChild(TextButton())
	self.sideBbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.O)
	self.sideBbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SIDEBAR.TIPO)
	self.sideBbutton:SetFont(NEWFONT)
	self.sideBbutton:SetColour(0.9,0.8,0.6,1)
	self.sideBbutton:SetPosition(0, -390, 0)
	self.sideBbutton:SetTextSize(40)
	self.sideBbutton:SetOnClick( function() self:OthersItems() end)

	self.searchshield = self:AddChild( Image("images/ui.xml", "black.tex") )
	self.searchshield:SetScale(1,1,1)
	self.searchshield:SetPosition(228, 70, 0)
	self.searchshield:SetSize(520, 60)
	self.searchshield:SetTint(1,1,1,0.2)

	self.searchhelptip = self.searchshield:AddChild(TextButton())
	self.searchhelptip:SetText(STRINGS.TOO_MANY_ITEMS.UI.SEARCHBAR.TEXT)
	self.searchhelptip:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SEARCHBAR.TIP)
	self.searchhelptip:SetFont(NEWFONT)
	self.searchhelptip:SetColour(0.9,0.8,0.6,1)
	self.searchhelptip:SetPosition(-80, 0, 0)
	self.searchhelptip:SetTextSize(50)
	self.searchhelptip.text:SetRegionSize(352, 44)
	self.searchhelptip.image:SetSize(352, 44)
	self.searchhelptip:SetOnClick( function() self:PreSearch() end)

	self.searchhelptiptext = self.searchshield:AddChild(Text(NEWFONT, 50))
	self.searchhelptiptext:SetString("")
	self.searchhelptiptext:SetVAlign(ANCHOR_LEFT)
	--self.searchhelptiptext:SetRegionSize(350, 44)
	self.searchhelptiptext:SetColour(0.9,0.8,0.6,1)
	self.searchhelptiptext:SetPosition(-180, 0, 0)

	self.searchbarbutton = self.searchshield:AddChild(TextButton())
	self.searchbarbutton:SetPosition(210, 0, 0)
	self.searchbarbutton:SetFont(NEWFONT)
	self.searchbarbutton:SetColour(0.9,0.8,0.6,1)
	self.searchbarbutton:SetText(STRINGS.TOO_MANY_ITEMS.UI.SEARCH.TEXT)
	self.searchbarbutton:SetTooltip(STRINGS.TOO_MANY_ITEMS.UI.SEARCH.TIP)
	self.searchbarbutton:SetTextSize(50)
	self.searchbarbutton:SetOnClick( function() if self.searchbar then self.searchbar:OnTextEntered() end end)

	self.slots = self:AddChild(Widget("SLOTS"))

	self.fullstrItems = {}

	if ITEMLIST and ITEMLIST ~= nil then
		for k,v in pairs(ITEMLIST) do
			if not contains(self.fullstrItems, v) and not string.find(v, "blueprint") then
				table.insert(self.fullstrItems, v)
			end
		end
	end

	self.foodsstritems = {}

	if FOODSITEMLIST and FOODSITEMLIST ~= nil then
		for k,v in pairs(FOODSITEMLIST) do
			if not contains(self.foodsstritems, v) then
				table.insert(self.foodsstritems, v)
			end
		end
	end

	self.resourcesstritems = {}

	if RESOURCESITEMLIST and RESOURCESITEMLIST ~= nil then
		for k,v in pairs(RESOURCESITEMLIST) do
			if not contains(self.resourcesstritems, v) then
				table.insert(self.resourcesstritems, v)
			end
		end
	end

	self.weaponsstritems = {}

	if WEAPONSITEMLIST and WEAPONSITEMLIST ~= nil then
		for k,v in pairs(WEAPONSITEMLIST) do
			if not contains(self.weaponsstritems, v) then
				table.insert(self.weaponsstritems, v)
			end
		end
	end

	self.toolsstritems = {}

	if TOOLSITEMLIST and TOOLSITEMLIST ~= nil then
		for k,v in pairs(TOOLSITEMLIST) do
			if not contains(self.toolsstritems, v) and not string.find(v, "blueprint") then
				table.insert(self.toolsstritems, v)
			end
		end
	end

	self.clothesliststritems = {}

	if CLOTHESLIST and CLOTHESLIST ~= nil then
		for k,v in pairs(CLOTHESLIST) do
			if not contains(self.clothesliststritems, v) and not string.find(v, "blueprint") then
				table.insert(self.clothesliststritems, v)
			end
		end
	end

	self.giftsstritems = {}

	if GIFTSLIST and GIFTSLIST ~= nil then
		for k,v in pairs(GIFTSLIST) do
			if not contains(self.giftsstritems, v) and not string.find(v, "blueprint") then
				table.insert(self.giftsstritems, v)
			end
		end
	end

	self.othersstritems = {}

	self.skinprefabs = {}
	for k, v in pairs(PREFAB_SKINS) do
		if type(v) == "table" then
			for kk, vv in pairs(v) do
				table.insert(self.skinprefabs, vv)
			end
		end
	end

	if self.fullstrItems and self.fullstrItems ~= nil then
		for k, v in pairs(Prefabs) do
			local can_spawn = not string.find(v.name, "blueprint") and not string.find(v.name, "MOD") and not contains(self.othersstritems, v.name) and not contains(self.fullstrItems, v.name) and not contains(self.skinprefabs, v.name)
			if v.name == "forest" or v.name == "cave" or v.name == "frontend" or v.name == "global" or v.name == "hud" or v.name == "wprld" then can_spawn = false end
			if can_spawn then
				table.insert(self.othersstritems, v.name)
			end
		end
	end

	self.menu = self:AddChild(Widget("MENU"))
	self.menu:SetPosition(225, -0, 0)

	self.prevbutton = self.menu:AddChild(ImageButton("images/ui.xml", "arrow2_left.tex", "arrow2_left_over.tex", "arrow_left2_disabled.tex"))
	self.prevbutton:SetPosition(175, -600, 0)
	self.prevbutton:SetNormalScale(0.7)
	self.prevbutton:SetFocusScale(0.8)
	self.prevbutton:SetTooltip(STRINGS.UI.HELP.PREVPAGE)
	self.prevbutton:SetOnClick( function() self:Scroll(-1) end)
	self.prevbutton:Hide()

	self.nextbutton = self.menu:AddChild(ImageButton("images/ui.xml", "arrow2_right.tex", "arrow2_right_over.tex", "arrow2_right_disabled.tex"))
	self.nextbutton:SetPosition(235, -600, 0)
	self.nextbutton:SetNormalScale(0.7)
	self.nextbutton:SetFocusScale(0.8)
	self.nextbutton:SetTooltip(STRINGS.UI.HELP.NEXTPAGE)
	self.nextbutton:SetOnClick( function() self:Scroll(1) end)

	self.pagetext = self.menu:AddChild(Text(NEWFONT_OUTLINE, 50))
	self.pagetext:SetString("")
	-- self.pagetext:SetTooltip("Current Page/Max Pages")
	self.pagetext:SetColour(1,1,1,0.6)
	self.pagetext:SetPosition(0, -660, 0)

	self:NormalItems()

end)

function Inv:PreSearch()
	if self.searchbar then
		self.searchbar = nil
	end
	self.searchbar = self.searchshield:AddChild(SearchScreen(self, self))
	self.searchbar.chat_edit:SetString(self.searchhelptiptext:GetString())
	self.searchhelptiptext:SetString("")
	TheFrontEnd:PushScreen(self.searchbar)
end

function Inv:NormalItems()
	self.whichlistuse = 0
	self:ShowItems()
end

function Inv:FoodsItems()
	self.whichlistuse = 1
	self:ShowItems()
end

function Inv:ResourcesItems()
	self.whichlistuse = 2
	self:ShowItems()
end

function Inv:WeaponsItems()
	self.whichlistuse = 3
	self:ShowItems()
end

function Inv:ToolsItems()
	self.whichlistuse = 4
	self:ShowItems()
end

function Inv:ClothesItems()
	self.whichlistuse = 5
	self:ShowItems()
end

function Inv:GiftsItems()
	self.whichlistuse = 6
	self:ShowItems()
end

function Inv:OthersItems()
	self.whichlistuse = 7
	self:ShowItems()
end


function Inv:ShowItems()

	local truelistnum = self.whichlistuse or 0
	local list = {}
	local switch={}
	switch[0]=function() list = self.fullstrItems end
	switch[1]=function() list = self.foodsstritems end
	switch[2]=function() list = self.resourcesstritems end
	switch[3]=function() list = self.weaponsstritems end
	switch[4]=function() list = self.toolsstritems end
	switch[5]=function() list = self.clothesliststritems end
	switch[6]=function() list = self.giftsstritems end
	switch[7]=function() list = self.othersstritems end

	if truelistnum >= 0 and truelistnum <= 7 then
		switch[truelistnum]()
	end


	self.inventory = {}
	self.maxpages = 0
	self.currentpage = 0

	local i = 0
	for k,v in pairs(list) do
		self.inventory[i] = v
		i = i + 1
	end

	table.sort(self.inventory, function(a,b) return a < b end)
	table.insert(self.inventory, self.inventory[#self.inventory])

	-- For debug!
	--[[
	print("NOW USE LIST :"..tostring(truelistnum))
	for k,v in pairs(self.inventory) do
		print('"'..v..'",')
	end
	--]]

	self.rebuild_pending = true
	self:Rebuild()
end


function Inv:SearchItemsinList(itemname)

	local truelistnum = self.whichlistuse or 0
	local list = {}
	local switch={}
	switch[0]=function() list = self.fullstrItems end
	switch[1]=function() list = self.foodsstritems end
	switch[2]=function() list = self.resourcesstritems end
	switch[3]=function() list = self.weaponsstritems end
	switch[4]=function() list = self.toolsstritems end
	switch[5]=function() list = self.clothesliststritems end
	switch[6]=function() list = self.giftsstritems end
	switch[7]=function() list = self.othersstritems end

	if truelistnum >= 0 and truelistnum <= 7 then
		switch[truelistnum]()
	end

	self.inventory = {}
	self.maxpages = 0
	self.currentpage = 0

	local searchstritems = {}

	for k,v in pairs(list) do
		if not contains(searchstritems, v) and string.find(v, itemname) then
			table.insert(searchstritems, v)
		end
	end

	for k,v in pairs(STRINGS.NAMES) do
		local itemprefab = string.lower(TrimString( k ))
		if not contains(searchstritems, itemprefab) and contains(list, itemprefab) and string.find(string.lower(v), itemname) then
			table.insert(searchstritems, itemprefab)
		end
	end

	local i = 0
	for k,v in pairs(searchstritems) do
		self.inventory[i] = v
		i = i + 1
	end

	table.sort(self.inventory, function(a,b) return a < b end)
	table.insert(self.inventory, self.inventory[#self.inventory])

	self.rebuild_pending = true
	self:Rebuild()
end

function Inv:Rebuild()
	self.slots:KillAllChildren()
	if self.inv then
		for k,v in pairs(self.inv) do
			v:Kill()
		end
	end
	self.inv = {}

	local num_slots = #self.inventory
	self.maxpages = math.floor(num_slots / MAXSLOTS)

	self.pagetext:SetString((self.currentpage+1).."/"..(self.maxpages+1))

	local W = 76
	local H = 76
	local maxwidth = (W * NUM_COLUMS)

	local positions = 0
	for k = self.currentpage * MAXSLOTS, math.min(num_slots-1, (self.currentpage + 1) * MAXSLOTS - 1) do
		local height = math.floor(positions / NUM_COLUMS) * H
		local slot = TMI_InvSlot(k, HUD_ATLAS, "inv_slot.tex", self, self.inventory)
		self.inv[k] = self.slots:AddChild(slot)
		self.inv[k]:SetTile(TMI_ItemTile(self.inventory[k], self.whichlistuse))

		local remainder = positions % NUM_COLUMS
		local row = math.floor(positions / NUM_COLUMS) * H

		local x = W * remainder
		slot:SetPosition(x,-row,0)
		positions = positions + 1
	end

	if self.currentpage <= 0 then
		self.currentpage = 0
		self.prevbutton:Hide()
	else
		self.prevbutton:Show()
	end

	if self.currentpage >= self.maxpages then
		self.currentpage = self.maxpages
		self.nextbutton:Hide()
	else
		self.nextbutton:Show()
	end

	self.rebuild_pending = false
end

function Inv:OnControl(control, down)
	if Inv._base.OnControl(self, control, down) then return true end
	return false
end

function contains(tab,val)
	for k,v in pairs(tab) do
		if v == val then
			return true
		end
	end

	return false
end

function Inv:Scroll(dir)

	local tempcurrentpage = self.currentpage

	self.currentpage = self.currentpage + dir

	if tempcurrentpage ~= self.currentpage then
		for k,v in pairs(self.inv) do
			v:Kill()
		end

		self.rebuild_pending = true
	end
	self:Rebuild()
end

return Inv
