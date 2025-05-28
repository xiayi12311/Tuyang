---@class TuYang_IceRateBlueProj_2_1_C:UniversalProjectileBase
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_IceRateBlueProj_2_1 = {}


function TuYang_IceRateBlueProj_2_1:ReceiveLaunchBullet()
    TuYang_IceRateBlueProj_2_1.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill2_1",self:GetOwner())
end


--[[
function TuYang_IceRateBlueProj_2_1:ReceiveOnImpact(HitResult)
    TuYang_IceRateBlueProj_2_1.SuperClass.ReceiveOnImpact(self,HitResult)
end
--]]

--[[
function TuYang_IceRateBlueProj_2_1:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_IceRateBlueProj_2_1.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_IceRateBlueProj_2_1:TickMovementPath(DeltaTime)
    TuYang_IceRateBlueProj_2_1.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

-- function TuYang_IceRateBlueProj_2_1:ReceivePlayExplosionEffect(TargetHitResult)
    
-- end

--使用ExplosionDamageValueWrapper.Value作为伤害时无法过滤玩家，且会对玩家造成震屏效果，目前没办法解决。在ReceivePlayExplosionEffectToAllTarget对需要造成效果的目标进行处理
function TuYang_IceRateBlueProj_2_1:ReceivePlayExplosionEffectToAllTarget(FoundTargets)

    if not FoundTargets or #FoundTargets == 0 then
        UGCLog.Log("[maoyu]:TuYang_IceRateBlueProj_2_1:ReceivePlayExplosionEffectToAllTarget - No valid FoundTargets found")
        return
    end

    -- 处理单个目标的逻辑
    local function HandleMonster(Monster)
        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_IceRateBlueProj_2_1:HandleMonster - Invalid Monster")
            return
        end

        -- 初始化怪物计时器存储（弱引用表）
        if not UGCGameSystem.GameState.SlowMonsterTimers then
            UGCGameSystem.GameState.SlowMonsterTimers = setmetatable({}, { __mode = "k" })
        end

        local PreviewSpeedScale = 0.4
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

        -- 统一应用伤害和buff
        UGCGameSystem.ApplyDamage(Monster, self.FinallyDamage, self:GetInstigatorController(), self:GetOwner(), nil)
        UGCPersistEffectSystem.AddBuffByClass(Monster, SlowBuffClass)

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

    TuYang_IceRateBlueProj_2_1.SuperClass.ReceivePlayExplosionEffectToAllTarget(self,FoundTargets)
end

return TuYang_IceRateBlueProj_2_1