---@class TuYang_IceCDPurpleSkillProj_A_3_1_C:UniversalProjectileBase
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field StaticMesh UStaticMeshComponent
--Edit Below--
local TuYang_IceCDPurpleSkillProj_A_3_1 = {}


function TuYang_IceCDPurpleSkillProj_A_3_1:ReceiveLaunchBullet()
    TuYang_IceCDPurpleSkillProj_A_3_1.SuperClass.ReceiveLaunchBullet(self)

    self.FinallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill3_1",self:GetOwner())
end


-- 对穿透的怪物造成伤害
function TuYang_IceCDPurpleSkillProj_A_3_1:ReceiveOnImpact(HitResult)

    UGCLog.Log("[maoyu]:TuYang_IceCDPurpleSkillProj_A_3_1:ReceiveOnImpact")
    local Monster = nil
    if UE.IsValid(HitResult.Actor:Get()) then
        Monster = HitResult.Actor:Get()
    end

    local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

    if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(Monster), BaseClass) then

        if not UE.IsValid(Monster) then
            UGCLog.Log("[maoyu]:TuYang_IceCDPurpleSkillProj_A_3_1: - No valid FoundTargets found")
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

        --- 每秒后对怪物造成50点伤害
        -- self.DamageTimer = Timer.InsertTimer(1.0, function()
        --     if UE.IsValid(Monster) then
        --         UGCGameSystem.ApplyDamage(Monster, 50, self:GetInstigatorController(), self:GetOwner(), nil)
        --         UGCLog.Log("[maoyu]:TuYang_FireCountPurpleProj_1_2:ApplyDamage")
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

    TuYang_IceCDPurpleSkillProj_A_3_1.SuperClass.ReceiveOnImpact(self,HitResult)
end

--[[
function TuYang_IceCDPurpleSkillProj_A_3_1:ReceiveOnBounce(HitResult, ImpactVelocity)
    TuYang_IceCDPurpleSkillProj_A_3_1.SuperClass.ReceiveOnBounce(self,HitResult, ImpactVelocity)
end
--]]

--[[
function TuYang_IceCDPurpleSkillProj_A_3_1:ReceivePlayExplosionEffect(ExplosionTarget)
    TuYang_IceCDPurpleSkillProj_A_3_1.SuperClass.ReceivePlayExplosionEffect(self,ExplosionTarget)
end
--]]

--[[
function TuYang_IceCDPurpleSkillProj_A_3_1:TickMovementPath(DeltaTime)
    TuYang_IceCDPurpleSkillProj_A_3_1.SuperClass.TickMovementPath(self,DeltaTime)
end
--]]

return TuYang_IceCDPurpleSkillProj_A_3_1