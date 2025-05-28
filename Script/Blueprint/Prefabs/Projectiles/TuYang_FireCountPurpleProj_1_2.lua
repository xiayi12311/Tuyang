---@class TuYang_FireCountPurpleProj_1_2_C:UniversalProjectileBase
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_FireCountPurpleProj_1_2 = {}


function TuYang_FireCountPurpleProj_1_2:ReceiveLaunchBullet()
    TuYang_FireCountPurpleProj_1_2.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_2",self:GetOwner())
end


-- 对击中的怪物造成dot伤害
function TuYang_FireCountPurpleProj_1_2:ReceiveOnImpact(HitResult)
    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_FireCountPurpleProj_1_2: - No valid FoundTargets found")
            return
        end

        local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))

        local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_2",self:GetOwner())

        local controller = self:GetInstigatorController()
        local owner = self:GetOwner()
        local damage = self.FinallyDamage
        -- 每秒dot伤害系数
        local burningDamage = damage * 0.667
 
        --- 先造成一次导弹命中伤害
        if UE.IsValid(Monster) then
            UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
            UGCPersistEffectSystem.AddBuffByClass(Monster, BurningBuffClass)
        end

        --- 每秒后对怪物造成伤害
        local DamageTimer = Timer.InsertTimer(1.0, function()
            if UE.IsValid(Monster) then
                UGCGameSystem.ApplyDamage(Monster, burningDamage, controller, owner, nil)
            end
        end, true)

        --- 5秒后移除定时器
        Timer.InsertTimer(5.5, function()
            if DamageTimer ~= nil then
                Timer.RemoveTimer(DamageTimer)
                DamageTimer = nil
            end
        end, false)
    end

    TuYang_FireCountPurpleProj_1_2.SuperClass.ReceiveOnImpact(self,HitResult)
end

--[[
function TuYang_FireCountPurpleProj_1_2:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_FireCountPurpleProj_1_2.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_FireCountPurpleProj_1_2:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_FireCountPurpleProj_1_2.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_FireCountPurpleProj_1_2:TickMovementPath(DeltaTime)
    TuYang_FireCountPurpleProj_1_2.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_FireCountPurpleProj_1_2