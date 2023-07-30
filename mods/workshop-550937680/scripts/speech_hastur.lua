--[[
	--- This is Hastur's speech file for Don't Starve Together ---
	Write your character's lines here.
	If you want to use another speech file as a base, or use a more up-to-date version, get them from data\scripts\
	
	If you want to use quotation marks in a quote, put a \ before it.
	Example:
	"Like \"this\"."
]]
return {
	ACTIONFAIL =
	{
		SHAVE =
		{
			AWAKEBEEFALO = "The black stars have not yet risen.",
			GENERIC = "I shall not shave that!",
			NOBITS = "It is barren.",
		},
		STORE =
		{
			GENERIC = "Parameters ",
			NOTALLOWED = "This item will not submit.",
			INUSE = "I must bide my time.",
		},
		RUMMAGE =
		{	
			GENERIC = "I cannot.",
			INUSE = "Tell that infernal corpse to desist.",	
		},
        COOK =
        {
            GENERIC = "I cannot.",
            INUSE = "I must bide my time.",
        },
        GIVE =
        {
            DEAD = "That slop is unworthy.",
            SLEEPING = "Let their nightmares reign.",
            BUSY = "I will persist in trying.",
        },
        GIVETOPLAYER = 
        {
        	FULL = "They lack the capacity to accept this.",
            DEAD = "That slop is unworthy.",
            SLEEPING = "Let their nightmares reign.",
            BUSY = "Soon.",
    	},
    	GIVEALLTOPLAYER = 
        {
        	FULL = "They lack the capacity to accept this.",
            DEAD = "That slop is unworthy.",
            SLEEPING = "Let their nightmares reign.",
            BUSY = "Soon.",
    	},
	},
	ACTIONFAIL_GENERIC = "I cannot.",
	ANNOUNCE_ADVENTUREFAIL = "But stranger still is Lost Carcosa",
	ANNOUNCE_BEES = "Unsung tears",
	ANNOUNCE_BOOMERANG = "Die thou, infernal contraption",
	ANNOUNCE_CHARLIE = "Song of my soul, my voice is dead.",
	ANNOUNCE_CHARLIE_ATTACK = "But stranger still is Lost Carcosa.",
	ANNOUNCE_COLD = "Where flap the tatters of the King",
	ANNOUNCE_HOT = "Song of my soul, my voice is dead.",
	ANNOUNCE_CRAFTING_FAIL = "I wear no mask.",
	ANNOUNCE_DEERCLOPS = "That sounded big!",
	ANNOUNCE_DUSK = "Strange is the night where black stars rise.",
	ANNOUNCE_EAT =
	{
		GENERIC = "...",
		PAINFUL = "Die thou, unsung, as tears unshed",
		SPOILED = "Die thou, unsung, as tears unshed",
		STALE = "Shall dry and die in Lost Carcosa",
		INVALID = "Such rubbish I shall not consume",
		YUCKY = "No admittance is allowed",
	},
	ANNOUNCE_ENTER_DARK = "The twin suns sink behind the lake",
	ANNOUNCE_ENTER_LIGHT = "Unheard in Dim Carcosa.",
	ANNOUNCE_FREEDOM = "Die thou, unsung, as tears unshed",
	ANNOUNCE_HIGHRESEARCH = "I feel so smart now!",
	ANNOUNCE_HOUNDS = "The shadows lengthen",
	ANNOUNCE_HUNGRY = "I must consume.",
	ANNOUNCE_HUNT_BEAST_NEARBY = "Where flap the tatters of the King",
	ANNOUNCE_HUNT_LOST_TRAIL = "It is dried and dead.",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "Like my voice, this land is dead.",
	ANNOUNCE_INV_FULL = "I shall not become encumbered.",
	ANNOUNCE_KNOCKEDOUT = "Tears unshed.",
	ANNOUNCE_LOWRESEARCH = "Stranger still is Lost Carcosa",
	ANNOUNCE_MOSQUITOS = "Return to the pits from whence you came.",
	ANNOUNCE_NODANGERSLEEP = "I must walk along the shore.",
	ANNOUNCE_NODAYSLEEP = "Strange moons circle through the skies.",
	ANNOUNCE_NODAYSLEEP_CAVE = "Unsung is the song of sleep.",
	ANNOUNCE_NOHUNGERSLEEP = "I must consume.",
	ANNOUNCE_NOSLEEPONFIRE = "The twin suns burn us.",
	ANNOUNCE_NODANGERSIESTA = "My brethren lurk just beyond.",
	ANNOUNCE_NONIGHTSIESTA = "The shadows lengthen in Carcosa.",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "The shadows lengthen in Carcosa.",
	ANNOUNCE_NOHUNGERSIESTA = "The shadows lengthen in Carcosa.",
	ANNOUNCE_NODANGERAFK = "The shadows lengthen in Carcosa.",
	ANNOUNCE_NO_TRAP = "The shadows lengthen in Carcosa.",
	ANNOUNCE_PECKED = "Die thou, unsung!",
	ANNOUNCE_QUAKE = "The shadows lengthen in Carcosa.",
	ANNOUNCE_RESEARCH = "The shadows lengthen in Carcosa.",
	ANNOUNCE_SHELTER = "Strange is the day that tears do not fall.",
	ANNOUNCE_THORNS = "The shadows lengthen in Carcosa.",
	ANNOUNCE_BURNT = "The twin suns punish us.",
	ANNOUNCE_TORCH_OUT = "The shadows lengthen in Carcosa.",
	ANNOUNCE_TRAP_WENT_OFF = "Tears shall dry and die in Lost Carcosa",
	ANNOUNCE_UNIMPLEMENTED = "The shadows lengthen in Carcosa.",
	ANNOUNCE_WORMHOLE = "Strange moons circle through the skies.",
	ANNOUNCE_CANFIX = "What rubbish.",
	ANNOUNCE_ACCOMPLISHMENT = "Song of my soul, my voice is dead.",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "The shadows lengthen in Carcosa.",	
	ANNOUNCE_INSUFFICIENTFERTILIZER = "Song of my soul, my voice is dead.",
	ANNOUNCE_TOOL_SLIP = "This contraption is awash with tears.",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Along the shore the cloud waves break.",

	ANNOUNCE_DAMP = "Tears are shed in abundance.",
	ANNOUNCE_WET = "The tatters are awash with victim's tears.",
	ANNOUNCE_WETTER = "Tears unshed shall dry and die in Lost Carcosa",
	ANNOUNCE_SOAKED = "Song of my soul, my voice is dead.",
	
	ANNOUNCE_BECOMEGHOST = "I wear no mask.",
	ANNOUNCE_GHOSTDRAIN = "I wear no mask.",

	DESCRIBE_SAMECHARACTER = "Here flap the tatters of the King.",
	
	BATTLECRY =
	{
		GENERIC = "Dash out its face!",
		PIG = "Scum of the earth.",
		PREY = "You shall be destroyed.",
		SPIDER = "Lend to me your venom.",
		SPIDER_WARRIOR = "Yellow like my tatters.",
	},
	COMBAT_QUIT =
	{
		GENERIC = "They must die unheard.",
		PIG = "Where flap the tatters of the King?",
		PREY = "Die thou, unsung.",
		SPIDER = "Dim Carcosa awaits.",
		SPIDER_WARRIOR = "Live on, my tattered brethren.",
	},
	DESCRIBE =
	{
        PLAYER =
        {
            GENERIC = "It's %s! How droll.",
            ATTACKER = "That %s drips of tears.",
            MURDERER = "Many have died unheard.",
            REVIVER = "%s, lost to Dim Carcosa.",
            GHOST = "%s walks along the shore.",
        },
		WILSON = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		WOLFGANG = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		WAXWELL = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		WX78 = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		WILLOW = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		WENDY = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		WOODIE = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		WICKERBOTTOM = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		WES = 
		{
			GENERIC = "That petulant scum",
			ATTACKER = "Where flap the tatters of the King?",
			MURDERER = "Thou must die unheard.",
			REVIVER = "Die thou, unsung, as tears unshed.",
			GHOST = "Stranger still is Lost Carcosa.",
		},
		MULTIPLAYER_PORTAL = "Along the shore the cloud waves break",
		GLOMMER = "Stranger still is Lost Carcosa.",
		GLOMMERFLOWER = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			DEAD = "Stranger still is Lost Carcosa.",
		},
		GLOMMERWINGS = "These tatters boast of more than tears.",
		GLOMMERFUEL = "Stranger still is Lost Carcosa.",
		BELL = "Stranger still is Lost Carcosa.",
		STATUEGLOMMER = 
		{	
			GENERIC = "Stranger still is Lost Carcosa.",
			EMPTY = "Stranger still is Lost Carcosa..",
		},

		WEBBERSKULL = "Stranger still is Lost Carcosa.",
		WORMLIGHT = "Stranger still is Lost Carcosa.",
		WORM =
		{
		    PLANT = "Stranger still is Lost Carcosa.",
		    DIRT = "Stranger still is Lost Carcosa.",
		    WORM = "Stranger still is Lost Carcosa.",
		},
		MOLE =
		{
			HELD = "Strange moons circle through the skies.",
			UNDERGROUND = "Stranger still is Lost Carcosa..",
			ABOVEGROUND = "Stranger still is Lost Carcosa.",
		},
		MOLEHILL = "Stranger still is Lost Carcosa.",
		MOLEHAT = "Stranger still is Lost Carcosa.",

		EEL = "The shadows lengthen. I consume.",
		EEL_COOKED = "Stranger still is Lost Carcosa.",
		UNAGI = "Stranger still is Lost Carcosa.",
		EYETURRET = "Stranger still is Lost Carcosa.",
		EYETURRET_ITEM = "Stranger still is Lost Carcosa.",
		MINOTAURHORN = "Die thou, unsun, as tears unshed.",
		MINOTAURCHEST = "Stranger still is Lost Carcosa.",
		THULECITE_PIECES = "Stranger still is Lost Carcosa.",
		POND_ALGAE = "Stranger still is Lost Carcosa.",
		GREENSTAFF = "Stranger still is Lost Carcosa.",
		POTTEDFERN = "Stranger still is Lost Carcosa.",

		THULECITE = "Stranger still is Lost Carcosa.",
		ARMORRUINS = "Stranger still is Lost Carcosa.",
		RUINS_BAT = "Stranger still is Lost Carcosa.",
		RUINSHAT = "Fit for the tattered king.",
		NIGHTMARE_TIMEPIECE =
		{
		CALM = "Along the shore the cloud waves break.",
		WARN = "The twin suns sink behind the lake.",
		WAXING = "The shadows lengthen in Carcosa.",
		STEADY = "Strange is the night where black stars rise.",
		WANING = "And strange moons circle through the skies.",
		DAWN = " But stranger still is Lost Carcosa.",
		NOMAGIC = "Songs that the Hyades shall sing.",
		},
		BISHOP_NIGHTMARE = "Where flap the tatters of the King.",
		ROOK_NIGHTMARE = "Must die unheard.",
		KNIGHT_NIGHTMARE = "Stranger still is Lost Carcosa.",
		MINOTAUR = "Stranger still is Lost Carcosa.",
		SPIDER_DROPPER = "Stranger still is Lost Carcosa.",
		NIGHTMARELIGHT = "Stranger still is Lost Carcosa.",
		NIGHTSTICK = "Stranger still is Lost Carcosa.",
		GREENGEM = "Stranger still is Lost Carcosa.",
		RELIC = "Where flap the tatters of the King",
		RUINS_RUBBLE = "Stranger still is Lost Carcosa.",
		MULTITOOL_AXE_PICKAXE = "Stranger still is Lost Carcosa.",
		ORANGESTAFF = "Stranger still is Lost Carcosa.",
		YELLOWAMULET = "Stranger still is Lost Carcosa.",
		GREENAMULET = "Stranger still is Lost Carcosa.",
		SLURPERPELT = "Stranger still is Lost Carcosa.",	

		SLURPER = "Stranger still is Lost Carcosa.",
		SLURPER_PELT = "Stranger still is Lost Carcosa.",
		ARMORSLURPER = "Stranger still is Lost Carcosa.",
		ORANGEAMULET = "Stranger still is Lost Carcosa.",
		YELLOWSTAFF = "Stranger still is Lost Carcosa.",
		YELLOWGEM = "Stranger still is Lost Carcosa.",
		ORANGEGEM = "Stranger still is Lost Carcosa.",
		TELEBASE = 
		{
			VALID = "Stranger still is Lost Carcosa.",
			GEMS = "The twin suns seek companionship.",
		},
		GEMSOCKET = 
		{
			VALID = "Stranger still is Lost Carcosa.",
			GEMS = "Stranger still is Lost Carcosa.",
		},
		STAFFLIGHT = "Stranger still is Lost Carcosa.",
	
        ANCIENT_ALTAR = "An ancient and mysterious structure.",

        ANCIENT_ALTAR_BROKEN = "Stranger still is Lost Carcosa.",

        ANCIENT_STATUE = "Stranger still is Lost Carcosa.",

        LICHEN = "Stranger still is Lost Carcosa.",
		CUTLICHEN = "Stranger still is Lost Carcosa.",

		CAVE_BANANA = "Stranger still is Lost Carcosa.",
		CAVE_BANANA_COOKED = "Stranger still is Lost Carcosa.",
		CAVE_BANANA_TREE = "Stranger still is Lost Carcosa.",
		ROCKY = "Stranger still is Lost Carcosa.",
		
		COMPASS =
		{
			GENERIC="Stranger still is Lost Carcosa.",
			N = "North",
			S = "South",
			E = "East",
			W = "West",
			NE = "Northeast",
			SE = "Southeast",
			NW = "Northwest",
			SW = "Southwest",
		},

		NIGHTMARE_TIMEPIECE =	-- Duplicated
		{
			WAXING = "I think it's becoming more concentrated!",
			STEADY = "It seems to be staying steady.",
			WANING = "Feels like it's receding.",
			DAWN = "The nightmare is almost gone!",
			WARN = "Getting pretty magical around here.",
			CALM = "All is well.",
			NOMAGIC = "There's no magic around here.",
		},

		HOUNDSTOOTH="Stranger still is Lost Carcosa.",
		ARMORSNURTLESHELL="Stranger still is Lost Carcosa.",
		BAT="Stranger still is Lost Carcosa.",
		BATBAT = "Stranger still is Lost Carcosa..",
		BATWING="Stranger still is Lost Carcosa.",
		BATWING_COOKED="Stranger still is Lost Carcosa.",
		BEDROLL_FURRY="Stranger still is Lost Carcosa.",
		BUNNYMAN="Stranger still is Lost Carcosa.",
		FLOWER_CAVE="Stranger still is Lost Carcosa.",
		FLOWER_CAVE_DOUBLE="Stranger still is Lost Carcosa.",
		FLOWER_CAVE_TRIPLE="Stranger still is Lost Carcosa.",
		GUANO="Stranger still is Lost Carcosa.",
		LANTERN="Stranger still is Lost Carcosa.",
		LIGHTBULB="Stranger still is Lost Carcosa.",
		MANRABBIT_TAIL="Stranger still is Lost Carcosa.",
		MUSHTREE_TALL  ="Stranger still is Lost Carcosa.",
		MUSHTREE_MEDIUM="Stranger still is Lost Carcosa.",
		MUSHTREE_SMALL ="Stranger still is Lost Carcosa.",
		RABBITHOUSE=
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		SLURTLE="Stranger still is Lost Carcosa.",
		SLURTLE_SHELLPIECES="Stranger still is Lost Carcosa.",
		SLURTLEHAT="Stranger still is Lost Carcosa.",
		SLURTLEHOLE="Stranger still is Lost Carcosa.",
		SLURTLESLIME="Stranger still is Lost Carcosa.",
		SNURTLE="Stranger still is Lost Carcosa.",
		SPIDER_HIDER="Stranger still is Lost Carcosa.",
		SPIDER_SPITTER="Stranger still is Lost Carcosa.",
		SPIDERHOLE="Stranger still is Lost Carcosa..",
		STALAGMITE="Stranger still is Lost Carcosa.",
		STALAGMITE_FULL="Stranger still is Lost Carcosa..",
		STALAGMITE_LOW="Stranger still is Lost Carcosa.",
		STALAGMITE_MED="Stranger still is Lost Carcosa..",
		STALAGMITE_TALL="Stranger still is Lost Carcosa.",
		STALAGMITE_TALL_FULL="Stranger still is Lost Carcosa..",
		STALAGMITE_TALL_LOW="Stranger still is Lost Carcosa..",
		STALAGMITE_TALL_MED="Stranger still is Lost Carcosa...",

		TURF_CARPETFLOOR = "Stranger still is Lost Carcosa.",
		TURF_CHECKERFLOOR = "Stranger still is Lost Carcosa..",
		TURF_DIRT = "Stranger still is Lost Carcosa.",
		TURF_FOREST = "Stranger still is Lost Carcosa.",
		TURF_GRASS = "Stranger still is Lost Carcosa.",
		TURF_MARSH = "Stranger still is Lost Carcosa.",
		TURF_ROAD = "Stranger still is Lost Carcosa.",
		TURF_ROCKY = "Stranger still is Lost Carcosa.",
		TURF_SAVANNA = "Stranger still is Lost Carcosa.",
		TURF_WOODFLOOR = "Stranger still is Lost Carcosa.",

		TURF_CAVE="Stranger still is Lost Carcosa.",
		TURF_FUNGUS="Stranger still is Lost Carcosa.",
		TURF_SINKHOLE="Stranger still is Lost Carcosa.",
		TURF_UNDERROCK="Stranger still is Lost Carcosa.",
		TURF_MUD="Stranger still is Lost Carcosa.",

		TURF_DECIDUOUS = "Stranger still is Lost Carcosa.",
		TURF_SANDY = "Stranger still is Lost Carcosa.",
		TURF_BADLANDS = "Stranger still is Lost Carcosa.",

		POWCAKE = "Stranger still is Lost Carcosa.",
        CAVE_ENTRANCE = 
        {
            GENERIC="Stranger still is Lost Carcosa.",
            OPEN = "Stranger still is Lost Carcosa.",
        },
        CAVE_EXIT = "Stranger still is Lost Carcosa.",
		MAXWELLPHONOGRAPH = "Stranger still is Lost Carcosa.",
		BOOMERANG = "Stranger still is Lost Carcosa.",
		PIGGUARD = "Die thou, unsung, as tears are shed.",
		ABIGAIL = "Stranger still is Lost Carcosa..",
		ADVENTURE_PORTAL = "Stranger still is Lost Carcosa.",
		AMULET = "Stranger still is Lost Carcosa.",
		ANIMAL_TRACK = "The shadows lengthen in Carcosa.",
		ARMORGRASS = "Stranger still is Lost Carcosa.",
		ARMORMARBLE = "Stranger still is Lost Carcosa.",
		ARMORWOOD = "Where flap the tatters of the King.",
		ARMOR_SANITY = "Stranger still is Lost Carcosa.",
		ASH =
		{
			GENERIC = "Strange is the night where black stars rise.",
			REMAINS_GLOMMERFLOWER = "Stranger still is Lost Carcosa.",
			REMAINS_EYE_BONE = "Stranger still is Lost Carcosa.",
			REMAINS_THINGIE = "Stranger still is Lost Carcosa.",
		},
		AXE = "It's my trusty axe.",
		BABYBEEFALO = "A tiny poof of fur, bones and meat.",
		BACKPACK = "Where flap the tatters of the King.",
		BACONEGGS = "Stranger still is Lost Carcosa.",
		BANDAGE = "Stranger still is Lost Carcosa..",
		BASALT = "Stranger still is Lost Carcosa.",
		BATBAT = "Stranger still is Lost Carcosa.",	-- Duplicated
		BEARDHAIR = "Stranger still is Lost Carcosa.",
		BEARGER = "Stranger still is Lost Carcosa.",
		BEARGERVEST = "Stranger still is Lost Carcosa.",
		ICEPACK = "Stranger still is Lost Carcosa.",
		BEARGER_FUR = "Stranger still is Lost Carcosa.",
		BEDROLL_STRAW = "Stranger still is Lost Carcosa.",
		BEE =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HELD = "Stranger still is Lost Carcosa.",
		},
		BEEBOX =
		{
			READY = "Stranger still is Lost Carcosa.",
			FULLHONEY = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			NOHONEY = "Stranger still is Lost Carcosa..",
			SOMEHONEY = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		BEEFALO =
		{
			FOLLOWER = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			NAKED = "Stranger still is Lost Carcosa.",
			SLEEPING = "Stranger still is Lost Carcosa.",
		},
		BEEFALOHAT = "Stranger still is Lost Carcosa.",
		BEEFALOWOOL = "Stranger still is Lost Carcosa.",
		BEEHAT = "Stranger still is Lost Carcosa..",
		BEEHIVE = "Stranger still is Lost Carcosa.",
		BEEMINE = "Stranger still is Lost Carcosa.",
		BEEMINE_MAXWELL = "Stranger still is Lost Carcosa.",
		BERRIES = "Stranger still is Lost Carcosa..",
		BERRIES_COOKED = "Stranger still is Lost Carcosa..",
		BERRYBUSH =
		{
			BARREN = "Stranger still is Lost Carcosa.",
			WITHERED = "The twin suns are strong this day.",
			GENERIC = "Stranger still is Lost Carcosa.",
			PICKED = "Stranger still is Lost Carcosa.",
		},
		BIGFOOT = "Strange is the night...",
		BIRDCAGE =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			OCCUPIED = "Stranger still is Lost Carcosa.",
			SLEEPING = "Stranger still is Lost Carcosa.",
		},
		BIRDTRAP = "Stranger still is Lost Carcosa.",
		BIRD_EGG = "Stranger still is Lost Carcosa.",
		BIRD_EGG_COOKED = "Stranger still is Lost Carcosa.",
		BISHOP = "Stranger still is Lost Carcosa.",
		BLOWDART_FIRE = "Stranger still is Lost Carcosa..",
		BLOWDART_SLEEP = "Stranger still is Lost Carcosa.",
		BLOWDART_PIPE = "Stranger still is Lost Carcosa.",
		BLUEAMULET = "Stranger still is Lost Carcosa.",
		BLUEGEM = "Stranger still is Lost Carcosa.",
		BLUEPRINT = "Stranger still is Lost Carcosa.",
		BELL_BLUEPRINT = "Stranger still is Lost Carcosa.",
		BLUE_CAP = "Stranger still is Lost Carcosa.",
		BLUE_CAP_COOKED = "Stranger still is Lost Carcosa.",
		BLUE_MUSHROOM =
		{
			GENERIC = "Friends of the night.",
			INGROUND = "The twin suns scare it.",
			PICKED = "It died unheard.",
		},
		BOARDS = "Stranger still is Lost Carcosa.",
		BOAT = "Stranger still is Lost Carcosa.",
		BONESHARD = "Stranger still is Lost Carcosa..",
		BONESTEW = "Stranger still is Lost Carcosa.",
		BUGNET = "Stranger still is Lost Carcosa.",
		BUSHHAT = "Stranger still is Lost Carcosa.",
		BUTTER = "Stranger still is Lost Carcosa.",
		BUTTERFLY =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HELD = "Stranger still is Lost Carcosa.",
		},
		BUTTERFLYMUFFIN = "Stranger still is Lost Carcosa.",
		BUTTERFLYWINGS = "Stranger still is Lost Carcosa.",
		BUZZARD = "Stranger still is Lost Carcosa.",
		CACTUS = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			PICKED = "Where flap the tatters of the King?",
		},
		CACTUS_MEAT_COOKED = "Stranger still is Lost Carcosa.",
		CACTUS_MEAT = "Stranger still is Lost Carcosa.",
		CACTUS_FLOWER = "Stranger still is Lost Carcosa.",

		COLDFIRE =
		{
			EMBERS = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			HIGH = "Stranger still is Lost Carcosa.",
			LOW = "Stranger still is Lost Carcosa.",
			NORMAL = "Stranger still is Lost Carcosa.",
			OUT = "Stranger still is Lost Carcosa.",
		},
		CAMPFIRE =
		{
			EMBERS = "The twin suns can rekindle this.",
			GENERIC = "Strange is the night where black stares rise.",
			HIGH = "The twin suns are ablaze!",
			LOW = "Strange  moons circle through the skies",
			NORMAL = "Stranger still is Lost Carcosa.",
			OUT = "It died unheard.",
		},
		CANE = "Stranger still is Lost Carcosa.",
		CATCOON = "Is Bast watching?",
		CATCOONDEN = 
		{
			GENERIC = "Stranger still is Lost Carcosa..",
			EMPTY = "Stranger still is Lost Carcosa..",
		},
		CATCOONHAT = "Stranger still is Lost Carcosa.",
		COONTAIL = "Stranger still is Lost Carcosa.",
		CARROT = "Stranger still is Lost Carcosa..",
		CARROT_COOKED = "Stranger still is Lost Carcosa.",
		CARROT_PLANTED = "Stranger still is Lost Carcosa..",
		CARROT_SEEDS = "Stranger still is Lost Carcosa.",
		WATERMELON_SEEDS = "Stranger still is Lost Carcosa.",
		CAVE_FERN = "Stranger still is Lost Carcosa.",
		CHARCOAL = "The shadows lengthen in Carcosa.",
        CHESSJUNK1 = "Stranger still is Lost Carcosa.",
        CHESSJUNK2 = "Stranger still is Lost Carcosa..",
        CHESSJUNK3 = "Stranger still is Lost Carcosa.",
		CHESTER = "Stranger still is Lost Carcosa.",
		CHESTER_EYEBONE =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			WAITING = "Stranger still is Lost Carcosa.",
		},
		COOKEDMANDRAKE = "Stranger still is Lost Carcosa.",
		COOKEDMEAT = "Stranger still is Lost Carcosa.",
		COOKEDMONSTERMEAT = "Stranger still is Lost Carcosa.",
		COOKEDSMALLMEAT = "Stranger still is Lost Carcosa.",
		COOKPOT =
		{
			COOKING_LONG = "Stranger still is Lost Carcosa.",
			COOKING_SHORT = "Stranger still is Lost Carcosa.",
			DONE = "Stranger still is Lost Carcosa.",
			EMPTY = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		CORN = "Stranger still is Lost Carcosa.",
		CORN_COOKED = "Stranger still is Lost Carcosa.",
		CORN_SEEDS = "Stranger still is Lost Carcosa.",
		CROW =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HELD = "Stranger still is Lost Carcosa.",
		},
		CUTGRASS = "Stranger still is Lost Carcosa.",
		CUTREEDS = "Stranger still is Lost Carcosa.",
		CUTSTONE = "Stranger still is Lost Carcosa.",
		DEADLYFEAST = "Stranger still is Lost Carcosa.",
		DEERCLOPS = "A ancient one from another time.",
		DEERCLOPS_EYEBALL = "Stranger still is Lost Carcosa.",
		EYEBRELLAHAT =	"Stranger still is Lost Carcosa.",
		DEPLETED_GRASS =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
		},
		DEVTOOL = "Stranger still is Lost Carcosa.",
		DEVTOOL_NODEV = "Stranger still is Lost Carcosa.",
		DIRTPILE = "Stranger still is Lost Carcosa.",
		DIVININGROD =
		{
			COLD = "Where flap the tatters of the King?",
			GENERIC = "Stranger still is Lost Carcosa..",
			HOT = "Stranger still is Lost Carcosa.",
			WARM = "Stranger still is Lost Carcosa.",
			WARMER = "Stranger still is Lost Carcosa.",
		},
		DIVININGRODBASE =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			READY = "Stranger still is Lost Carcosa.",
			UNLOCKED = "Stranger still is Lost Carcosa.",
		},
		DIVININGRODSTART = "Stranger still is Lost Carcosa.",
		DRAGONFLY = "An ancient one from another time.",
		ARMORDRAGONFLY = "Stranger still is Lost Carcosa.",
		DRAGON_SCALES = "Stranger still is Lost Carcosa.",
		DRAGONFLYCHEST = "Stranger still is Lost Carcosa.",
		LAVASPIT = 
		{
			HOT = "Stranger still is Lost Carcosa.",
			COOL = "Stranger still is Lost Carcosa.",
		},
		DRAGONFRUIT = "Stranger still is Lost Carcosa..",
		DRAGONFRUIT_COOKED = "Stranger still is Lost Carcosa.",
		DRAGONFRUIT_SEEDS = "Stranger still is Lost Carcosa.",
		DRAGONPIE = "Stranger still is Lost Carcosa.",
		DRUMSTICK = "Stranger still is Lost Carcosa.",
		DRUMSTICK_COOKED = "Stranger still is Lost Carcosa.",
		DUG_BERRYBUSH = "Stranger still is Lost Carcosa.",
		DUG_GRASS = "Stranger still is Lost Carcosa.",
		DUG_MARSH_BUSH = "Stranger still is Lost Carcosa..",
		DUG_SAPLING = "Stranger still is Lost Carcosa.",
		DURIAN = "Stranger still is Lost Carcosa.",
		DURIAN_COOKED = "Stranger still is Lost Carcosa.",
		DURIAN_SEEDS = "Stranger still is Lost Carcosa.",
		EARMUFFSHAT = "Stranger still is Lost Carcosa.",
		EGGPLANT = "Stranger still is Lost Carcosa.",
		EGGPLANT_COOKED = "Stranger still is Lost Carcosa.",
		EGGPLANT_SEEDS = "Stranger still is Lost Carcosa.",
		DECIDUOUSTREE = 
		{
			BURNING = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
			CHOPPED = "Die thou, unsung.",
			POISON = "Strange moons circle through the skies.",
			GENERIC = "Stranger still is Lost Carcosa.",
		},
		ACORN = 
		{
		    GENERIC = "Stranger still is Lost Carcosa.",
		    PLANTED = "Stranger still is Lost Carcosa.",
		},
		ACORN_COOKED = "Stranger still is Lost Carcosa.",
		BIRCHNUTDRAKE = "Stranger still is Lost Carcosa.",
		EVERGREEN =
		{
			BURNING = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
			CHOPPED = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "Stranger still is Lost Carcosa..",
			BURNT = "Stranger still is Lost Carcosa.",
			CHOPPED = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
		},
		EYEPLANT = "Song of my soul, my voice is dead.",
		FARMPLOT =
		{
			GENERIC = "Stranger still is Lost Carcosa..",
			GROWING = "Stranger still is Lost Carcosa.",
			NEEDSFERTILIZER = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		FEATHERHAT = "Stranger still is Lost Carcosa.",
		FEATHER_CROW = "Stranger still is Lost Carcosa.",
		FEATHER_ROBIN = "Stranger still is Lost Carcosa.",
		FEATHER_ROBIN_WINTER = "Stranger still is Lost Carcosa.",
		FEM_PUPPET = "Stranger still is Lost Carcosa.",
		FIREFLIES =
		{
			GENERIC = "Small lights in a dark night.",
			HELD = "Stranger still is Lost Carcosa.",
		},
		FIREHOUND = "Stranger still is Lost Carcosa.",
		FIREPIT =
		{
			EMBERS = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			HIGH = "Stranger still is Lost Carcosa.",
			LOW = "Stranger still is Lost Carcosa..",
			NORMAL = "Stranger still is Lost Carcosa.",
			OUT = "Stranger still is Lost Carcosa..",
		},
		COLDFIREPIT =
		{
			EMBERS = "The twin suns are away.",
			GENERIC = "Stranger still is Lost Carcosa.",
			HIGH = "Stranger still is Lost Carcosa.",
			LOW = "Stranger still is Lost Carcosa.",
			NORMAL = "Stranger still is Lost Carcosa..",
			OUT = "Stranger still is Lost Carcosa..",
		},
		FIRESTAFF = "Stranger still is Lost Carcosa..",
		FIRESUPPRESSOR = 
		{	
			ON = "Stranger still is Lost Carcosa.",
			OFF = "Stranger still is Lost Carcosa.",
			LOWFUEL = "Stranger still is Lost Carcosa.",
		},

		FISH = "Where flap the tatters of the King?",
		FISHINGROD = "Stranger still is Lost Carcosa.",
		FISHSTICKS = "Stranger still is Lost Carcosa.",
		FISHTACOS = "Stranger still is Lost Carcosa.",
		FISH_COOKED = "Stranger still is Lost Carcosa.",
		FLINT = "Stranger still is Lost Carcosa..",
		FLOWER = "Stranger still is Lost Carcosa..",
		FLOWERHAT = "Stranger still is Lost Carcosa.",
		FLOWER_EVIL = "Stranger still is Lost Carcosa.",
		FOLIAGE = "Stranger still is Lost Carcosa..",
		FOOTBALLHAT = "Stranger still is Lost Carcosa..",
		FROG =
		{
			DEAD = "Stranger still is Lost Carcosa.",
			GENERIC = "Brethren from Lost Carcosa.",
			SLEEPING = "Strange is the night.",
		},
		FROGGLEBUNWICH = "Stranger still is Lost Carcosa.",
		FROGLEGS = "Stranger still is Lost Carcosa..",
		FROGLEGS_COOKED = "Stranger still is Lost Carcosa.",
		FRUITMEDLEY = "Stranger still is Lost Carcosa.",
		FURTUFT = "Stranger still is Lost Carcosa.", 
		GEARS = "Stranger still is Lost Carcosa.",
		GHOST = "Stranger still is Lost Carcosa.",
		GOLDENAXE = "Stranger still is Lost Carcosa.",
		GOLDENPICKAXE = "Stranger still is Lost Carcosa.",
		GOLDENPITCHFORK = "Stranger still is Lost Carcosa.",
		GOLDENSHOVEL = "Stranger still is Lost Carcosa.",
		GOLDNUGGET = "Stranger still is Lost Carcosa.",
		GRASS =
		{
			BARREN = "It is in tatters.",
			WITHERED = "Burnt by the twin suns.",
			BURNING = "The twin suns are ablaze!",
			GENERIC = "Stranger still is Lost Carcosa.",
			PICKED = "Stranger still is Lost Carcosa.",
		},
		GREEN_CAP = "Stranger still is Lost Carcosa.",
		GREEN_CAP_COOKED = "Stranger still is Lost Carcosa.",
		GREEN_MUSHROOM =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			INGROUND = "Strange moons circle through the skies.",
			PICKED = "Stranger still is Lost Carcosa.",
		},
		GUNPOWDER = "Stranger still is Lost Carcosa.",
		HAMBAT = "Stranger still is Lost Carcosa.",
		HAMMER = "Stranger still is Lost Carcosa.",
		HEALINGSALVE = "Stranger still is Lost Carcosa.",
		HEATROCK =
		{
			FROZEN = "Stranger still is Lost Carcosa.",
			COLD = "The twin suns hvae not circled here.",
			GENERIC = "Stranger still is Lost Carcosa.",
			WARM = "The twin suns assist us this day.",
			HOT = "It burns with the fury of the twin suns.",
		},
		HOME = "Stranger still is Lost Carcosa.",
		HOMESIGN = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		HONEY = "Stranger still is Lost Carcosa.",
		HONEYCOMB = "Stranger still is Lost Carcosa.",
		HONEYHAM = "Stranger still is Lost Carcosa.",
		HONEYNUGGETS = "Stranger still is Lost Carcosa.",
		HORN = "Stranger still is Lost Carcosa.",
		HOUND = "Where flap the tatters of the King?",
		HOUNDBONE = "Stranger still is Lost Carcosa.",
		HOUNDMOUND = "Stranger still is Lost Carcosa.",
		ICEBOX = "Strange moons circle through the skies.",
		ICEHAT = "The twin suns will try to destroy this.",
		ICEHOUND = "Stranger still is Lost Carcosa.",
		INSANITYROCK =
		{
			ACTIVE = "Stranger still is Lost Carcosa.",
			INACTIVE = "The great obelisk.",
		},
		JAMMYPRESERVES = "Stranger still is Lost Carcosa.",
		KABOBS = "Stranger still is Lost Carcosa.",
		KILLERBEE =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HELD = "Stranger still is Lost Carcosa.",
		},
		KNIGHT = "Die thou, unsung.",
		KOALEFANT_SUMMER = "Stranger still is Lost Carcosa.",
		KOALEFANT_WINTER = "Stranger still is Lost Carcosa.",
		KRAMPUS = "An ancient one from another place.",
		KRAMPUS_SACK = "Stranger still is Lost Carcosa.",
		LEIF = "Stranger still is Lost Carcosa.",
		LEIF_SPARSE = "Stranger still is Lost Carcosa.",
		LIGHTNING_ROD =
		{
			CHARGED = "It must die unheard in Dim Carcosa.",
			GENERIC = "It must die unheard in Dim Carcosa.",
		},
		LIGHTNINGGOAT = 
		{
			GENERIC = "'It must die unheard in Dim Carcosa.",
			CHARGED = "It must die unheard in Dim Carcosa.",
		},
		LIGHTNINGGOATHORN = "It must die unheard in Dim Carcosa.",
		GOATMILK = "It must die unheard in Dim Carcosa.",
		LITTLE_WALRUS = "It must die unheard in Dim Carcosa.",
		LIVINGLOG = "It must die unheard in Dim Carcosa.",
		LOCKEDWES = "It must die unheard in Dim Carcosa..",
		LOG =
		{
			BURNING = "It must die unheard in Dim Carcosa.",
			GENERIC = "It must die unheard in Dim Carcosa..",
		},
		LUREPLANT = "It must die unheard in Dim Carcosa.",
		LUREPLANTBULB = "It must die unheard in Dim Carcosa.",
		MALE_PUPPET = "It must die unheard in Dim Carcosa.",
		MANDRAKE =
		{
			DEAD = "It must die unheard in Dim Carcosa..",
			GENERIC = "It must die unheard in Dim Carcosa.",
			PICKED = "It must die unheard in Dim Carcosa.",
		},
		MANDRAKESOUP = "It must die unheard in Dim Carcosa.",
		MANDRAKE_COOKED = "Stranger still is lost Carcosa.",
		MARBLE = "Stranger still is lost Carcosa.",
		MARBLEPILLAR = "Stranger still is lost Carcosa.",
		MARBLETREE = "Stranger still is lost Carcosa.",
		MARSH_BUSH =
		{
			BURNING = "Stranger still is lost Carcosa.",
			GENERIC = "Stranger still is lost Carcosa.",
			PICKED = "Stranger still is lost Carcosa.",
		},
		BURNT_MARSH_BUSH = "Stranger still is lost Carcosa.",
		MARSH_PLANT = "Stranger still is Lost Carcosa.",
		MARSH_TREE =
		{
			BURNING = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa..",
			CHOPPED = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
		},
		MAXWELL = "Stranger still is Lost Carcosa.",
		MAXWELLHEAD = "Stranger still is Lost Carcosa.",
		MAXWELLLIGHT = "Stranger still is Lost Carcosa.",
		MAXWELLLOCK = "Stranger still is Lost Carcosa.",
		MAXWELLTHRONE = "Stranger still is Lost Carcosa.",
		MEAT = "Stranger still is Lost Carcosa.",
		MEATBALLS = "Stranger still is Lost Carcosa.",
		MEATRACK =
		{
			DONE = "Stranger still is Lost Carcosa.",
			DRYING = "Stranger still is Lost Carcosa.",
			DRYINGINRAIN = "Stranger still is Lost Carcosa..",
			GENERIC = "Stranger still is Lost Carcosa..",
			BURNT = "Stranger still is Lost Carcosa..",
		},
		MEAT_DRIED = "Stranger still is Lost Carcosa..",
		MERM = "Stranger still is Lost Carcosa.",
		MERMHEAD = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa..",
		},
		MERMHOUSE = 
		{
			GENERIC = "Brethren from another place.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		MINERHAT = "Stranger still is Lost Carcosa.",
		MONKEY = "Stranger still is Lost Carcosa.",
		MONKEYBARREL = "Stranger still is Lost Carcosa.",
		MONSTERLASAGNA = "Stranger still is Lost Carcosa.",
		FLOWERSALAD = "Stranger still is Lost Carcosa.",
        ICECREAM = "Stranger still is Lost Carcosa.",
        WATERMELONICLE = "Stranger still is Lost Carcosa.",
        TRAILMIX = "Stranger still is Lost Carcosa.",
        HOTCHILI = "Stranger still is Lost Carcosa.",
        GUACAMOLE = "Stranger still is Lost Carcosa.",
		MONSTERMEAT = "Strings of flesh from those beyond.",
		MONSTERMEAT_DRIED = "Strings of flesh from those beyond..",
		MOOSE = "Stranger still is Lost Carcosa.",
		MOOSEEGG = "Stranger still is Lost Carcosa.",
		MOSSLING = "Stranger still is Lost Carcosa.",
		FEATHERFAN = "Stranger still is Lost Carcosa.",
		GOOSE_FEATHER = "Stranger still is Lost Carcosa.",
		STAFF_TORNADO = "Stranger still is Lost Carcosa.",
		MOSQUITO =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HELD = "Stranger still is Lost Carcosa.",
		},
		MOSQUITOSACK = "Stranger still is Lost Carcosa.",
		MOUND =
		{
			DUG = "Stranger still is Lost Carcosa..",
			GENERIC = "Stranger still is Lost Carcosa.",
		},
		NIGHTLIGHT = "Stranger still is Lost Carcosa.",
		NIGHTMAREFUEL = "Stranger still is Lost Carcosa.",
		NIGHTSWORD = "Stranger still is Lost Carcosa.",
		NITRE = "Stranger still is Lost Carcosa.",
		ONEMANBAND = "Stranger still is Lost Carcosa.",
		PANDORASCHEST = "A passage from another place?",
		PANFLUTE = "The soft songs of another world...",
		PAPYRUS = "Where my words shall be written.",
		PENGUIN = "Stranger still is Lost Carcosa.",
		PERD = "Stranger still is Lost Carcosa.",
		PEROGIES = "Stranger still is Lost Carcosa.",
		PETALS = "Stranger still is Lost Carcosa.",
		PETALS_EVIL = "Stranger still is Lost Carcosa.",
		PHLEGM = "Stranger still is Lost Carcosa.",
		PICKAXE = "Stranger still is Lost Carcosa.",
		PIGGYBACK = "Stranger still is Lost Carcosa.",
		PIGHEAD = 
		{	
			GENERIC = "Looks like an offering to the beast.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		PIGHOUSE =
		{
			FULL = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			LIGHTSOUT = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		PIGKING = "Stranger still is Lost Carcosa.",
		PIGMAN =
		{
			DEAD = "Stranger still is Lost Carcosa.",
			FOLLOWER = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			GUARD = "Stranger still is Lost Carcosa.",
			WEREPIG = "Stranger still is Lost Carcosa.",
		},
		PIGSKIN = "Stranger still is Lost Carcosa.",
		PIGTENT = "Stranger still is Lost Carcosa.",
		PIGTORCH = "Stranger still is Lost Carcosa.",
		PINECONE = 
		{
		    GENERIC = "Stranger still is Lost Carcosa.",
		    PLANTED = "Stranger still is Lost Carcosa.",
		},
		PITCHFORK = "Stranger still is Lost Carcosa.",
		PLANTMEAT = "Stranger still is Lost Carcosa.",
		PLANTMEAT_COOKED = "Stranger still is Lost Carcosa.",
		PLANT_NORMAL =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			GROWING = "Stranger still is Lost Carcosa.",
			READY = "Stranger still is Lost Carcosa.",
			WITHERED = "Stranger still is Lost Carcosa.",
		},
		POMEGRANATE = "Stranger still is Lost Carcosa.",
		POMEGRANATE_COOKED = "Stranger still is Lost Carcosa.",
		POMEGRANATE_SEEDS = "Stranger still is Lost Carcosa.",
		POND = "Stranger still is Lost Carcosa.",
		POOP = "Stranger still is Lost Carcosa.",
		FERTILIZER = "Stranger still is Lost Carcosa.",
		PUMPKIN = "Stranger still is Lost Carcosa.",
		PUMPKINCOOKIE = "Stranger still is Lost Carcosa.",
		PUMPKIN_COOKED = "Stranger still is Lost Carcosa.",
		PUMPKIN_LANTERN = "Stranger still is Lost Carcosa.",
		PUMPKIN_SEEDS = "Stranger still is Lost Carcosa.",
		PURPLEAMULET = "Stranger still is Lost Carcosa.",
		PURPLEGEM = "Stranger still is Lost Carcosa.",
		RABBIT =
		{
			GENERIC = "Where flap the tatters of the King?",
			HELD = "Where flap the tatters of the King?",
		},
		RABBITHOLE = 
		{
			GENERIC = "Where flap the tatters of the King?",
			SPRING = "Where flap the tatters of the King?",
		},
		RAINOMETER = 
		{	
			GENERIC = "Where flap the tatters of the King?",
			BURNT = "Where flap the tatters of the King?",
		},
		RAINCOAT = "Where flap the tatters of the King?",
		RAINHAT = "Where flap the tatters of the King?",
		RATATOUILLE = "Where flap the tatters of the King?",
		RAZOR = "Where flap the tatters of the King?",
		REDGEM = "Stranger still is Lost Carcosa.",
		RED_CAP = "Stranger still is Lost Carcosa.",
		RED_CAP_COOKED = "Stranger still is Lost Carcosa.",
		RED_MUSHROOM =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			INGROUND = "Stranger still is Lost Carcosa.",
			PICKED = "Stranger still is Lost Carcosa.",
		},
		REEDS =
		{
			BURNING = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			PICKED = "Stranger still is Lost Carcosa..",
		},
        RELIC = 
        {
            GENERIC = "Ancient clutter.",
            BROKEN = "Stranger still is Lost Carcosa.",
        },
        RUINS_RUBBLE = "Stranger still is Lost Carcosa.",
        RUBBLE = "Stranger still is Lost Carcosa..",
		RESEARCHLAB = 
		{	
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa..",
		},
		RESEARCHLAB2 = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa..",
		},
		RESEARCHLAB3 = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		RESEARCHLAB4 = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		RESURRECTIONSTATUE = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},		RESURRECTIONSTONE = "Ancient powers reside within?",
		ROBIN =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HELD = "Stranger still is Lost Carcosa.",
		},
		ROBIN_WINTER =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HELD = "Stranger still is Lost Carcosa.",
		},
		ROBOT_PUPPET = "Stranger still is Lost Carcosa.",
		ROCK_LIGHT =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			OUT = "Stranger still is Lost Carcosa.",
			LOW = "Stranger still is Lost Carcosa.",
			NORMAL = "Stranger still is Lost Carcosa.",
		},
		ROCK = "Stranger still is Lost Carcosa.",
		ROCK_ICE = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			MELTED = "Stranger still is Lost Carcosa.",
		},
		ROCK_ICE_MELTED = "Stranger still is Lost Carcosa.",
		ICE = "The twin suns have abandoned this.",
		ROCKS = "Stranger still is Lost Carcosa.",
        ROOK = "Stranger still is Lost Carcosa.",
		ROPE = "Stranger still is Lost Carcosa.",
		ROTTENEGG = "What a magnificent scent.",
		SANITYROCK =
		{
			ACTIVE = "Stranger still is Lost Carcosa.",
			INACTIVE = "Stranger still is Lost Carcosa.",
		},
		SAPLING =
		{
			BURNING = "The twin suns of have punished it.",
			WITHERED = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			PICKED = "Stranger still is Lost Carcosa.",
		},
		SEEDS = "Stranger still is Lost Carcosa.",
		SEEDS_COOKED = "Stranger still is Lost Carcosa.",
		SEWING_KIT = "Stranger still is Lost Carcosa.",
		SHOVEL = "Stranger still is Lost Carcosa.",
		SILK = "Stranger still is Lost Carcosa.",
		SKELETON = "Stranger still is Lost Carcosa.",
		SCORCHED_SKELETON = "Stranger still is Lost Carcosa.",
		SKELETON_PLAYER = "Stranger still is Lost Carcosa.",
		SKULLCHEST = "Stranger still is Lost Carcosa.",
		SMALLBIRD =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HUNGRY = "Stranger still is Lost Carcosa.",
			STARVING = "Stranger still is Lost Carcosa.",
		},
		SMALLMEAT = "A tiny chunk of death.",
		SMALLMEAT_DRIED = "Stranger still is Lost Carcosa..",
		SPAT = "Stranger still is Lost Carcosa.",
		SPEAR = "Stranger still is Lost Carcosa.",
		SPIDER =
		{
			DEAD = "Left to decay.",
			GENERIC = "Strange moons circle through the skies.",
			SLEEPING = "Stranger still is Lost Carcosa..",
		},
		SPIDERDEN = "Stranger still is Lost Carcosa.",
		SPIDEREGGSACK = "Stranger still is Lost Carcosa.",
		SPIDERGLAND = "Stranger still is Lost Carcosa..",
		SPIDERHAT = "Stranger still is Lost Carcosa.",
		SPIDERQUEEN = "A small ancient one?",
		SPIDER_WARRIOR =
		{
			DEAD = "Left to decay in tatters.",
			GENERIC = "A yellow brethen.",
			SLEEPING = "Let the nightmares take it.",
		},
		SPOILED_FOOD = "As it should be.",
		STATUEHARP = "Stranger still is Lost Carcosa.",
		STATUEMAXWELL = "Stranger still is Lost Carcosa.",
		STEELWOOL = "Stranger still is Lost Carcosa.",
		STINGER = "Stranger still is Lost Carcosa.",
		STRAWHAT = "This shall not thwart the twin suns.",
		STUFFEDEGGPLANT = "Stranger still is Lost Carcosa.",
		SUNKBOAT = "Stranger still is Lost Carcosa.",
		SWEATERVEST = "Tatters!",
		REFLECTIVEVEST = "Stranger still is Lost Carcosa.",
		HAWAIIANSHIRT = "Stranger still is Lost Carcosa.",
		TAFFY = "Stranger still is Lost Carcosa.",
		TALLBIRD = "One eyed brethren.",
		TALLBIRDEGG = "Stranger still is Lost Carcosa.",
		TALLBIRDEGG_COOKED = "Stranger still is Lost Carcosa.",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			HOT = "The twin suns punish it!",
			LONG = "Strange moons circle through the skies.",
			SHORT = "Stranger still is Lost Carcosa..",
		},
		TALLBIRDNEST =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			PICKED = "Stranger still is Lost Carcosa.",
		},
		TEENBIRD =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			HUNGRY = "Stranger still is Lost Carcosa.",
			STARVING = "Stranger still is Lost Carcosa.",
		},
		TELEBASE =	-- Duplicated
		{
			VALID = "Stranger still is Lost Carcosa.",
			GEMS = "Stranger still is Lost Carcosa.",
		},
		GEMSOCKET = -- Duplicated
		{
			VALID = "Stranger still is Lost Carcosa.",
			GEMS = "Stranger still is Lost Carcosa.",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
			LOCKED = "Stranger still is Lost Carcosa.",
			PARTIAL = "Stranger still is Lost Carcosa.",
		},
		TELEPORTATO_BOX = "Stranger still is Lost Carcosa.",
		TELEPORTATO_CRANK = "...",
		TELEPORTATO_POTATO = "Stranger still is Lost Carcosa.",
		TELEPORTATO_RING = "Stranger still is Lost Carcosa.",
		TELESTAFF = "Stranger still is Lost Carcosa.",
		TENT = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa..",
		},
		SIESTAHUT = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		TENTACLE = "Friends from the deep.",
		TENTACLESPIKE = "A fine weapon.",
		TENTACLESPOTS = "Stranger still is Lost Carcosa.",
		TENTACLE_PILLAR = "Stranger still is Lost Carcosa.",
		TENTACLE_PILLAR_ARM = "Stranger still is Lost Carcosa.",
		TENTACLE_GARDEN = "Stranger still is Lost Carcosa.",
		TOPHAT = "Stranger still is Lost Carcosa.",
		TORCH = "Stranger still is Lost Carcosa.",
		TRANSISTOR = "Stranger still is Lost Carcosa.",
		TRAP = "Stranger still is Lost Carcosa..",
		TRAP_TEETH = "Stranger still is Lost Carcosa.",
		TRAP_TEETH_MAXWELL = "Stranger still is Lost Carcosa.",
		TREASURECHEST = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		TREASURECHEST_TRAP = "Stranger still is Lost Carcosa.",
		TREECLUMP = "Stranger still is Lost Carcosa.",
		TRINKET_1 = "Stranger still is Lost Carcosa.", --Melty Marbles
		TRINKET_2 = "Stranger still is Lost Carcosa.", --Fake Kazoo
		TRINKET_3 = "Stranger still is Lost Carcosa.", --Gord's Knot
		TRINKET_4 = "Stranger still is Lost Carcosa.", --Gnome
		TRINKET_5 = "Stranger still is Lost Carcosa.", --Tiny Rocketship
		TRINKET_6 = "Stranger still is Lost Carcosa.", --Frazzled Wires
		TRINKET_7 = "Stranger still is Lost Carcosa.", --Ball and Cup
		TRINKET_8 = "Stranger still is Lost Carcosa.", --Hardened Rubber Bung
		TRINKET_9 = "Stranger still is Lost Carcosa.", --Mismatched Buttons
		TRINKET_10 = "Stranger still is Lost Carcosa..", --Second-hand Dentures
		TRINKET_11 = "Stranger still is Lost Carcosa.", --Lying Robot
		TRINKET_12 = "A fallen comrade.", --Dessicated Tentacle
		TRINKET_13 = "Stranger still is Lost Carcosa.", --Gnome (female)
		TRUNKVEST_SUMMER = "Stranger still is Lost Carcosa.",
		TRUNKVEST_WINTER = "Stranger still is Lost Carcosa.",
		TRUNK_COOKED = "Stranger still is Lost Carcosa.",
		TRUNK_SUMMER = "Stranger still is Lost Carcosa.",
		TRUNK_WINTER = "Stranger still is Lost Carcosa..",
		TUMBLEWEED = "A lost friend.",
		TURF_CARPETFLOOR = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_CHECKERFLOOR = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_DIRT = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_FOREST = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_GRASS = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_MARSH = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_ROAD = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_ROCKY = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_SAVANNA = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURF_WOODFLOOR = "Stranger still is Lost Carcosa.",	-- Duplicated
		TURKEYDINNER = "What need have I for food?",
		TWIGS = "Stranger still is Lost Carcosa.",
		UMBRELLA = "Stranger still is Lost Carcosa.",
		GRASS_UMBRELLA = "Stranger still is Lost Carcosa.",
		UNIMPLEMENTED = "Stranger still is Lost Carcosa.",
		WAFFLES = "What need have I for food?",
		WALL_HAY = 
		{	
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		WALL_HAY_ITEM = "Stranger still is Lost Carcosa.",
		WALL_STONE = "Stranger still is Lost Carcosa..",
		WALL_STONE_ITEM = "Stranger still is Lost Carcosa.",
		WALL_RUINS = "An ancient piece of wall.",
		WALL_RUINS_ITEM = "Stranger still is Lost Carcosa.",
		WALL_WOOD = 
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			BURNT = "Stranger still is Lost Carcosa!",
		},
		WALL_WOOD_ITEM = "Stranger still is Lost Carcosa.",
		WALL_MOONROCK = "Stranger still is Lost Carcosa.",
		WALL_MOONROCK_ITEM = "Stranger still is Lost Carcosa..",
		WALRUS = "Stranger still is Lost Carcosa..",
		WALRUSHAT = "Stranger still is Lost Carcosa.",
		WALRUS_CAMP =
		{
			EMPTY = "Stranger still is Lost Carcosa.",
			GENERIC = "Stranger still is Lost Carcosa.",
		},
		WALRUS_TUSK = "Stranger still is Lost Carcosa.",
		WARG = "Stranger still is Lost Carcosa.",
		WASPHIVE = "Stranger still is Lost Carcosa.",
		WATERMELON = "Stranger still is Lost Carcosa.",
		WATERMELON_COOKED = "Stranger still is Lost Carcosa.",
		WATERMELONHAT = "Stranger still is Lost Carcosa.",
		WETGOOP = "What need have I for food?",
		WINTERHAT = "For when the twin suns abandon us.",
		WINTEROMETER = 
		{
			GENERIC = "Stranger still is Lost Carcosa..",
			BURNT = "Stranger still is Lost Carcosa.",
		},
		WORMHOLE =
		{
			GENERIC = "Stranger still is Lost Carcosa.",
			OPEN = "Stranger still is Lost Carcosa.",
		},
		WORMHOLE_LIMITED = "Stranger still is Lost Carcosa.",
		ACCOMPLISHMENT_SHRINE = "Stranger still is Lost Carcosa.",        
		LIVINGTREE = "Stranger still is Lost Carcosa.",
		ICESTAFF = "Stranger still is Lost Carcosa.",
		REVIVER = "Stranger still is Lost Carcosa.",
		LIFEINJECTOR = "Stranger still is Lost Carcosa.",
		SKELETON_PLAYER =
		{
			MALE = "%s must've died preforming an important experiment with %s.",
			FEMALE = "%s must've died preforming an important experiment with %s.",
			ROBOT = "%s must've died preforming an important experiment with %s.",
			DEFAULT = "%s must've died preforming an important experiment with %s.",
		},
		HUMANMEAT = "The best of foods.",
		HUMANMEAT_COOKED = "For consumption.",
		HUMANMEAT_DRIED = "Best of foods in any form.",
		MOONROCKNUGGET = "Stranger still is Lost Carcosa.",
	},
	DESCRIBE_GENERIC = "It's a... thing.",
	DESCRIBE_TOODARK = "Strange is the night where black stars rise.",
	DESCRIBE_SMOLDERING = "The twin suns are upon it.",
	EAT_FOOD =
	{
		TALLBIRDEGG_CRACKED = "Stranger still is Lost Carcosa.",
	},
}
