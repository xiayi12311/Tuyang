---@class TuYang_TacticalBuffsKobe_C:AActor
---@field Ladder_Bottom_01 UStaticMeshComponent
---@field SK_VH_AH6 USkeletalMeshComponent
---@field ActorSequence UActorSequenceComponent
---@field P_CG03_Tent_hit_01 UParticleSystemComponent
---@field P_zombiebuilding_light_01 UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_TacticalBuffsKobe = {}
local EntrySound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Spawnenemy1_1.Spawnenemy1_1'))
function TuYang_TacticalBuffsKobe:ReceiveBeginPlay()
    TuYang_TacticalBuffsKobe.SuperClass.ReceiveBeginPlay(self)
    ugcprint("Start Particle!")
    if not self:HasAuthority() then
       -- ugcprint("Start Particle")
       -- UGCSoundManagerSystem.PlaySoundAttachActor(EntrySound,self,true)
        local  Particle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/P_Team_Season.P_Team_Season'))
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,Particle,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
    end
    
end


--[[
function TuYang_TacticalBuffsKobe:ReceiveTick(DeltaTime)
    TuYang_TacticalBuffsKobe.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_TacticalBuffsKobe:ReceiveEndPlay()
    TuYang_TacticalBuffsKobe.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_TacticalBuffsKobe:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_TacticalBuffsKobe:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_TacticalBuffsKobe