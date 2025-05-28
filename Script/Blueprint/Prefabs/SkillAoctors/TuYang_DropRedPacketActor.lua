---@class TuYang_DropRedPacketActor_C:AActor
---@field Sphere USphereComponent
---@field enemygold UParticleSystemComponent
---@field Scene USceneComponent
---@field StaticMesh UStaticMeshComponent
---@field ActorSequence UActorSequenceComponent
--Edit Below--
local TuYang_DropRedPacketActor = {}
 

function TuYang_DropRedPacketActor:ReceiveBeginPlay()
    TuYang_DropRedPacketActor.SuperClass.ReceiveBeginPlay(self)
	--self.Sphere.OnComponentHit:Add(self.Sphere_OnComponentHit, self);
    Timer.InsertTimer(0.5,function()
        self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self)
        UGCLog.Log("[maoyu] TuYang_DropRedPacketActor:ReceiveBeginPlay")
        local overlappingActors = {}
        self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C')))
        for _, actor in ipairs(overlappingActors) do
            self:Sphere_OnComponentBeginOverlap(self.Sphere,actor,nil)
        end
    end,false)
end


--[[
function TuYang_DropRedPacketActor:ReceiveTick(DeltaTime)
    TuYang_DropRedPacketActor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_DropRedPacketActor:ReceiveEndPlay()
    TuYang_DropRedPacketActor.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_DropRedPacketActor:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_DropRedPacketActor:GetAvailableServerRPCs()
    return
end
--]]

function TuYang_DropRedPacketActor:Sphere_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    local PlayPawnClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
    --UGCLog.Log("[maoyu] Sphere_OnComponentBeginOverlap" ,OtherActor )

    if UE.IsA(OtherActor,PlayPawnClass) then
        ugcprint("[maoyu] Sphere_OnComponentBeginOverlap ISA")
        if self:HasAuthority() then
            if OtherActor.Controller then
                -- 增加玩家金币数量
                OtherActor.Controller:ServerRPC_AddGoldNumber(50)
            end
        end

        local ParticleTemplate = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/EffectTD/enemygold.enemygold'))
        local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/Goldsound.Goldsound'))

        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleTemplate,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,false)

        --OtherActor.Controller:AddBuffSkills(self.Buff)
        self:SetActorHiddenInGame(true)
        self:K2_DestroyActor()
    end
end

return TuYang_DropRedPacketActor