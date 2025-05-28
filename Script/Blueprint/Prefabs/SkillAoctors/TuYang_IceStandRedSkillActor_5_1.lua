---@class TuYang_IceStandRedSkillActor_5_1_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_IceStandRedSkillActor_5_1 = {}
 

TuYang_IceStandRedSkillActor_5_1.OverlappingMonsters = {}


function TuYang_IceStandRedSkillActor_5_1:ReceiveBeginPlay()
    TuYang_IceStandRedSkillActor_5_1.SuperClass.ReceiveBeginPlay(self)
    
    -- 新增创建者记录
    self.OwnerPlayer = self:GetInstigator()

    if self:HasAuthority() then

        self.Sphere.OnComponentBeginOverlap:Add(self.OnBeginOverlap, self)
        self.Sphere.OnComponentEndOverlap:Add(self.OnEndOverlap, self)

        local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill5_1",self:GetInstigator())

        local SlowBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_FreezeBuff.TuYang_FreezeBuff_C'))


        self.IceStandRedSkillActorTimer = Timer.InsertTimer(0.5, function()

            -- 新增拥有者存活检测
            if self.OwnerPlayer.Health <= 0 then
                self:DestroyActor()
                UGCLog.Log("[maoyu] OwnerPlayer死亡")
                return
            end

            if not UE.IsValid(self) then
                UGCLog.Log("[maoyu] SkillActor已被销毁")
                return
            end

            if #totable(self.OverlappingMonsters) > 0 then
                for k, OverlappingMonster in pairs(self.OverlappingMonsters) do
                    --UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Actor:Character:", self:GetInstigator(),"OverlappingActor",OverlappingMonster)
    
                    if UE.IsValid(OverlappingMonster) then
                        --UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Actor:OverlappingActor:",OverlappingMonster)
                        --ugcprint("[maoyu]:TuYang_IceStandRedSkillActor_5_1,finallyDamage= " ..finallyDamage)
                        UGCGameSystem.ApplyDamage(OverlappingMonster, finallyDamage, self:GetInstigatorController(), self:GetInstigator(),EDamageType.STPointDamage)

                        -- 初始化怪物计时器存储（弱引用表）
                        if not UGCGameSystem.GameState.SlowMonsterTimers then
                            UGCGameSystem.GameState.SlowMonsterTimers = setmetatable({}, { __mode = "k" })
                        end

                        local PreviewSpeedScale = 0.4
                        local MonsterSpeedScale = UGCSimpleCharacterSystem.GetSpeedScale(OverlappingMonster)


                        -- 生成唯一计时器名称
                        local timerName = "IceSkillSlowMonster_"..tostring(OverlappingMonster)
                        
                        -- 仅首次应用减速
                        if not UGCGameSystem.GameState.SlowMonsterTimers[OverlappingMonster] then
                            UGCSimpleCharacterSystem.SetSpeedScale(OverlappingMonster, MonsterSpeedScale * PreviewSpeedScale)
                            UGCGameSystem.GameState.SlowMonsterTimers[OverlappingMonster] = {
                                OriginalSpeed = MonsterSpeedScale,
                                TimerName = timerName  -- 存储计时器名称而非句柄
                            }
                            --UGCLog.Log("[maoyu]:初始减速 怪物:" ,tostring(Monster))
                        end

                        -- 应用buff
                        UGCPersistEffectSystem.AddBuffByClass(OverlappingMonster, SlowBuffClass,nil,1.0,1)

                        -- 移除旧计时器（通过名称）
                        if Timer.IsTimerExistByName(timerName) then
                            Timer.RemoveTimerByName(timerName)
                        end

                        -- 创建新计时器
                        Timer.InsertTimer(1.0, function()
                            if UE.IsValid(OverlappingMonster) then
                                local data = UGCGameSystem.GameState.SlowMonsterTimers[OverlappingMonster]
                                if data then
                                    UGCSimpleCharacterSystem.SetSpeedScale(OverlappingMonster, data.OriginalSpeed)
                                    -- UGCLog.Log("[maoyu]:恢复速度 怪物:",tostring(Monster))
                                    UGCGameSystem.GameState.SlowMonsterTimers[OverlappingMonster] = nil
                                end
                            end
                        end, false, timerName)  -- 添加计时器名称参数

                        -- 更新存储的计时器名称
                        UGCGameSystem.GameState.SlowMonsterTimers[OverlappingMonster].TimerName = timerName
                    end
                end
                --if OverlappingActor ~= self:GetInstigator() then
            end
        end,true)
        ugcprint("TuYang_IceStandRedSkillActor_5_1:ReceiveBeginPlay")
    end
end


function TuYang_IceStandRedSkillActor_5_1:OnBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if self:HasAuthority() then
        local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
        local PlayerClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
        if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(OtherActor), BaseClass) then
            table.insert(self.OverlappingMonsters,OtherActor)
        end
    end
end

function TuYang_IceStandRedSkillActor_5_1:OnEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    if self:HasAuthority() then

        -- 创建者离开时立即销毁
        if OtherActor == self.OwnerPlayer then
            UGCLog.Log("TuYang_IceStandRedSkillActor_5_1:DestroyActor")
            self:DestroyActor()
            return
        end

        if #totable(self.OverlappingMonsters) > 0 then
            for k, v in pairs(self.OverlappingMonsters) do
                if(OtherActor == v) then
                    table.remove(self.OverlappingMonsters,k)
                    return
                end
            end
        end
    end
end

-- 新增统一销毁方法
function TuYang_IceStandRedSkillActor_5_1:DestroyActor()
    if UE.IsValid(self) then
        self.OwnerPlayer:OnSkillActorDestroyed("Skill5_1")
        Timer.RemoveTimer(self.IceStandRedSkillActorTimer)
        --Timer.RemoveTimer(self.AliveCheckTimer)
        self.OverlappingMonsters = nil
        self:K2_DestroyActor()
    end
end


--[[
function TuYang_IceStandRedSkillActor_5_1:ReceiveTick(DeltaTime)
    TuYang_IceStandRedSkillActor_5_1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function TuYang_IceStandRedSkillActor_5_1:ReceiveEndPlay()

    if self:HasAuthority() then

        Timer.RemoveTimer(self.IceStandRedSkillActorTimer)
        --Timer.RemoveTimer(self.AliveCheckTimer)
        self.OverlappingMonsters = nil
    end
    TuYang_IceStandRedSkillActor_5_1.SuperClass.ReceiveEndPlay(self) 
end


--[[
function TuYang_IceStandRedSkillActor_5_1:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_IceStandRedSkillActor_5_1:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_IceStandRedSkillActor_5_1