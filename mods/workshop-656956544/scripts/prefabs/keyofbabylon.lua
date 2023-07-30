local assets=
{
Asset("ANIM", "anim/keyofbabylon_build.zip"),--这个是放在地上的动画文件
Asset("ANIM", "anim/swap_keyofbabylon_build.zip"), --这个是手上动画
Asset("ATLAS", "images/inventoryimages/keyofbabylon.xml"),--物品栏图标的xml
Asset("IMAGE", "images/inventoryimages/keyofbabylon.tex"),--物品栏图标的图片
}

local prefabs =
{
    "gate_of_babylon",
 
}

local function dosummon_gate(staff,caster,caibao_num)
--------------定义变量---------------
    local x,y,z =caster.Transform:GetWorldPosition()
-------------函数运行-----------------------    
    for i=1,caibao_num do  ----对每个库存运行，将之随机生成在附近
        local xx = x+math.random(-3,3)
        local zz = z+math.random(-3,3)
        SpawnPrefab("caster_ring_fx").Transform:SetPosition(xx,y,zz)
        SpawnPrefab("gate_of_babylon").Transform:SetPosition(xx,y,zz)
    end
           
    staff.components.finiteuses:SetUses(0) --释放库存量
    return true
------------运行结束--------------------------------
end

local function dofill_gate(staff,caster,caibao_JC)
--------------定义变量---------------
--此时caibao=0，钥匙为空库存
local caibao_current = caibao_JC.components.stackable.stacksize --物品栏库存
local amt = math.min(20,caibao_current) --取物品栏库存填充钥匙库存
-------------函数运行-----------------
    caster.components.talker:Say("可填充王之财宝"..amt.."个，进行填充。")

    staff.components.finiteuses.current = staff.components.finiteuses.current+amt
    staff:PushEvent("percentusedchange", {percent = staff.components.finiteuses:GetPercent()})
    ------钥匙库存增加--------

    if caibao_current-amt <= 0 then
        caibao_JC:Remove()
    else
        caibao_JC.components.stackable:SetStackSize(caibao_current-amt)
    end
------------运行结束--------------------------------
end

local function summon_spell2(staff,target)
    local caster = staff.components.inventoryitem.owner
    caster.components.talker:Say("这个王律键已经过期，换成新的吧！攻击标记目标，按C召唤王财")
    SpawnPrefab("key_of_babylon").Transform:SetPosition(caster:GetPosition():Get())
    staff:Remove()

end

local function summon_spell(staff,target)
--------------定义变量---------------
    local caster = staff.components.inventoryitem.owner -----施法者（如果不是闪闪提示无法释放）
    local caibao = staff.components.finiteuses.current ------钥匙剩余库存
    local caibao_JC=caster.components.inventory:FindItem(   ----物品栏库存检查
        function (item)
            return (item.prefab == "caibao")
        end    
    )
    local staff = staff-- 导入函数，不知道是不是必须
-------------函数运行-----------------------
    if caster and caster:HasTag("gilgamesh") then ---判断是否是闪闪
        
        if caibao > 0 then  ----如果钥匙没空，释放库存
            dosummon_gate(staff,caster,caibao)
        elseif caibao_JC then ---钥匙空了，检查物品栏，如果有库存，填充
            dofill_gate(staff,caster,caibao_JC)
        else                   ---物品栏没有库存，提示
            caster.components.talker:Say("库存不足！")
        end

    else caster.components.talker:Say("我不是钥匙的主人。")---不是闪闪，无法释放库存。
    end
------------运行结束--------------------------------
end

local function key_attack(inst,attacker,data)
    local target = attacker.components.combat.target
    if target ~=nil and not target:HasTag("gilgamesh_target") then
        target:AddTag("gilgamesh_target") 
        attacker.components.talker:Say("标记敌人！")

       

    end
    -------召唤特效----------
    --[[
    local target = attacker.components.combat.target
    local gate_attack =SpawnPrefab("gate_of_babylon_attack_fx")
    gate_attack.Transform:SetPosition(inst:GetPosition():Get())
    gate_attack:FacePoint(target:GetPosition())
    ]]

    -------消耗耐久-----
    inst.components.finiteuses:Use(-1)
    --if inst.components.finiteuses.current == 0 then
    inst:PushEvent("percentusedchange", {percent = inst.components.finiteuses:GetPercent()})
  --  end
end


local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == "caibao" then
        if inst.components.finiteuses.current <= 19 then 
            inst.components.finiteuses.current = inst.components.finiteuses.current+1
            inst:PushEvent("percentusedchange", {percent = inst.components.finiteuses:GetPercent()})
          
        end
    end
end

local function OnRefuseItem(inst, giver, item)
    if item.prefab == "caibao" then
        giver.components.talker:Say("有趣，贪得无厌。")
    else
        giver.components.talker:Say("赝品。")
    end
   -- inst.SoundEmitter:PlaySound("dontstarve/zg/shotgun/cantfill")
end

local function AcceptTest(inst, item)
    return inst.components.finiteuses.current <= 19 and item.prefab == "caibao"
end


local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_keyofbabylon_build", "symbol")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
       -- if inst.components.container ~= nil then
       -- inst.components.container:Open(owner)
   -- end
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
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("keyofbabylon_bank")
    inst.AnimState:SetBuild("keyofbabylon_build")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("key_of_babylon")
    --inst:AddTag("flute")
    inst:AddTag("backpack")


   if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "keyofbabylon"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/keyofbabylon.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
    
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetRange(15,15)
    inst.components.weapon:SetOnAttack(key_attack)

    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(summon_spell2)
    inst.components.spellcaster.canuseonpoint = true
    inst.components.spellcaster.canuseonpoint_water = true
    inst.components.spellcaster.quickcast = true

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(20)
    inst.components.finiteuses:SetUses(2)
    --inst.components.finiteuses:SetOnFinished(inst.Remove)
   --inst.components.finiteuses:SetConsumption(summon_spell, 10)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(AcceptTest)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem

    MakeHauntableLaunch(inst)

    return inst
end

STRINGS.NAMES.KEYOFBABYLON = "王律钥匙"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KEYOFBABYLON = "世上的一切皆为我所有。"

return  Prefab("common/inventory/keyofbabylon", fn, assets, prefabs) 