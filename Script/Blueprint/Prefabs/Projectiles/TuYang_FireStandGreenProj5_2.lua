---@class TuYang_FireStandGreenProj5_2_C:UniversalProjectileBase
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_FireStandGreenProj5_2 = {}


function TuYang_FireStandGreenProj5_2:ReceiveLaunchBullet()
    TuYang_FireStandGreenProj5_2.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill5_2",self:GetOwner())
end



function TuYang_FireStandGreenProj5_2:ReceiveOnImpact(HitResult)
    TuYang_FireStandGreenProj5_2.SuperClass.ReceiveOnImpact(self,HitResult)

    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))


    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_FireStandGreenProj5_2 - No valid FoundTargets found")
            return
        end

        --local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))


        --- 造成一次导弹命中伤害
        if UE.IsValid(Monster) then
            local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill5_1",self:GetOwner())

            UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)

            UGCPersistEffectSystem.AddBuffByClass(Monster, BurningBuffClass)
            --UGCPersistEffectSystem.AddBuffByClass(Monster, BurningBuffClass)
        end

        local controller = self:GetInstigatorController()
        local owner = self:GetOwner()
        local damage = self.FinallyDamage
        -- 每秒后对怪物造成伤害
        local DamageTimer = Timer.InsertTimer(1.0, function()
            if UE.IsValid(Monster) then
                UGCGameSystem.ApplyDamage(Monster, damage, controller, owner, nil)
            end
        end, true)

        --- 5秒后移除定时器
        Timer.InsertTimer(5.5, function()
            if DamageTimer ~= nil then
                Timer.RemoveTimer(DamageTimer)
                DamageTimer = nil
            end
        end, false)

        --- 每秒后对怪物造成50点伤害
        -- self.DamageTimer = Timer.InsertTimer(1.0, function()
        --     if UE.IsValid(Monster) then
        --         UGCGameSystem.ApplyDamage(Monster, 50, self:GetInstigatorController(), self:GetOwner(), nil)
        --         UGCLog.Log("[maoyu]:TuYang_FireRateGreenProj_2_2:ApplyDamage")
        --     end
        -- end, true)
        -- --- 3秒后移除定时器
        -- Timer.InsertTimer(3.0, function()
        --     if self.DamageTimer ~= nil then
        --         Timer.RemoveTimer(self.DamageTimer)
        --         self.DamageTimer = nil
        --     end
        -- end, false)
    end
end


--[[
function TuYang_FireStandGreenProj5_2:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_FireStandGreenProj5_2.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_FireStandGreenProj5_2:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_FireStandGreenProj5_2.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_FireStandGreenProj5_2:TickMovementPath(DeltaTime)
    TuYang_FireStandGreenProj5_2.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_FireStandGreenProj5_2