local assets =
{
    Asset("ANIM", "anim/yohime_sword.zip"),
    Asset("ANIM", "anim/yohime_sword_swap.zip"),
	Asset( "ATLAS", "images/yohime_sword.xml" ),
}
local function fn()
 local inst = CreateEntity() 
 local trans = inst.entity:AddTransform()
 local anim = inst.entity:AddAnimState()
 inst.entity:AddNetwork() 
 inst:AddTag("FX") 
 inst:AddTag("NOCLICK") 
 MakeInventoryPhysics(inst) 
 RemovePhysicsColliders(inst) 
 inst.Physics:SetMass(0)  
 anim:SetBank("bishop_chargel")
 anim:SetBuild("bishop_chargel")
 anim:PlayAnimation("idle") 
 inst:DoTaskInTime(1, inst.Remove)--
 inst.persists = false
 return inst
 end
 
 return Prefab("bishop_chargel", fn, assets)