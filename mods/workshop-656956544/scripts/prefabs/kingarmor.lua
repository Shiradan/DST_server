local assets =
{
    Asset("ANIM", "anim/kingarmor.zip"),
}

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_nightarmour") 
end



local function pickup(inst, owner)
    local pt = Vector3(owner.Transform:GetWorldPosition())
    local result_offset = FindValidPositionByFan(math.random()*2*PI, 10, 75, function(offset)
          local x,y,z = (pt + offset):Get()
          local ents = TheSim:FindEntities(x,y,z , 1)
          return not next(ents) 
    end)
    local ents2 = TheSim:FindEntities(pt.x,pt.y,pt.z, 5)
    for k,v in pairs(ents2) do
        if v.components.health and not v.components.health:IsDead() and not v:HasTag("player") and not v:HasTag("smallbird") and not v:HasTag("chester") and not v:HasTag("wall") and not v:HasTag("structure") then
           v.Transform:SetPosition((pt + result_offset):Get())
           SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
           owner.components.talker:Say("Zasshu，Stay away from me！杂修滚开！", 1)
        end
    end
end


local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_sanity", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)
     local light2 = inst.entity:AddLight()
    light2:SetFalloff(.3)
    light2:SetIntensity(.8)
    light2:SetRadius(3)
    light2:Enable(true)
    light2:SetColour(255/255, 88/255, 112/255) 


     inst.task = inst:DoPeriodicTask(3, function() pickup(inst, owner) end)
    --GetPlayer().SoundEmitter:PlaySound("dontstarve/music/music_hoedown", "beavermusic")
   -- opentop_onequip(inst, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)

  local light2 = inst.entity:AddLight()
    light2:SetFalloff(.3)
    light2:SetIntensity(.8)
    light2:SetRadius(3)
    light2:Enable(true)
    light2:SetColour(255/255, 88/255, 112/255) 

        if inst.task then inst.task:Cancel() inst.task = nil end
   -- GetPlayer().SoundEmitter:KillSound("beavermusic")
    --onunequip(inst, owner)
end

local function OnTakeDamage(inst, damage_amount)
    local owner = inst.components.inventoryitem.owner
    if owner then
        local sanity = owner.components.sanity
        if sanity then
            local unsaneness = damage_amount * TUNING.ARMOR_SANITY_DMG_AS_SANITY
            sanity:DoDelta(10)
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("armor_sanity")
    inst.AnimState:SetBuild("kingarmor")
    inst.AnimState:PlayAnimation("anim")
    --inst.AnimState:SetMultColour(1, 1, 1, 0.6)

    inst:AddTag("golden")

    inst.foleysound = "dontstarve/movement/foley/nightarmour"
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
      inst.components.inventoryitem.imagename = "armor_sanity"
  --  inst.components.inventoryitem.atlasname = "images/inventoryimages/galientsword.xml"

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(1000, 0.95)
    inst.components.armor.ontakedamage = OnTakeDamage

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    --inst.components.equippable.dapperness = TUNING.CRAZINESS_SMALL

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("kingarmor", fn, assets)