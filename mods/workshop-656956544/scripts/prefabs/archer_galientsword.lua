

local assets=
{
    Asset("ANIM", "anim/galientsword.zip"),
    Asset("ANIM", "anim/swap_galientsword.zip"),
  
    Asset("ATLAS", "images/inventoryimages/galientsword.xml"),
    Asset("IMAGE", "images/inventoryimages/galientsword.tex"),
}

local function onattack_ea(inst, attacker, data)

    local x, y, z = inst.Transform:GetWorldPosition()
    if not attacker:HasTag("gilgamesh") then
        attacker.components.health:DoDelta(-5)
        attacker.components.sanity:DoDelta(-10)
        SpawnPrefab("statue_transition_2")
    elseif attacker then

    end
end

local function OnDropped(inst)
    inst.AnimState:PlayAnimation("idle")
end

local function OnCaught(inst, catcher)
    if catcher then
        if catcher.components.inventory then
            if inst.components.equippable and not catcher.components.inventory:GetEquippedItem(inst.components.equippable.equipslot) then
                catcher.components.inventory:Equip(inst)
            else
                catcher.components.inventory:GiveItem(inst)
            end
            catcher:PushEvent("catch")
        end
    end
end

local function OnThrown(inst, owner)
inst.AnimState:PlayAnimation("planted")
end



local function OnHit(inst, owner, target)
    OnDropped(inst)
    local pos = Vector3(target.Transform:GetWorldPosition())

end



local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_galientsword", "swap_galientsword")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

end


local function ea_spell(staff,target)

    local caster=staff.components.inventoryitem.owner
    local range=25
    local x,y,z=caster.Transform:GetWorldPosition()  
    local ea_mana=caster.components.sanity.current
    local ea_mana_max=caster.components.sanity.max
    local ea_mana_afterspell=ea_mana-100
    local ents = TheSim:FindEntities(x, y, z, range)   
  --  local ents = TheSim:FindEntities(x, y, z, range)
      ---------EA挥舞时需要付出的代价------------------

    if not caster:HasTag("gilgamesh") then
        caster.components.talker:Say("不！这把剑抽干了我的能量！！！")
        caster.components.health:Kill()
        elseif ea_mana < 150 then
            caster.components.talker:Say("我需要更多的理智(至少150)！")
                elseif not ents then 
                    caster.components.talker:Say("没什么值得本王动手的。")
                        elseif not caster.components.health:IsDead() then
                            caster.components.sanity:DoDelta(-100)
                            caster.components.hunger:DoDelta(-20)
                            caster.components.talker:Say("天地乖离，开辟之星！")

    if caster then
      for aaa = x-6, x+6, 1 do
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(aaa,y,z-6)
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(aaa,y,z+6)
      end
      for bbb = z-6, z+6, 1 do
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(x-6,y,bbb)
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(x+6,y,bbb)
      end

          for ccc = x-12, x+12, 1 do
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(ccc,y,z-12)
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(ccc,y,z+12)
      end
      for ddd = z-12, z+12, 1 do
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(x-12,y,ddd)
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(x+12,y,ddd)
      end

    end


    
                            --caster.components.talker:Say("天地乖离，开辟之星！("..ea_mana_afterspell.."/"..ea_mana_max..")")

        for i, v in ipairs(ents) do
            if v:IsValid() and v.components.workable ~= nil and v.components.workable:CanBeWorked() then
                SpawnPrefab("collapse_small").Transform:SetPosition(v.Transform:GetWorldPosition())
                v.components.workable:Destroy(caster)
            elseif v.components.health and not v:HasTag("player") then
                v.components.health:DoDelta(-3000)
            elseif v:HasTag("smashable") then
                v.components.health:Kill()
            end
        end
    end
end

   
  
local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
 
end



local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("galientsword")
    inst.AnimState:SetBuild("galientsword")
    inst.AnimState:PlayAnimation("idle")
    inst.MiniMapEntity:SetIcon("galientsword.tex")
 
    inst:AddTag("sharp")
 
    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()

    inst:AddComponent("weapon")
    --inst.components.weapon:SetRange(10,10)
    inst.components.weapon:SetDamage(50)
    inst.components.weapon:SetOnAttack(onattack_ea)

    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(ea_spell)
    inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster.canuseonpoint_water = true
  
    inst:AddComponent("inspectable")
      
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "galientsword"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/galientsword.xml"
		      
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
     
    return inst
end

STRINGS.NAMES.ARCHER_GALIENTSWORD = "乖离剑·EA"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARCHER_GALIENTSWORD = "远离自己的王国。"
return  Prefab("common/inventory/archer_galientsword", fn, assets, prefabs) 