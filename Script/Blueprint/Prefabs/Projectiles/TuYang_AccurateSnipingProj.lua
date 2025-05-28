---@class TuYang_AccurateSnipingProj_C:UniversalProjectileBase
---@field STCustomMesh USTCustomMeshComponent
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_AccurateSnipingProj = {}

--[[
function TuYang_AccurateSnipingProj:ReceiveLaunchBullet()
    TuYang_AccurateSnipingProj.SuperClass.ReceiveLaunchBullet(self)
end
--]]

--[[
function TuYang_AccurateSnipingProj:ReceiveOnImpact(HitResult)
    TuYang_AccurateSnipingProj.SuperClass.ReceiveOnImpact(self,HitResult)
end
--]]

--[[
function TuYang_AccurateSnipingProj:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_AccurateSnipingProj.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_AccurateSnipingProj:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_AccurateSnipingProj.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_AccurateSnipingProj:TickMovementPath(DeltaTime)
    TuYang_AccurateSnipingProj.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_AccurateSnipingProj