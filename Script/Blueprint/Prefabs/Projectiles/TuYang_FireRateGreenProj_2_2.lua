---@class TuYang_FireRateGreenProj_2_2_C:UniversalProjectileBase
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
--Edit Below--
local TuYang_FireRateGreenProj_2_2 = {}


function TuYang_FireRateGreenProj_2_2:ReceiveBeginPlay()
    TuYang_FireRateGreenProj_2_2.SuperClass.ReceiveBeginPlay(self)
    --UGCLog.Log("[maoyu]:TuYang_FireRateGreenProj_2_2:ReceiveBeginPlay" ,self)
end

function TuYang_FireRateGreenProj_2_2:ReceiveLaunchBullet()
    TuYang_FireRateGreenProj_2_2.SuperClass.ReceiveLaunchBullet(self)

    -- 
    --self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill2_2",self:GetOwner())
    --GCLog.Log("[maoyu]:TuYang_FireRateGreenProj_2_2:ReceiveLaunchBullet",self.FinallyDamage)
end


-- 在击中位置造成爆炸伤害
function TuYang_FireRateGreenProj_2_2:ReceiveOnImpact(HitResult)

    local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))

    local IgnoredActorList = UGCGameSystem.GetAllPlayerPawn()

    local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill2_2",self:GetOwner())
    UGCGameSystem.ApplyRadialDamage(finallyDamage, finallyDamage,HitResult.Location,300,300,0,EDamageType.UGCCustomDamageType + 1,IgnoredActorList, self:GetOwner(), self:GetInstigatorController(), ECollisionChannel.ECC_Visibility,0)
    --UGCPersistEffectSystem.AddBuffByClass(Monster, BurningBuffClass)   

    TuYang_FireRateGreenProj_2_2.SuperClass.ReceiveOnImpact(self,HitResult)
end

--使用ExplosionDamageValueWrapper.Value作为伤害时无法过滤玩家，且会对玩家造成震屏效果，目前没办法解决。在ReceivePlayExplosionEffectToAllTarget对需要造成效果的目标进行处理
function TuYang_FireRateGreenProj_2_2:ReceivePlayExplosionEffectToAllTarget(FoundTargets)

    if not FoundTargets or #FoundTargets == 0 then
        UGCLog.Log("[maoyu]:TuYang_FireRateGreenProj_2_2:ReceivePlayExplosionEffectToAllTarget - No valid FoundTargets found")
        return
    end

    local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill2_2",self:GetOwner())
    UGCLog.Log("[maoyu]:TuYang_FireRateGreenProj_2_2:ReceivePlayExplosionEffectToAllTarget - finallyDamage:", finallyDamage)


    -- 处理单个目标的逻辑
    local function HandleMonster(Monster)
        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_IceRateBlueProj_2_1:HandleMonster - Invalid Monster")
            return
        end

        local BurningBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_Burning.TuYang_Burning_C'))

        -- 统一应用伤害和buff
        UGCGameSystem.ApplyDamage(Monster, finallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
        UGCPersistEffectSystem.AddBuffByClass(Monster, BurningBuffClass)

        -- 创建新计时器
        self.BurrningBuffTimer = Timer.InsertTimer(1.0, function()
            if UE.IsValid(Monster) then
                UGCGameSystem.ApplyDamage(Monster, finallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
            end
        end, true)  -- 添加计时器名称参数

        -- 5秒后移除定时器
        Timer.InsertTimer(5.5, function()
            if self.BurrningBuffTimer ~= nil then
                Timer.RemoveTimer(self.BurrningBuffTimer)
                self.BurrningBuffTimer = nil
            end
        end, false)
    end

    -- 遍历所有目标并处理
    for _, Target in ipairs(FoundTargets) do
        if UE.IsValid(Target.Actor:Get()) then
            local Monster = Target.Actor:Get()
            local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
            if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then
                HandleMonster(Monster)
            end
        end
    end


    TuYang_FireRateGreenProj_2_2.SuperClass.ReceivePlayExplosionEffectToAllTarget(self,FoundTargets)
end

--[[
function TuYang_FireRateGreenProj_2_2:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_FireRateGreenProj_2_2.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_FireRateGreenProj_2_2:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_FireRateGreenProj_2_2.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_FireRateGreenProj_2_2:TickMovementPath(DeltaTime)
    TuYang_FireRateGreenProj_2_2.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_FireRateGreenProj_2_2