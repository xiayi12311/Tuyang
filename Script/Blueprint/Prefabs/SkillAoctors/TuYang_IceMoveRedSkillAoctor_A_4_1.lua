---@class TuYang_IceMoveRedSkillAoctor_A_4_1_C:AActor
---@field Sphere USphereComponent
---@field Scene USceneComponent
---@field ActorSequence UActorSequenceComponent
---@field P_Implosive UParticleSystemComponent
---@field Scene1 USceneComponent
---@field P_PveSlowGrenade UParticleSystemComponent
---@field CG013_bingdiao UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_IceMoveRedSkillAoctor_A_4_1 = {}

local IgnoredActorList = {}

function TuYang_IceMoveRedSkillAoctor_A_4_1:ReceiveBeginPlay()
    TuYang_IceMoveRedSkillAoctor_A_4_1.SuperClass.ReceiveBeginPlay(self)

    local SlowBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_FreezeBuff.TuYang_FreezeBuff_C'))


    self.IgnoredActorList = UGCGameSystem.GetAllPlayerPawn()

    local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill4_1",self:GetInstigator())

    if self:HasAuthority() then

        Timer.InsertTimer(1.0,function ()
            -- UGCLog.Log("[maoyu]IceMoveRedSkillAoctor:",self:GetOwner(),self:GetInstigatorController())




            --UGCLog.Log("[maoyu]TuYang_IceMoveRedSkillAoctor_A_4_1:finallyDamage = ,SpeedValue =  " ,finallyDamage  ,self:GetInstigator().ActualSpeedValue)

            local Damage = finallyDamage + self:GetInstigator().ActualSpeedValue  * 0.01
            


            local overlappingActors = {}
            self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraSimpleCharacter')

        
            -- 遍历怪物列表
            if overlappingActors and #overlappingActors > 0 then
                for k, monster in pairs(overlappingActors) do
                    if UE.IsValid(monster) then
                    -- 初始化怪物计时器存储（弱引用表）
                    if not UGCGameSystem.GameState.SlowMonsterTimers then
                        UGCGameSystem.GameState.SlowMonsterTimers = setmetatable({}, { __mode = "k" })
                    end

                    local PreviewSpeedScale = 0.4
                    local MonsterSpeedScale = UGCSimpleCharacterSystem.GetSpeedScale(monster)


                    -- 生成唯一计时器名称
                    local timerName = "IceSkillSlowMonster_"..tostring(monster)
                    
                    -- 仅首次应用减速
                    if not UGCGameSystem.GameState.SlowMonsterTimers[monster] then
                        UGCSimpleCharacterSystem.SetSpeedScale(monster, MonsterSpeedScale * PreviewSpeedScale)
                        UGCGameSystem.GameState.SlowMonsterTimers[monster] = {
                            OriginalSpeed = MonsterSpeedScale,
                            TimerName = timerName  -- 存储计时器名称而非句柄
                        }
                        --UGCLog.Log("[maoyu]:初始减速 怪物:" ,tostring(Monster))
                    end

                    -- 应用buff
                    UGCPersistEffectSystem.AddBuffByClass(monster, SlowBuffClass)

                    -- 移除旧计时器（通过名称）
                    if timerName and Timer.IsTimerExistByName(timerName) then
                        Timer.RemoveTimerByName(timerName)
                    end

                    -- 创建新计时器
                    Timer.InsertTimer(2.0, function()
                        if UE.IsValid(monster) then
                            local data = UGCGameSystem.GameState.SlowMonsterTimers[monster]
                            if data then
                                UGCSimpleCharacterSystem.SetSpeedScale(monster, data.OriginalSpeed)
                                -- UGCLog.Log("[maoyu]:恢复速度 怪物:",tostring(Monster))
                                UGCGameSystem.GameState.SlowMonsterTimers[monster] = nil
                            end
                        end
                    end, false, timerName)  -- 添加计时器名称参数

                    -- 更新存储的计时器名称
                    UGCGameSystem.GameState.SlowMonsterTimers[monster].TimerName = timerName
                end
            end

            UGCGameSystem.ApplyRadialDamage(Damage,Damage,self:K2_GetActorLocation(),400,400,0,EDamageType.UGCCustomDamageType + 1,self.IgnoredActorList,self:GetInstigator(),self:GetInstigatorController(),ECollisionChannel.ECC_Visibility, 0)
        end
        end,false)
    end
end


--[[
function TuYang_IceMoveRedSkillAoctor_A_4_1:ReceiveTick(DeltaTime)
    TuYang_IceMoveRedSkillAoctor_A_4_1.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_IceMoveRedSkillAoctor_A_4_1:ReceiveEndPlay()
    TuYang_IceMoveRedSkillAoctor_A_4_1.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_IceMoveRedSkillAoctor_A_4_1:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_IceMoveRedSkillAoctor_A_4_1:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_IceMoveRedSkillAoctor_A_4_1