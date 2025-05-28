---@class TuYang_LightMovePurpleSkillActor_4_3_C:AActor
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_LightMovePurpleSkillActor_4_3 = TuYang_LightMovePurpleSkillActor_4_3 or {}
 
TuYang_LightMovePurpleSkillActor_4_3.OverlappingMonsters = {}
-- TuYang_LightMovePurpleSkillActor_4_3.OverlappingPlayers = {}

function TuYang_LightMovePurpleSkillActor_4_3:ReceiveBeginPlay()
    TuYang_LightMovePurpleSkillActor_4_3.SuperClass.ReceiveBeginPlay(self)
    --ugcprint("[maoyu]:TuYang_LightMovePurpleSkillActor_4_3:ReceiveBeginPlay")
    if self:HasAuthority() then

        self.Sphere.OnComponentBeginOverlap:Add(self.OnBeginOverlap, self)
        self.Sphere.OnComponentEndOverlap:Add(self.OnEndOverlap, self)

        local finallyDamage = GameplayStatics.GetGameState(self):CalculateSkillDamage("Skill4_3",self:GetInstigator())

        local StunBuffClass = UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/Buffs/TuYang_StunBuff.TuYang_StunBuff_C'))

        --UGCLog.Log("[maoyu]TuYang_LightMovePurpleSkillActor_4_3:finallyDamage = ,SpeedValue =  " ,finallyDamage  ,self:GetInstigator().ActualSpeedValue)

        local Damage = finallyDamage + self:GetInstigator().ActualSpeedValue * 0.007


        --local WeakSelf = WeakObjectPtr(self)
        self.LightMovePurpleSkillActorTimer = Timer.InsertTimer(0.5,function()
            --local selfOwner = WeakSelf:Get()
            -- 添加有效性验证
            if not UE.IsValid(self) then
                UGCLog.Log("[maoyu] TuYang_LightMovePurpleSkillActor_4_3 已被销毁")
                return
            end
            
            if #self.OverlappingMonsters > 0 then
                for k, OverlappingMonster in pairs(self.OverlappingMonsters) do
                    --UGCLog.Log("[maoyu]TuYang_LightMovePurpleSkillActor_4_3:Character:", self:GetInstigator(),"OverlappingActor",OverlappingMonster)
    
                    if UE.IsValid(OverlappingMonster) then
                        --UGCLog.Log("[maoyu]TuYang_LightMovePurpleSkillActor_4_3:OverlappingActor:",OverlappingMonster)

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
                            Timer.InsertTimer(1, function()
                                -- 双重有效性验证
                                if UE.IsValid(OverlappingMonster) and UE.IsValid(Controlle) and Controlle.BrainComponent then
                                    Controlle.BrainComponent:RestartLogic()
                                end
                            end,false)
                        end

                        UGCGameSystem.ApplyDamage(OverlappingMonster, Damage, self:GetInstigatorController(), self:GetInstigator(),EDamageType.STPointDamage)
                    end
                    --if OverlappingActor ~= self:GetInstigator() then
                end
            end
        end,true)

        Timer.InsertTimer(2.0, function()
            self:EndDestroy()
        end,false)
    end
end

function TuYang_LightMovePurpleSkillActor_4_3:OnBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    if self:HasAuthority() then
        local BaseClass = UE.LoadClass('/Script/ShadowTrackerExtra.STExtraSimpleCharacter')
        local PlayerClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
        if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(OtherActor), BaseClass) then
            table.insert(self.OverlappingMonsters,OtherActor)
            --UGCLog.Log("[maoyu]:4_3:OnBeginOverlap:",OtherActor)
            --UGCLog.Log("[maoyu]:4_3:OnBeginOverlap:",self.OverlappingMonsters)
        end

        -- if KismetMathLibrary.ClassIsChildOf(GameplayStatics.GetObjectClass(OtherActor), PlayerClass) then
        --     table.insert(self.OverlappingPlayers,OtherActor)
        --     local origSpeedScale = UGCPawnAttrSystem.GetSpeedScale(OtherActor)
        --     UGCPawnAttrSystem.SetSpeedScale(OtherActor,origSpeedScale*1.15)
        --     --UGCLog.Log("[maoyu]:4_3:OnBeginOverlap:",OtherActor,"SpeedScale",UGCPawnAttrSystem.GetSpeedScale(OtherActor))
        -- end
    end
end

function TuYang_LightMovePurpleSkillActor_4_3:OnEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
    if self:HasAuthority() then
        if #totable(self.OverlappingMonsters) > 0 then
            for k, v in pairs(self.OverlappingMonsters) do
                if(OtherActor == v) then
                    table.remove(self.OverlappingMonsters,k)
                    --UGCLog.Log("[maoyu]:4_3:OnEndOverlap:",OtherActor)
                    --UGCLog.Log("[maoyu]:4_3:OnEndOverlap:",self.OverlappingMonsters)
                    return
                end
            end
        end

        -- if #totable(self.OverlappingPlayers) > 0 then
        --     for k, v in pairs(self.OverlappingPlayers) do
        --         if(OtherActor == v) then
        --             local origSpeedScale = UGCPawnAttrSystem.GetSpeedScale(OtherActor)
        --             UGCPawnAttrSystem.SetSpeedScale(OtherActor,origSpeedScale/1.15)
        --             table.remove(self.OverlappingPlayers,k)
        --             --UGCLog.Log("[maoyu]:4_3:OnEndOverlap:",OtherActor,"SpeedScale",UGCPawnAttrSystem.GetSpeedScale(OtherActor))
        --             return
        --         end
        --     end
        -- end
    end
end



function TuYang_LightMovePurpleSkillActor_4_3:ReceiveTick(DeltaTime)
    TuYang_LightMovePurpleSkillActor_4_3.SuperClass.ReceiveTick(self, DeltaTime)
    -- if self:HasAuthority() then
    --     if self:GetInstigator() then
    --         self:K2_SetActorLocation(self:GetInstigator():K2_GetActorLocation())
    --     end
    -- end
end

function TuYang_LightMovePurpleSkillActor_4_3:EndDestroy()
    Timer.RemoveTimer(self.LightMovePurpleSkillActorTimer)
    -- if #totable(self.OverlappingPlayers) > 0 then
    --     for k, v in pairs(self.OverlappingPlayers) do
    --         if v then
    --             local origSpeedScale = UGCPawnAttrSystem.GetSpeedScale(v)
    --             UGCPawnAttrSystem.SetSpeedScale(v,origSpeedScale/1.15)
    --             table.remove(self.OverlappingPlayers,k)
    --         end
    --     end
    -- end
    self.OverlappingMonsters = nil
    -- self.OverlappingPlayers = nil

end

function TuYang_LightMovePurpleSkillActor_4_3:ReceiveEndPlay()
    TuYang_LightMovePurpleSkillActor_4_3.SuperClass.ReceiveEndPlay(self) 
    self:EndDestroy()
end


--[[
function TuYang_LightMovePurpleSkillActor_4_3:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_LightMovePurpleSkillActor_4_3:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_LightMovePurpleSkillActor_4_3