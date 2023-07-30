local filter = GLOBAL.terrain.filter
local GROUND = GLOBAL.GROUND
local multiplier = (GetModConfigData("rock_rarity"))

local function PreInitDeerclopsfield(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 0.004 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.004 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitTallbirdfield(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = .8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitMoundfield(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 0.5 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.4 * multiplier

	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitChessForest(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 0.004 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.004 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitChessBarrens(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitHoundyBadlands(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGDeciduous(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = .05 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.05 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitSpiderVillage(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitTallbirdNests(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 2 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 1.6 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGCrappyForest(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = .008 * multiplier
	room.contents.distributeprefabs.rock_cobalt = .008 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGForest(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = .004 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.004 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGDeepForest(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = .004 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.004 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGDirt(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGChessRocky(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGRocky(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 0.8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitRocky(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 2 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 1.6 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitRockyBuzzards(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 2 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 1.6 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitGenericRockyNoThreat(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 2 * multiplier
	room.contents.distributeprefabs.rock_cobalt = 1.6 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitMolesvilleRocky(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = .8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGGrassBurnt(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = .01 * multiplier
	room.contents.distributeprefabs.rock_cobalt = .01 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitBGNoise(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = .1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = .1 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitWalrusHut_Rocky(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = 1 * multiplier
	room.contents.distributeprefabs.rock_cobalt = .8 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

local function PreInitWormhole_Plains(room)
	if not room.contents.distributeprefabs then
		room.contents.distributeprefabs = {}
	end
	room.contents.distributeprefabs.rock_iron = .5 * multiplier
	room.contents.distributeprefabs.rock_cobalt = .5 * multiplier
	filter.rock_iron = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
	filter.rock_cobalt = {GROUND.ROAD, GROUND.WOODFLOOR, GROUND.CARPET, GROUND.CHECKER}
end

	--As golden rocks (rock2)
AddRoomPreInit("Deerclopsfield", 		PreInitDeerclopsfield)
AddRoomPreInit("Tallbirdfield", 		PreInitTallbirdfield)
AddRoomPreInit("Moundfield", 			PreInitMoundfield)

AddRoomPreInit("ChessForest", 			PreInitChessForest)
AddRoomPreInit("ChessBarrens", 			PreInitChessBarrens)

AddRoomPreInit("HoundyBadlands", 		PreInitHoundyBadlands)
AddRoomPreInit("BGDeciduous",			PreInitBGDeciduous)

AddRoomPreInit("SpiderVillage", 		PreInitSpiderVillage)

AddRoomPreInit("TallbirdNests", 		PreInitTallbirdNests)

AddRoomPreInit("BGCrappyForest", 		PreInitBGCrappyForest)
AddRoomPreInit("BGForest", 				PreInitBGForest)
AddRoomPreInit("BGDeepForest", 			PreInitBGDeepForest)

AddRoomPreInit("BGDirt", 				PreInitBGDirt)

AddRoomPreInit("BGChessRocky", 			PreInitBGChessRocky)
AddRoomPreInit("BGRocky", 				PreInitBGRocky)
AddRoomPreInit("Rocky", 				PreInitRocky)
AddRoomPreInit("RockyBuzzards", 		PreInitRockyBuzzards)
AddRoomPreInit("GenericRockyNoThreat", 	PreInitGenericRockyNoThreat)
AddRoomPreInit("MolesvilleRocky", 		PreInitMolesvilleRocky)

AddRoomPreInit("BGGrassBurnt", 			PreInitBGGrassBurnt)

AddRoomPreInit("BGNoise", 				PreInitBGNoise)

AddRoomPreInit("WalrusHut_Rocky", 		PreInitWalrusHut_Rocky)

AddRoomPreInit("Wormhole_Plains", 		PreInitWormhole_Plains)