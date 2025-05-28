---@class TuYang_ProjectWarning_C:AActor
---@field ParticleSystem UParticleSystemComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local TuYang_ProjectWarning = {}
 

function TuYang_ProjectWarning:ReceiveBeginPlay()
    TuYang_ProjectWarning.SuperClass.ReceiveBeginPlay(self)
    ugcprint("TuYang_ProjectWarning Spawned")
    local location = self:K2_GetActorLocation();
    local ParticleSystem = UE.LoadObject(
    UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Monster/WhiteJiJia/Skill/P_Repository_Circle_01.P_Repository_Circle_01'))
    STExtraBlueprintFunctionLibrary.SpawnCustomEmitterAtLocation(self,ParticleSystem,self:K2_GetActorLocation(),self:K2_GetActorRotation(),true);	
end


--[[
function TuYang_ProjectWarning:ReceiveTick(DeltaTime)
    TuYang_ProjectWarning.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function TuYang_ProjectWarning:ReceiveEndPlay()
    TuYang_ProjectWarning.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function TuYang_ProjectWarning:GetReplicatedProperties()
    return
end
--]]

--[[
function TuYang_ProjectWarning:GetAvailableServerRPCs()
    return
end
--]]

return TuYang_ProjectWarning