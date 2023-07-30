local LANG = GetModConfigData("速度")

if LANG == 1 then
	TUNING.WILSON_WALK_SPEED= 4
	TUNING.WILSON_RUN_SPEED = 6
elseif LANG == 2 then
	TUNING.WILSON_WALK_SPEED= 8
	TUNING.WILSON_RUN_SPEED = 12
else
	TUNING.WILSON_WALK_SPEED= 12
	TUNING.WILSON_RUN_SPEED = 18
end
--------------------------------------------
PrefabFiles = 
{
	
	"goldenspear",--黄金矛	
	"globalicon_network",--地图玩家图标
	"globalicon",
}
----以下为地图玩家图标显示部分-------------------------------------------------------------------------------------------
GLOBAL.AllGlobalIcons = {}
GLOBAL.GlobalIconAtlasTranslation = {}

local function RecheckAllOwners()
	for _,v in pairs(GLOBAL.AllGlobalIcons) do
		v:OnOwnerDirty()
	end
end

local function AddGlobalPlayerIcon(inst)
	inst.MiniMapEntity:SetDrawOverFogOfWar(true)
	
	if GLOBAL.TheWorld.ismastersim then
		local neticon = GLOBAL.SpawnPrefab("globalicon_network")
		inst:ListenForEvent("onremove", function () neticon:Remove() end)
		neticon:DoTaskInTime(0, function() neticon:SetOwner(inst) end)
	else
		GLOBAL.TheWorld:DoTaskInTime(0, RecheckAllOwners)
	end
end

-- Hack to determine MiniMap icon names
local function ReadAllMiniMapAtlases()
	for i,atlases in ipairs(GLOBAL.ModManager:GetPostInitData("MinimapAtlases")) do
		for i,path in ipairs(atlases) do
			local file = GLOBAL.io.open(GLOBAL.resolvefilepath(path), "r")
			if file then
				local xml = file:read("*a")
				if xml then
					for element in string.gmatch(xml, "<Element[^>]*name=\"([^\"]*)\"") do
						if element then
							local elementName = string.match(element, "^(.*)[.]")
							if elementName then
								GLOBAL.GlobalIconAtlasTranslation[elementName] = element
							end
						end
					end
				end
				file:close()
			end
		end
	end
end

for k,prefabname in ipairs(GLOBAL.DST_CHARACTERLIST) do
	AddPrefabPostInit(prefabname, AddGlobalPlayerIcon)
end

if GLOBAL.MODCHARACTERLIST then
	for k,prefabname in ipairs(GLOBAL.MODCHARACTERLIST) do
		AddPrefabPostInit(prefabname, AddGlobalPlayerIcon)
	end
end

AddPrefabPostInit("world_network", function () 
	if GLOBAL.TheWorld.ismastersim then
		ReadAllMiniMapAtlases()
	else
		GLOBAL.TheWorld:ListenForEvent("playerexited", RecheckAllOwners)
	end
end)
--------以下为黄金矛部分---------------------------------------------------------------------------------------
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
TUNING.GOLDENSPEAR_USES = 150
TUNING.GOLDENSPEAR_DAMAGE = 68

STRINGS.NAMES.GOLDENSPEAR = "黄金矛"
STRINGS.RECIPE_DESC.GOLDENSPEAR = "攻击"..TUNING.GOLDENSPEAR_DAMAGE.." 耐久"..TUNING.GOLDENSPEAR_USES
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GOLDENSPEAR = "攻击"..TUNING.GOLDENSPEAR_DAMAGE.." 耐久"..TUNING.GOLDENSPEAR_USES
AddRecipe("goldenspear", { Ingredient("log", 1), Ingredient("rope", 2), Ingredient("goldnugget", 3)}, RECIPETABS.WAR,  TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/goldenspear.xml", "goldenspear.tex")
-------中文输入部分------------------------------------------------------------------