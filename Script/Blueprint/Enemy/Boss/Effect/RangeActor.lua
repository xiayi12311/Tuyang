---@class RangeActor_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local RangeActor = {}
 

function RangeActor:ReceiveBeginPlay()
    RangeActor.SuperClass.ReceiveBeginPlay(self)
    ugcprint("RangeActor Spawned")
    local location = self:K2_GetActorLocation();
    local ParticleSystem = UE.LoadObject(
                UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Monster/WhiteJiJia/Skill/P_Repository_Circle_01.P_Repository_Circle_01'))
    STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);	
end


--[[
function RangeActor:ReceiveTick(DeltaTime)
    RangeActor.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function RangeActor:ReceiveEndPlay()
    RangeActor.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function RangeActor:GetReplicatedProperties()
    return
end
--]]

--[[
function RangeActor:GetAvailableServerRPCs()
    return
end
--]]

return RangeActor