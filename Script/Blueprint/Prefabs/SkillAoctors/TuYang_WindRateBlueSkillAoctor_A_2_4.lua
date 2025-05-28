---@class TuYang_WindRateBlueSkillAoctor_A_2_4_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field Sphere2 USphereComponent
---@field Sphere USphereComponent
---@field DefaultSceneRoot USceneComponent
---@field Buff UClass
--Edit Below--
local TuYang_WindRateBlueSkillAoctor_A_2_4 = {}
 

function TuYang_WindRateBlueSkillAoctor_A_2_4:ReceiveBeginPlay()
    TuYang_WindRateBlueSkillAoctor_A_2_4.SuperClass.ReceiveBeginPlay(self)
    self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self);
    ugcprint("[maoyu]TuYang_WindRateBlueSkillAoctor_A_2_4: Log:ReceiveBeginPlay")

end


--[[
function TuYang_WindRateBlueSkillAoctor_A_2_4:ReceiveTick(DeltaTime)
    TuYang_WindRateBlueSkillAoctor_A_2_4.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_WindRateBlueSkillAoctor_A_2_4:ReceiveEndPlay()
    TuYang_WindRateBlueSkillAoctor_A_2_4.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_WindRateBlueSkillAoctor_A_2_4:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_WindRateBlueSkillAoctor_A_2_4:GetAvailableServerRPCs()
    return
end
--]]

function TuYang_WindRateBlueSkillAoctor_A_2_4:Sphere_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    local PlayPawnClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
    --UGCLog.Log("[maoyu] Sphere_OnComponentBeginOverlap" ,OtherActor )

    if UE.IsA(OtherActor,PlayPawnClass) then
        --ugcprint("[maoyu] Sphere_OnComponentBeginOverlap ISA")
        --if OtherActor.Health < OtherActor.HealthMax then
            
            -- 治疗
            local HealingBuff = UGCPersistEffectSystem.AddBuffByClass(OtherActor, self.Buff,nil,1.0,1)
            --HealingBuff:SetApplyTime(1.0)
            --OtherActor.Health = OtherActor.Health + 1.0
            if self:HasAuthority() then
                local curHealth = UGCPawnAttrSystem.GetHealth(OtherActor)
                UGCPawnAttrSystem.SetHealth(OtherActor, curHealth + 1.0)
            end
            self:SetActorHiddenInGame(true)
            self:K2_DestroyActor()
        --end
    end
end

return TuYang_WindRateBlueSkillAoctor_A_2_4