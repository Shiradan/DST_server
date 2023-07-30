local assets =
{
    Asset("ANIM", "anim/bishop_chargel.zip"),
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
 --inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround) 
inst.AnimState:SetRayTestOnBB(true)  
 anim:SetBank("bishop_chargel")
 anim:SetBuild("bishop_chargel")
 anim:PlayAnimation("idle") 
 inst:DoTaskInTime(10, inst.Remove)--
 inst.persists = false
 return inst
 end
 
 return Prefab("bishop_chargel", fn, assets)