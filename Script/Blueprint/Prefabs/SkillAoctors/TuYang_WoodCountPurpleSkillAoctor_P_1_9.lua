---@class TuYang_WoodCountPurpleSkillAoctor_P_1_9_C:AActor
---@field Sphere USphereComponent
---@field Scene USceneComponent
---@field ActorSequence UActorSequenceComponent
---@field P_Implosive UParticleSystemComponent
---@field Scene1 USceneComponent
---@field P_PveSlowGrenade UParticleSystemComponent
---@field CG013_bingdiao UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field Buff UClass
--Edit Below--
local TuYang_WoodCountPurpleSkillAoctor_P_1_9 = {}
 

function TuYang_WoodCountPurpleSkillAoctor_P_1_9:ReceiveBeginPlay()
    TuYang_WoodCountPurpleSkillAoctor_P_1_9.SuperClass.ReceiveBeginPlay(self)

    Timer.InsertTimer(1.5, function()
        self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self)
	    self.Sphere.OnComponentEndOverlap:Add(self.Sphere_OnComponentEndOverlap, self)
        local overlappingActors = {}
        self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C')))
        for _, actor in ipairs(overlappingActors) do
            -- UGCLog.Log("[maoyu]TuYang_WoodCountPurpleSkillAoctor_P_1_9 actor = ",actor)
            self:Sphere_OnComponentBeginOverlap(self.Sphere,actor,nil)
        end
    end, false)
end

function TuYang_WoodCountPurpleSkillAoctor_P_1_9:Sphere_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
	if self:HasAuthority() then
        local PlayPawnClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))

        if UE.IsA(OtherActor,PlayPawnClass) then
            -- 新增玩家追踪列表和计时器
            if not self.OverlappingPlayers then
                self.OverlappingPlayers = {}
                self.HealingTimers = {}
            end

            -- 如果玩家不在列表中则添加
            if not self.OverlappingPlayers[OtherActor] then
                self.OverlappingPlayers[OtherActor] = true

                -- 创建循环治疗计时器
                local HealingBuff = UGCPersistEffectSystem.AddBuffByClass(OtherActor, self.Buff)
                HealingBuff:SetApplyTime(5.0)
                self.HealingTimers[OtherActor] = Timer.InsertTimer(1.0, function()
                    if UE.IsValid(OtherActor) and OtherActor.Health < OtherActor.HealthMax then

                        OtherActor.Health = OtherActor.Health + (OtherActor.HealthMax * 0.02)
                    -- else
                    --     Timer.RemoveTimer(self.HealingTimers[OtherActor])
                    --     self.OverlappingPlayers[OtherActor] = nil
                    end
                end, true)
            end
        end
    end
end

function TuYang_WoodCountPurpleSkillAoctor_P_1_9:Sphere_OnComponentEndOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex)
	if self:HasAuthority() then
        -- 玩家离开时移除计时器
        if self.OverlappingPlayers and self.OverlappingPlayers[OtherActor] then
            Timer.RemoveTimer(self.HealingTimers[OtherActor])
            self.OverlappingPlayers[OtherActor] = nil
            self.HealingTimers[OtherActor] = nil
        end
    end
end


--[[
function TuYang_WoodCountPurpleSkillAoctor_P_1_9:ReceiveTick(DeltaTime)
    TuYang_WoodCountPurpleSkillAoctor_P_1_9.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function TuYang_WoodCountPurpleSkillAoctor_P_1_9:ReceiveEndPlay()
    TuYang_WoodCountPurpleSkillAoctor_P_1_9.SuperClass.ReceiveEndPlay(self) 
    if self.OverlappingPlayers and self.HealingTimers then
        for k, v in pairs(self.HealingTimers) do
            Timer.RemoveTimer(v)
        end
        self.OverlappingPlayers = nil
        self.HealingTimers = nil
    end
end


--[[
function TuYang_WoodCountPurpleSkillAoctor_P_1_9:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_WoodCountPurpleSkillAoctor_P_1_9:GetAvailableServerRPCs()
    return
end
--]]






return TuYang_WoodCountPurpleSkillAoctor_P_1_9