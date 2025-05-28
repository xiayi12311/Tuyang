---@class TuYang_LightStandPurpleSkillActor_5_3_C:AActor
---@field Goldbrust UParticleSystemComponent
---@field ActorSequence UActorSequenceComponent
---@field SK_UGC_SDT_A USkeletalMeshComponent
---@field Scene USceneComponent
---@field ParticleSystem UParticleSystemComponent
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_LightStandPurpleSkillActor_5_3 = {}
 
TuYang_LightStandPurpleSkillActor_5_3.OverlappingMonsters = {}


function TuYang_LightStandPurpleSkillActor_5_3:ReceiveBeginPlay()
    TuYang_LightStandPurpleSkillActor_5_3.SuperClass.ReceiveBeginPlay(self)

    
    if self:HasAuthority() then

        self.Sphere.OnComponentBeginOverlap:Add(self.OnBeginOverlap, self)
        self.Sphere.OnComponentEndOverlap:Add(self.OnEndOverlap, self)



        local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill5_3",self:GetInstigator())

        local StunBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_StunBuff.TuYang_StunBuff_C'))

        self.LightStandPurpleSkillActorTimer = Timer.InsertTimer(1, function()

            if not UE.IsValid(self) then
                UGCLog.Log("[maoyu] SkillActor已被销毁")
                return
            end

            if #totable(self.OverlappingMonsters) > 0 then
                local bOnlyOneMonster = true
                for k, OverlappingMonster in pairs(self.OverlappingMonsters) do
                    --UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Actor:Character:", self:GetInstigator(),"OverlappingActor",OverlappingMonster)
    
                    if UE.IsValid(OverlappingMonster) then
                        --UGCLog.Log("[maoyu]TuYang_WindCountRedSkill_A_1_4_Actor:OverlappingActor:",OverlappingMonster)
                        if bOnlyOneMonster then
                            -- 添加眩晕buff
                            UGCPersistEffectSystem.AddBuffByClass(OverlappingMonster, StunBuffClass)
                            -- 眩晕逻辑，停止/重启BehaviorTree
                            local Controlle = OverlappingMonster:GetControllerSafety()
                            local BrainComp = nil
                            if Controlle then
                                BrainComp = Controlle.BrainComponent
                            end
                            if BrainComp then
                                BrainComp:StopLogic("Stop")
                                Timer.InsertTimer(2, function()
                                    -- 双重有效性验证
                                    if UE.IsValid(OverlappingMonster) and UE.IsValid(Controlle) and Controlle.BrainComponent then
                                        Controlle.BrainComponent:RestartLogic()
                                    end
                                end,false)
                            end
                            bOnlyOneMonster = false
                        end
                        
                        UGCGameSystem.ApplyDamage(OverlappingMonster, finallyDamage, self:GetInstigatorController(), self:GetInstigator(),EDamageType.STPointDamage)
                    end
                    --if OverlappingActor ~= self:GetInstigator() then
                end
            end
        end,true)

        Timer.InsertTimer(3.5, function()
            self:DestroyActor()
        end,false)
    end
end


function TuYang_LightStandPurpleSkillActor_5_3:OnBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if self:HasAuthority() then
        local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
        local PlayerClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
        if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(OtherActor), BaseClass) then
            table.insert(self.OverlappingMonsters,OtherActor)
        end
    end
end

function TuYang_LightStandPurpleSkillActor_5_3:OnEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    if self:HasAuthority() then
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
function TuYang_LightStandPurpleSkillActor_5_3:DestroyActor()
    if UE.IsValid(self) then
        --self.OwnerPlayer:OnSkillActorDestroyed("Skill5_3")
        Timer.RemoveTimer(self.LightStandPurpleSkillActorTimer)
        --Timer.RemoveTimer(self.AliveCheckTimer)
        self.OverlappingMonsters = nil
        self:K2_DestroyActor()
    end
end


--[[
function TuYang_LightStandPurpleSkillActor_5_3:ReceiveTick(DeltaTime)
    TuYang_LightStandPurpleSkillActor_5_3.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function TuYang_LightStandPurpleSkillActor_5_3:ReceiveEndPlay()

    if self:HasAuthority() then

        Timer.RemoveTimer(self.LightStandPurpleSkillActorTimer)
        --Timer.RemoveTimer(self.AliveCheckTimer)
        self.OverlappingMonsters = nil
    end
    TuYang_LightStandPurpleSkillActor_5_3.SuperClass.ReceiveEndPlay(self) 
end

--[[
function TuYang_LightStandPurpleSkillActor_5_3:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_LightStandPurpleSkillActor_5_3:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_LightStandPurpleSkillActor_5_3