local assets =
{
	Asset("ANIM", "anim/okitasword.zip"),
	--Asset("ANIM", "anim/symbol.zip"),
	Asset("ANIM", "anim/okitasword_swap.zip"),
	Asset("IMAGE", "images/inventoryimages/okitasword.tex"),         
	Asset("ATLAS", "images/inventoryimages/okitasword.xml"), 
	Asset("SOUNDPACKAGE","sound/music_okita.fev"),
	Asset("SOUND","sound/music_okita.fsb"),
}

local prefabs={ "pred","santu",  }




-- symbol_Tobi
-- local function symbol(inst,x,y,z)
-- local light = SpawnPrefab("santu")
-- --x=x+math.random(-15,15)
-- --z=z+math.random(-15,15)
-- local position=Vector3(x,y,z)
-- light.Transform:SetPosition(position:Get())
-- inst.SoundEmitter:PlaySound("music_sample/sound/sample")
-- end

-- -- creat light
-- local function createlight(inst, target,pos)
-- local x,y,z=pos:Get()
-- --inst.task= inst:DoPeriodicTask(0.5,function () symbol(inst,x,y,z)end)
-- --inst:DoTaskInTime(5,function()inst.task:Cancel() inst.task = nil end)
-- symbol(inst,x,y,z)
-- local caster = inst.components.inventoryitem.owner
-- end

local function createlight(inst, data)
local owner = inst.components.inventoryitem.owner

	if owner then
		--owner.sg:GoToState("hide")
		--local light = SpawnPrefab("")
		
		owner.freshfx = SpawnPrefab("butterfly")
		local px,py,pz = inst.Transform:GetWorldPosition()
		owner.freshfx.Transform:SetPosition(px-1,py,pz+1)
		owner.components.sanity:DoDelta(-5)
		owner.SoundEmitter:PlaySound("music_okita/music_okita/win")
		-- owner:DoTaskInTime(2.5, function()
		-- owner.freshfx:Remove()
		-- end)
		
		owner:DoTaskInTime(1, function()
					owner.AnimState:PlayAnimation("emoteXL_happycheer")
					owner.sg.statemem.action = owner.bufferedaction
					owner.sg:SetTimeout(2)
				end)
		
		
	end
end

local function onfinished(inst)
    inst:Remove()
end

local function onequip(inst, owner) 

	if owner.prefab == "okita" then
    owner.AnimState:OverrideSymbol("swap_object", "okitasword_swap", "claymore_swap")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	else
		owner:DoTaskInTime(0, function()
			local inv = owner.components.inventory 
			if inv then
				inv:GiveItem(inst)
			end
			local talker = owner.components.talker 
			if talker then
				talker:Say("This is only for Okita!")
			end
		end)
	end
	
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
     anim:SetBank("okitasword")
    anim:SetBuild("okitasword")
    anim:PlayAnimation("idle")
    
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddTag("sharp")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(40)
	inst.components.weapon:SetRange(2) 
    
    -------
	

	
	inst:AddComponent("spellcaster")
	inst.components.spellcaster:SetSpellFn(createlight)
	inst.components.spellcaster.canuseonpoint =true
	
    
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1200)
    inst.components.finiteuses:SetUses(1200)
    inst.components.finiteuses:SetOnFinished( onfinished )

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/okitasword.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	
	
	-- inst.components.inventoryitem.onputininventoryfn = function(inst, owner) 
		-- if not (owner.prefab == "okita") then 
			-- if not owner.components.container then 
				-- inst:DoTaskInTime(0.1, function()
					-- owner.components.inventory:DropItem(inst)
					-- owner.components.talker:Say("It's too hard for me!")
				-- end)
			-- elseif 	owner.components.container and not (owner.components.container.opener.prefab == "okita") then
				-- inst:DoTaskInTime(0.1, function()
					-- owner.components.container:DropItem(inst)
					-- owner.components.container.opener.components.talker:Say("It's too hard for me!")
				-- end)
			-- end
		-- end
	-- end
	
    
    return inst
end



return Prefab( "common/inventory/okitasword", fn, assets) 
