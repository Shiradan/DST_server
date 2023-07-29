local TUNING = GLOBAL.TUNING

local MaxIndicator = GetModConfigData("MaxIndicator")
local IndicatorSize = GetModConfigData("IndicatorSize")
local PlayerIndicators = GetModConfigData("PlayerIndicators")

TUNING.MIN_INDICATOR_RANGE = 0
TUNING.MAX_INDICATOR_RANGE = MaxIndicator

local iconScale
local arrowScale

if PlayerIndicators == 1 then
	if IndicatorSize == 1 then --Tiny
		iconScale = 0.4
		arrowScale = 0.25
	elseif IndicatorSize ==2 then --Small
		iconScale = 0.55
		arrowScale = 0.3
	elseif IndicatorSize == 3 then --Medium
		iconScale = 0.7
		arrowScale = 0.35
	else --Large
		iconScale = 0.8
		arrowScale = 0.4
	end
else --Disable the player indicators
	iconScale = 0
	arrowScale = 0
end

local function TargetIndicator(self, owner, target)
	self.icon:SetScale(iconScale)
	self.arrow:SetScale(arrowScale)
end

AddClassPostConstruct("widgets/targetindicator", TargetIndicator)