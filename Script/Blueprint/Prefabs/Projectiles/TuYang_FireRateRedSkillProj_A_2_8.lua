---@class TuYang_FireRateRedSkillProj_A_2_8_C:UniversalProjectileBase
---@field P_Volcano_Fly UParticleSystemComponent
---@field P_smoke_vehicle_Water_01 UParticleSystemComponent
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_FireRateRedSkillProj_A_2_8 = {}

--[[
function TuYang_FireRateRedSkillProj_A_2_8:ReceiveLaunchBullet()
    TuYang_FireRateRedSkillProj_A_2_8.SuperClass.ReceiveLaunchBullet(self)
end
--]]


function TuYang_FireRateRedSkillProj_A_2_8:ReceiveOnImpact(HitResult)
    TuYang_FireRateRedSkillProj_A_2_8.SuperClass.ReceiveOnImpact(self,HitResult)
    UGCLog.Log("[maoyu]:TuYang_FireRateRedSkillProj_A_2_8:ReceiveOnImpact")

    local BlockingVolumeClass = UE.LoadClass('/Script/Engine.BlockingVolume')

    -- 新增 BlockingVolume 检测
    if HitResult.Actor:IsValid() and UE.IsA(HitResult.Actor:Get() , BlockingVolumeClass) then
        self:OnProjectileDestroyed()
        return
    end

    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_FireRateRedSkillProj_A_2_8: - No valid FoundTargets found")
            return
        end

        local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))

        local controller = self:GetInstigatorController()
        local owner = self:GetOwner()
        local finallyDamage = UGCGameSystem.GameState:CalculateSkillDamage("Skill2_8",owner)

        --- 先造成一次命中伤害
        if UE.IsValid(Monster) then
            
            UGCGameSystem.ApplyDamage(Monster, finallyDamage, controller, owner, nil)

        end

        local burningDamage = finallyDamage * 0.1
        --- 再施加燃烧
        if UE.IsValid(Monster) then
            UGCPersistEffectSystem.AddBuffByClass(Monster, BurningBuffClass)
            -- 每秒对怪物造成点燃伤害
            self.BurrningBuffTimer = Timer.InsertTimer(1.0, function()
                if UE.IsValid(Monster) then
                    UGCGameSystem.ApplyDamage(Monster, burningDamage, controller, owner, nil)
                end
            end, true ,"BurrningBuffTimer", 0)  -- 添加计时器名称参数

            -- 5秒后移除定时器
            Timer.InsertTimer(5.0, function()
                if self.BurrningBuffTimer ~= nil then
                    Timer.RemoveTimer(self.BurrningBuffTimer)
                    self.BurrningBuffTimer = nil
                end
            end, false)
        end

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
function TuYang_FireRateRedSkillProj_A_2_8:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_FireRateRedSkillProj_A_2_8.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_FireRateRedSkillProj_A_2_8:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_FireRateRedSkillProj_A_2_8.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_FireRateRedSkillProj_A_2_8:TickMovementPath(DeltaTime)
    TuYang_FireRateRedSkillProj_A_2_8.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_FireRateRedSkillProj_A_2_8