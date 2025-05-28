---@class TuYang_WoodRateGreenProj_2_9_C:UniversalProjectileBase
---@field P_Drop_Trail_Green UParticleSystemComponent
---@field STCustomMesh USTCustomMeshComponent
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
--Edit Below--
local TuYang_WoodRateGreenProj_2_9 = {}

function TuYang_WoodRateGreenProj_2_9:ReceiveBeginPlay()
    TuYang_WoodRateGreenProj_2_9.SuperClass.ReceiveBeginPlay(self)
    UGCLog.Log("[maoyu]:TuYang_WoodRateGreenProj_2_9:ReceiveBeginPlay" ,self)
end

function TuYang_WoodRateGreenProj_2_9:ReceiveLaunchBullet()
    TuYang_WoodRateGreenProj_2_9.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill2_9",self:GetOwner())
end


-- 对击中的怪物造成dot伤害
function TuYang_WoodRateGreenProj_2_9:ReceiveOnImpact(HitResult)
    UGCLog.Log("[maoyu]:TuYang_WoodRateGreenProj_2_9:ReceiveOnImpact")
    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_WoodRateGreenProj_2_9 - No valid FoundTargets found")
            return
        end

        if UE.IsValid(Monster) then
            UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
            UGCLog.Log("[maoyu]:TuYang_WoodRateGreenProj_2_9:ApplyDamage")
        end

        --local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))

        --UGCPersistEffectSystem.AddBuffByClass(Monster, BurningBuffClass)

        --- 每秒后对怪物造成伤害
        -- self.DamageTimer = Timer.InsertTimer(1.0, function()
        --     if UE.IsValid(Monster) then
        --         UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
        --         UGCLog.Log("[maoyu]:TuYang_FireRateGreenProj_2_2:ApplyDamage")
        --     end
        -- end, true)
        -- --- 3秒后移除定时器
        -- Timer.InsertTimer(3.5, function()
        --     if self.DamageTimer ~= nil then
        --         Timer.RemoveTimer(self.DamageTimer)
        --         self.DamageTimer = nil
        --     end
        -- end, false)
    end

    TuYang_WoodRateGreenProj_2_9.SuperClass.ReceiveOnImpact(self,HitResult)
end

--[[
function TuYang_WoodRateGreenProj_2_9:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_WoodRateGreenProj_2_9.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_WoodRateGreenProj_2_9:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_WoodRateGreenProj_2_9.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_WoodRateGreenProj_2_9:TickMovementPath(DeltaTime)
    TuYang_WoodRateGreenProj_2_9.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_WoodRateGreenProj_2_9