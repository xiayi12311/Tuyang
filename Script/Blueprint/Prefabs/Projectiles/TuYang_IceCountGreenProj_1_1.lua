---@class TuYang_IceCountGreenProj_1_1_C:UniversalProjectileBase
---@field StaticMesh1 UStaticMeshComponent
---@field ParticleSystem1 UParticleSystemComponent
---@field Sphere1 USphereComponent
--Edit Below--
local TuYang_IceCountGreenProj_1_1 = {}


function TuYang_IceCountGreenProj_1_1:ReceiveLaunchBullet()
    TuYang_IceCountGreenProj_1_1.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_1",self:GetOwner())
    UGCLog.Log("[maoyu]:TuYang_IceCountGreenProj_1_1:ReceiveLaunchBullet  最终伤害：",self.FinallyDamage)
end



function TuYang_IceCountGreenProj_1_1:ReceiveOnImpact(HitResult)
    UGCLog.Log("[maoyu]:TuYang_IceCountGreenProj_1_1:ReceiveOnImpact")
    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_IceCountGreenProj_1_1: - No valid FoundTargets found")
            return
        end

        -- 初始化怪物计时器存储（弱引用表）
        if not UGCGameSystem.GameState.SlowMonsterTimers then
            UGCGameSystem.GameState.SlowMonsterTimers = setmetatable({}, { __mode = "k" })
        end

        -- 预设速度缩放值
        local PreviewSpeedScale = 0.4
        -- 获取当前速度缩放值
        local MonsterSpeedScale = UGCSimpleCharacterSystem.GetSpeedScale(Monster)

        local SlowBuffClass = UGCObjectUtility.LoadClass(
        UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_FreezeBuff.TuYang_FreezeBuff_C'))


         -- 生成唯一计时器名称
        local timerName = "IceSkillSlowMonster_"..tostring(Monster)

        -- 仅首次应用减速
        if not UGCGameSystem.GameState.SlowMonsterTimers[Monster] then
            UGCSimpleCharacterSystem.SetSpeedScale(Monster, MonsterSpeedScale * PreviewSpeedScale)
            UGCGameSystem.GameState.SlowMonsterTimers[Monster] = {
                OriginalSpeed = MonsterSpeedScale,
                TimerName = timerName  -- 存储计时器名称而非句柄
            }
            --UGCLog.Log("[maoyu]:初始减速 怪物:" ,tostring(Monster))
        end

        
        --造成伤害
        --local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill1_1",self:GetOwner())

        UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
        -- 设置新的速度缩放值
        --UGCSimpleCharacterSystem.SetSpeedScale(Monster, MonsterSpeedScale * PreviewSpeedScale)
        UGCPersistEffectSystem.AddBuffByClass(Monster, SlowBuffClass)
        --UGCLog.Log("[maoyu]:TuYang_IceCountGreenProj_1_1: SetSpeedScale =  ", PreviewSpeedScale)

        -- 移除旧计时器（通过名称）
        if Timer.IsTimerExistByName(timerName) then
            Timer.RemoveTimerByName(timerName)
        end

        -- 创建新计时器
        Timer.InsertTimer(2.0, function()
            if UE.IsValid(Monster) then
                local data = UGCGameSystem.GameState.SlowMonsterTimers[Monster]
                if data then
                    UGCSimpleCharacterSystem.SetSpeedScale(Monster, data.OriginalSpeed)
                    -- UGCLog.Log("[maoyu]:恢复速度 怪物:",tostring(Monster))
                    UGCGameSystem.GameState.SlowMonsterTimers[Monster] = nil
                end
            end
        end, false, timerName)  -- 添加计时器名称参数

        -- 更新存储的计时器名称
        UGCGameSystem.GameState.SlowMonsterTimers[Monster].TimerName = timerName
    end

    TuYang_IceCountGreenProj_1_1.SuperClass.ReceiveOnImpact(self,HitResult)
end


--[[
function TuYang_IceCountGreenProj_1_1:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_IceCountGreenProj_1_1.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_IceCountGreenProj_1_1:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_IceCountGreenProj_1_1.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_IceCountGreenProj_1_1:TickMovementPath(DeltaTime)
    TuYang_IceCountGreenProj_1_1.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_IceCountGreenProj_1_1