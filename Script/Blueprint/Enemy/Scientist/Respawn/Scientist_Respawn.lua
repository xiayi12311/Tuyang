---@class Scientist_Respawn_C:AActor
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local Scientist_Respawn = {}
Scientist_Respawn.MonsterClass = UE.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Enemy/Scientist/Scientist.Scientist_C'))  
--[[
function Scientist_Respawn:ReceiveBeginPlay()
    Scientist_Respawn.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function Scientist_Respawn:ReceiveTick(DeltaTime)
    Scientist_Respawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]


function Scientist_Respawn:ReceiveEndPlay()
    Scientist_Respawn.SuperClass.ReceiveEndPlay(self) 
    if self:HasAuthority() then 
		local BP_Monster = ScriptGameplayStatics.SpawnActor(self,self.MonsterClass,self:K2_GetActorLocation(),{Roll = 0, Pitch = 0, Yaw = 0},{X = 1, Y = 1, Z = 1});
	end
end


--[[
function Scientist_Respawn:GetReplicatedProperties()
    return
end
--]]

--[[
function Scientist_Respawn:GetAvailableServerRPCs()
    return
end
--]]

return Scientist_Respawn