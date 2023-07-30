require "prefabutil"

function MakeRock(name)
    local fname = "rock_"..name
    local fn = nil

    local assets = 
    {
        Asset("ANIM", "anim/"..fname..".zip"),
    }
    local prefabs = {"rocks", "flint", "ores", "goldnugget"}    

    SetSharedLootTable( 'rock_iron',
    {
        {'rocks',  0.70},
        {'ore_iron',  0.70},
        {'flint',  0.70},
        {'goldnugget', 0.01},
        {'ore_cobalt', 0.01}
    })

    SetSharedLootTable( 'rock_cobalt',
    {	
    	{'rocks', 0.70},
    	{'ore_cobalt', 0.70},
    	{'flint', 0.70},
    	{'goldnugget', 0.03},
    	{'ore_iron', 0.03}
    })

    local MAXWORK = 10
    local MEDIUM  = 6
    local LOW     = 3

    local function OnWork(inst, worker, workleft)
        local pt = Point(inst.Transform:GetWorldPosition())
		if workleft <= 0 then
    		inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
    		inst.components.lootdropper:DropLoot(pt)
    		inst:Remove()
        elseif workleft < TUNING.ROCKS_MINE / 3 then
            inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
            inst.components.lootdropper:DropLoot(pt)
            inst.AnimState:PlayAnimation("low")
        elseif workleft < TUNING.ROCKS_MINE * 2 / 3 then
            inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
            inst.components.lootdropper:DropLoot(pt)
            inst.AnimState:PlayAnimation("med")
        else
            inst.AnimState:PlayAnimation("full")
        end
    end

    local function rock_fn(table)

        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
    
        MakeObstaclePhysics(inst, 1)

        inst.AnimState:SetBank(fname)
        inst.AnimState:SetBuild(fname)
        inst.AnimState:PlayAnimation("full")

        MakeSnowCoveredPristine(inst)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.entity:SetPristine()

        inst:AddComponent("lootdropper") 
        inst.components.lootdropper:SetChanceLootTable(table)

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.MINE)
        inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
        inst.components.workable:SetOnWorkCallback(OnWork)

        local color = 0.5 + math.random() * 0.5
        inst.AnimState:SetMultColour(color, color, color, 1)

        inst:AddComponent("inspectable")

        MakeSnowCovered(inst)

        MakeHauntableWork(inst)

        return inst
    end

    local function iron()
        local inst = rock_fn('rock_iron')
        if not TheWorld.ismastersim then
            return inst
        end
        inst.components.inspectable.nameoverride = "ROCK_IRON"
        return inst
    end 

    local function cobalt()
    	local inst = rock_fn('rock_cobalt')
    	if not TheWorld.ismastersim then
    		return inst
    	end
    	inst.components.inspectable.nameoverride = "ROCK_COBALT"
    	return inst
    end

    if name == "iron" then
        fn = iron
    elseif name == "cobalt" then
    	fn = cobalt
    end--[[
    elseif name == "titan" then
    	fn = titan
    end
    elseif name == "tungsten" then
    	fn = tungsten
    end]]

    return Prefab(fname, fn, assets, prefabs)
end
 
return MakeRock("iron"),
       MakeRock("cobalt")--[[,
       MakeRock("titan"),
       MakeRock("tungsten")]]