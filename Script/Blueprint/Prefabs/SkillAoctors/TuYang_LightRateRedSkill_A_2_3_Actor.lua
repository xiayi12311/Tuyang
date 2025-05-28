---@class TuYang_LightRateRedSkill_A_2_3_Actor_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field Particle1 UParticleSystemComponent
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_LightRateRedSkill_A_2_3_Actor = {}
 
TuYang_LightRateRedSkill_A_2_3_Actor.OverlappingMonsters = {}


function TuYang_LightRateRedSkill_A_2_3_Actor:ReceiveBeginPlay()
    TuYang_LightRateRedSkill_A_2_3_Actor.SuperClass.ReceiveBeginPlay(self)

    --UGCLog.Log("[maoyu]TuYang_LightRateRedSkill_A_2_3_Actor:ReceiveBeginPlay",self.Sphere)
    

    if self:HasAuthority() then

        self.Sphere.OnComponentBeginOverlap:Add(self.OnBeginOverlap, self)
        self.Sphere.OnComponentEndOverlap:Add(self.OnEndOverlap, self)

        local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill2_3",self:GetInstigator())

        local controller = self:GetInstigatorController()
        local owner = self:GetInstigator()
        local StunBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_StunBuff.TuYang_StunBuff_C'))

        local overlappingActors = {}
            self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass'/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
            -- 遍历怪物列表
            if overlappingActors and #overlappingActors > 0 then
                for k, monster in pairs(overlappingActors) do
                    -- 检查是随机选择的怪物是否存活并在怪物位置造成范围伤害
                    if monster then

                        -- 添加眩晕buff
                        UGCPersistEffectSystem.AddBuffByClass(monster, StunBuffClass)
                        -- 眩晕逻辑，停止/重启BehaviorTree
                        local Controlle = monster:GetControllerSafety()
                        local BrainComp = nil
                        if Controlle then
                            BrainComp = Controlle.BrainComponent
                        end
                        if BrainComp then
                            BrainComp:StopLogic("Stop")
                            Timer.InsertTimer(2, function()
                                -- 双重有效性验证
                                if UE.IsValid(monster) and UE.IsValid(Controlle) and Controlle.BrainComponent then
                                    Controlle.BrainComponent:RestartLogic()
                                end
                            end,false)
                        end

                        UGCGameSystem.ApplyDamage(monster, finallyDamage, controller, owner , EDamageType.STPointDamage)
                    end
                end
            end

        Timer.InsertTimer(1.0, function()
            if not UE.IsValid(self) then
                UGCLog.Log("[maoyu] SkillActor已被销毁")
                return
            end

            if self.OverlappingMonsters and #self.OverlappingMonsters > 0 then
                for k, OverlappingMonster in pairs(self.OverlappingMonsters) do
                    if UE.IsValid(OverlappingMonster) then
                        UGCGameSystem.ApplyDamage(OverlappingMonster, finallyDamage, controller, owner , EDamageType.STPointDamage)
                        -- 添加眩晕buff
                        UGCPersistEffectSystem.AddBuffByClass(OverlappingMonster, StunBuffClass)
                        -- 眩晕逻辑，停止/重启BehaviorTree
                        local Controlle = OverlappingMonster:GetControllerSafety()
                        local BrainComp = Controlle.BrainComponent
                        BrainComp:StopLogic("Stop")
                        Timer.InsertTimer(2, function()BrainComp:RestartLogic()
                        end,false)
                    end
                end
            end
        end,false)
    end
end

function TuYang_LightRateRedSkill_A_2_3_Actor:OnBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if self:HasAuthority() then
        local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
        local PlayerClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
        if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(OtherActor), BaseClass) then
            if self.OverlappingMonsters ~= nil then
                --UGCLog.Log("[maoyu] OnBeginOverlap.OtherActor=",OtherActor)

                table.insert(self.OverlappingMonsters,OtherActor)
            end
            --UGCLog.Log("[maoyu]:1_4:OnBeginOverlap:",OtherActor)
            --UGCLog.Log("[maoyu]:1_4:OnBeginOverlap:",self.OverlappingMonsters)
        end
    end
end

function TuYang_LightRateRedSkill_A_2_3_Actor:OnEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    if self:HasAuthority() then
        if self.OverlappingMonsters ~= nil and #self.OverlappingMonsters > 0 then
            for k, v in pairs(self.OverlappingMonsters) do
                if(OtherActor == v) then
                    table.remove(self.OverlappingMonsters,k)
                    --UGCLog.Log("[maoyu]:1_4:OnEndOverlap:",OtherActor)
                    --UGCLog.Log("[maoyu]:1_4:OnEndOverlap:",self.OverlappingMonsters)
                    return
                end
            end
        end
    end
end


--[[
function TuYang_LightRateRedSkill_A_2_3_Actor:ReceiveTick(DeltaTime)
    TuYang_LightRateRedSkill_A_2_3_Actor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function TuYang_LightRateRedSkill_A_2_3_Actor:ReceiveEndPlay()
    TuYang_LightRateRedSkill_A_2_3_Actor.SuperClass.ReceiveEndPlay(self) 
    self.OverlappingMonsters = nil
end


--[[
function TuYang_LightRateRedSkill_A_2_3_Actor:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_LightRateRedSkill_A_2_3_Actor:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_LightRateRedSkill_A_2_3_Actor