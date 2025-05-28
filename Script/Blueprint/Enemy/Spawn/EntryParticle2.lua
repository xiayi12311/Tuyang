---@class EntryParticle2_C:AActor
---@field P_MiniGames_Door_04 UParticleSystemComponent
---@field P_Montage_02 UParticleSystemComponent
---@field CG014_Version_2050_Mothership_Transfer UStaticMeshComponent
---@field ActorSequence UActorSequenceComponent
---@field P_Repository_Buff_TimeBomb_02 UParticleSystemComponent
---@field P_Repository_Buff_TimeBomb_01 UParticleSystemComponent
---@field P_CG03_Tent_hit_01 UParticleSystemComponent
---@field P_zombiebuilding_light_01 UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local EntryParticle = {}
local EntrySound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Spawnenemy1_1.Spawnenemy1_1'))
function EntryParticle:ReceiveBeginPlay()
    EntryParticle.SuperClass.ReceiveBeginPlay(self)
    ugcprint("Start Particle!")
    if not self:HasAuthority() then
        ugcprint("Start Particle")
        UGCSoundManagerSystem.PlaySoundAttachActor(EntrySound,self,true)
        local  Particle = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/P_Team_Season.P_Team_Season'))
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,Particle,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
    end
    
end


--[[
function EntryParticle:ReceiveTick(DeltaTime)
    EntryParticle.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function EntryParticle:ReceiveEndPlay()
    EntryParticle.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function EntryParticle:GetReplicatedProperties()
    return
end
--]]

--[[
function EntryParticle:GetAvailableServerRPCs()
    return
end
--]]

return EntryParticle