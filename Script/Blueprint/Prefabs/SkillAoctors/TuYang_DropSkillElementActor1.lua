---@class TuYang_DropSkillElementActor1_C:AActor
---@field P_Drop_Light_Green UParticleSystemComponent
---@field Sphere USphereComponent
---@field enemygold UParticleSystemComponent
---@field Scene USceneComponent
---@field StaticMesh UStaticMeshComponent
---@field ActorSequence UActorSequenceComponent
--Edit Below--
local TuYang_DropSkillElementActor1 = {}
 

local ParticleTemplate = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Prefabs/SkillEffectTD/P_Repository_CG30_PassiveSkills_Curing_01.P_Repository_CG30_PassiveSkills_Curing_01'))
        
local GoldSound = UE.LoadObject(UGCGameSystem.GetUGCResourcesFullPath('Asset/WwiseEvent/ASound_1.ASound_1'))

function TuYang_DropSkillElementActor1:ReceiveBeginPlay()
    TuYang_DropSkillElementActor1.SuperClass.ReceiveBeginPlay(self)
    Timer.InsertTimer(0.5,function()
        self.Sphere.OnComponentBeginOverlap:Add(self.Sphere_OnComponentBeginOverlap, self)
        local overlappingActors = {}
        self.Sphere:GetOverlappingActors(overlappingActors,UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C')))
        for _, actor in ipairs(overlappingActors) do
            self:Sphere_OnComponentBeginOverlap(self.Sphere,actor,nil)
        end
    end,false)
end

function TuYang_DropSkillElementActor1:ReceiveTick(DeltaTime)
    TuYang_DropSkillElementActor1.SuperClass.ReceiveTick(self, DeltaTime)
end

function TuYang_DropSkillElementActor1:ReceiveEndPlay()
    TuYang_DropSkillElementActor1.SuperClass.ReceiveEndPlay(self)
end


function TuYang_DropSkillElementActor1:Sphere_OnComponentBeginOverlap(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult)
    local PlayPawnClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/BPCharacter_ProtectAthena.BPCharacter_ProtectAthena_C'))
    --UGCLog.Log("[maoyu] Sphere_OnComponentBeginOverlap" ,OtherActor )

    if UE.IsA(OtherActor,PlayPawnClass) then
        ugcprint("[maoyu] Sphere_OnComponentBeginOverlap ISA")

        if not OtherActor.PlayerState then
            UGCLog.Log("[maoyu] TuYang_DropSkillElementActor1 OtherActor.PlayerState is nil")
            return
        end


        local PlayerState = OtherActor.PlayerState
        if self:HasAuthority() then
            -- 增加玩家技能碎片数量
            PlayerState:SetReconnectDataValue("iBuffSkillElement",PlayerState:GeReconnectDataValue("iBuffSkillElement") + 1)
            local curHealth = UGCPawnAttrSystem.GetHealth(OtherActor)
            UGCPawnAttrSystem.SetHealth(OtherActor, curHealth + 5.0)
        end

        
        STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleTemplate,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true)
        UGCSoundManagerSystem.PlaySoundAttachActor(GoldSound,self,false)
        self:SetActorHiddenInGame(true)
        self:K2_DestroyActor()
    end
end

--[[
function TuYang_DropSkillElementActor1:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_DropSkillElementActor1:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_DropSkillElementActor1